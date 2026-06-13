local BaseDormAction = BaseClass("BaseDormAction")
local M = BaseDormAction

function M:__init(heroId)
    self.heroId = heroId
    self.module = ModuleMgr:GetInstance():GetCurrentModule()
    self.rshd = IRoleStudioHeroDataMgr:GetRoleStudioDataById(self.heroId)
    self.state = DormConst.RoleState.None
    self.maxLoveValue = GameHelper.GetParamters(271)[0]
    self.actionTimes = 0
    self:Init()
    self.isCalling = false
end

function M:Init()

end

function M:RoleCommand(type)
    if type == DormConst.DormRouletteType.Greet then
        self:InteractiveGreet(type)
        return
    end

    if type == DormConst.DormRouletteType.Gift then
        DormHelper.CommanderEnterGift(Bind(self, self.EnterGiftCallback))
        if self.commandAction then
            self.commandAction:Dispose()
        end

        self.commandAction = nil
        return
    end

    if type == DormConst.DormRouletteType.DressUp then
        --新版更换家具入口
        self:EnterDressUp()
        return
    end

    if type == DormConst.DormRouletteType.Main then
        if DormHelper.GetCurrentWatchPointFurnitureName() ~= "Main" then
            self:CommanderMoveToFurniture("Main")
        end
        return
    end
end

--邀请角色过来
function M:InteractiveGreet(type)
    --判断角色是否在与当前家具交互
    if DormHelper.IsInCurrentFurniturePos() == false then
        self.isCalling = true
        DormHelper.AgreeCall(Bind(self, self.CallGirlCallback))
        EventMgr:Broadcast(UIMessageNames.DORM_CONCEAL_DORM, false)
        local dataValues = { tostring(1) }
        IBuriedPointDataMgr:SubmitData(BuriedPointConst.Interaction, dataValues)
    end
end

--进入布置主界面回调
function M:EnterDressUp()
    UIContextMgr:GetInstance():Close("Dorm")
    UIContextMgr:GetInstance():Show("DormitoryDressupUI")
    self.module:OnUpdateSweepMachine(true)
end

--进入送礼回调
function M:EnterGiftCallback()
    DormHelper.SetFreeLookCamera(false)
    DormHelper.RoleAfk(false)
    UIContextMgr:GetInstance():Close("Dorm")
    UIContextMgr:GetInstance():Show("DormGift", self.rshd.heroId, function()
        self:CommanderMoveToFurniture("Main")
        UIContextMgr:GetInstance():Show("Dorm", self.module.roleStudio)
    end)
end

--进入交互界面
function M:EnterInteract()
    --主机位特殊处理
    if DormHelper.GetCurrentWatchPointFurnitureName() ~= "Main" then
        DormHelper.SetZoomInOut(true)
    else
        DormHelper.MoveCamera("FocusBlend")
    end
    DormHelper.RoleAfk(false)
    DormHelper.SetFreeLookCamera(false)
    UIContextMgr:GetInstance():Close("Dorm")
    UIContextMgr:GetInstance():Show("DormInteractUI", self.heroId)
end

--互动点击演出
function M:PlayRandomClick(furnitureType, furnitureId, curFuritureData)
    self.actioncfg = nil
    self.isSpecial = false
    self.actioncfg, self.isSpecial = DormHelper.GetRandomClickAction(self.heroId, furnitureType, furnitureId, self.actionTimes)
    if self.actioncfg then
        DormDataMgr:RequestDormInteract(self.heroId)
        self.actionTimes = self.actionTimes + 1
        local addLoveValue = 0
        if #self.actioncfg.lovePower > 0 then
            addLoveValue = Mathf.Random(self.actioncfg.lovePower[1], self.actioncfg.lovePower[2])
        end
        --刷新爱心值
        local loveValue = self.rshd:GetLoveValue()
        if loveValue < 100 then
            DormDataMgr:RequestRefreshLoveValue(self.heroId, addLoveValue, self.actioncfg.id)
        end
        if self.actioncfg.Type == DormConst.RandomClickType.Action or self.actioncfg.Type == DormConst.RandomClickType.RepetitionAction then
            local cfg = ConfigHelper.GetCfgByLua("homeAction", self.actioncfg.action)
            if cfg then
                DormHelper.PlayAction(curFuritureData, cfg.name, function()
                    DormHelper.SetRandomShow(true)
                end, cfg.TalkId)
                return
            end
        end

        if self.actioncfg.Type == DormConst.RandomClickType.Story then
            UIContextMgr:GetInstance():Show("SpecialEventStory", self.heroId, DormConst.StoryType.InteractStory,
            self.actioncfg.action, function()
                DormHelper.SetRandomShow(true)
            end)
        end

        if self.actioncfg.Type == DormConst.RandomClickType.RewardStory then
            UIContextMgr:GetInstance():Show("SpecialEventStory", self.heroId, DormConst.StoryType.InteractRewardStory,
            self.actioncfg.action, function()
            DormHelper.SetRandomShow(true)
            end)
        end

        if self.actioncfg.Type == DormConst.RandomClickType.Timeline then
            local timelineId = DormHelper.GetTimelineId(self.heroId, self.actioncfg.action)
            local cfg = ConfigHelper.GetCfgByLua("timeline", timelineId)
            local furnitures = {}
            --获取隐藏家具
            if #cfg.furnitureId > 0 then
                self._module = ModuleMgr:GetInstance():GetCurrentModule()
                for key, value in pairs(cfg.furnitureId) do
                    local furniture = self._module:GetFurniture(value)
                    if furniture then
                        table.insert(furnitures, furniture.gameObj)
                    end
                end
            end

            DormHelper.PlayTimeline(cfg.id, furnitures, function()
                UIContextMgr:GetInstance():Close("DormInteractUI")
                UIContextMgr:GetInstance():Show("Dorm")
                if #cfg.dormParams > 0 then
                    self.timelineParms = MapUtil.Find(DormConst.TimelineParms, function(c)
                        return c.type == cfg.dormParams[1]
                    end)
                    self.actionParms = cfg.dormParams[2]
                    if self.timelineParms then
                        local currentFurnitureName = DormHelper.GetCurrentFurnitureName()
                        if currentFurnitureName == self.timelineParms.furniture then
                            DormHelper.SetRandomShow(true)
                            DormDataMgr:RequestLoveValueAward(self.heroId, 0, self.actioncfg.id , nil, nil, nil, Bind(self, self.LoveValueAwardCallBack))
                        else
                            DormHelper.SetRoleAndCamera(self.timelineParms.furniture, self.timelineParms.watchPoint,
                                Bind(self, self.TimelineCallBack))
                        end
                    end
                end
            end)
            return
        end
    end
end

function M:TimelineCallBack(data)
    self:SwitchFurnitureAction(self.timelineParms.furniture, data)
    if self.actionParms > 0 then
        local curFuritureData = DormHelper.GetCurrentFurnitureData()
        DormHelper.PlayActionById(curFuritureData, self.actionParms)
    end
    DormHelper.SetRandomShow(true)
    self.timelineParms = nil
    self.actionParms = nil
    DormDataMgr:RequestLoveValueAward(self.heroId, 0, self.actioncfg.id , nil, nil, nil, Bind(self, self.LoveValueAwardCallBack))
end

function M:LoveValueAwardCallBack(msg)
    if  #msg.Awards > 0 then
        GameHelper.ShowGetItemsByItems(msg.Awards,function()
            local itemDic = {}
            for _, item in ipairs(msg.FlipCardAward or {}) do
                local num = itemDic[item.Id] or 0
                itemDic[item.Id] = item.Cnt + num
            end
            GameHelper.DormItemTips(itemDic,true)
        end)
    else
        local itemDic = {}
        for _, item in ipairs(msg.FlipCardAward or {}) do
            local num = itemDic[item.Id] or 0
            itemDic[item.Id] = item.Cnt + num
        end
        GameHelper.DormItemTips(itemDic,true)
    end
end

function M:OnExitCommonder()
end

function M:Dispose()
    self.state = DormConst.RoleState.None
    self.heroId = nil
    self.actionTimes = 0
end

return BaseDormAction
