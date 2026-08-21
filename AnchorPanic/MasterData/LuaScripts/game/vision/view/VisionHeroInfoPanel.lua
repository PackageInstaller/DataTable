module("vision.VisionHeroInfoPanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("vision/VisionHeroInfoPanel.prefab")
destroyTime = 0
panelType = 1

function ctor(self)
    super.ctor(self)
    self:setTxtTitle( _TT(153206))
    self:setSize(0, 0)
    self:setBg("bg_01.jpg", false, "vision")

end

function initData(self)
    super.initData(self)
    self.mDupItemList = {}
    self.mTeamItemList = {}
    self.mHeroGridList = {}
end

function configUI(self)
    super.configUI(self)

    self.mHeroInfoScroll = self:getChildGO("mHeroInfoScroll"):GetComponent(ty.ScrollRect)
    self.mDupItem = self:getChildGO("mDupItem")
    self.mTeamItem = self:getChildGO("mTeamItem")
    self.mBtnFight = self:getChildGO("mBtnFight")
end

function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    self.mArgs = args or {}
    self.mDupVo = self.mArgs.dupVo
    self.mLayer = self.mArgs.layer
    -- currentClickId 即当前选中的层（与 VisionPanel.currentClickId 对齐，作为 checkFormationFight 的 cusDataId）
    self.currentClickId = self.mArgs.layer
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID })
    self:clearItemList()
    self.mArgs = nil
    self.mDupVo = nil
    self.mLayer = nil
    self.currentClickId = nil
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnFight, self.onBtnFightClick)
end

function updateView(self)
    self:clearItemList()

    local dupList = vision.VisionManager:getServerDupListByLayer(self.mLayer)
    if not dupList or #dupList <= 0 then
        dupList = { self.mDupVo and self.mDupVo.stageId or self.mLayer }
    end

    -- 队伍数量由服务器下发的 dupList 决定，与 FormationVisionPanel 保持一致（最多 3 支队伍）
    local teamCount = math.min(#dupList, 3)
    local teamIdList = {}
    for index = 1, teamCount do
        table.insert(teamIdList, formation.getTeamIdByDataType(formation.TYPE.VISION, index))
    end

    for index = 1, teamCount do
        local dupId = dupList[index]
        local dupVo = vision.VisionManager:getVisionMirrorStageDataById(dupId)
        local dupItem = SimpleInsItem:create(self.mDupItem, self.mHeroInfoScroll.content, "visionHeroInfoDupItem")
        self:updateDupItem(dupItem, dupVo, index)
        -- 当前关卡的服务器分数：从 pt_pass_vision_mirror_layer.dup_list 中按 dup_id 命中
        local curScore = vision.VisionManager:getServerScoreByLayerAndDupId(self.mLayer, dupId)
        dupItem:getChildGO("mTxtScore"):GetComponent(ty.Text).text = _TT(153216, curScore, dupVo.limitPoint)
        dupItem:getChildGO("mTxtInfo"):GetComponent(ty.Text).text = _TT(153211)
        self:updateTeamList(dupItem, teamIdList[index])

        dupItem:addUIEvent("mBtnAnemy", function()
            self:onBtnAnemyClick(dupVo)
        end)
        table.insert(self.mDupItemList, dupItem)
    end

    -- 记录当前选中关卡（玩家点击进入本界面的那一关）对应的队伍，作为默认选中队伍
    self.mDupTeamId = nil
    local selectStageId = self.mDupVo and self.mDupVo.stageId
    for index = 1, teamCount do
        if dupList[index] == selectStageId then
            self.mDupTeamId = teamIdList[index]
            break
        end
    end
    -- 兜底：选中关卡不在 dupList 中时，默认取第一支队伍
    if not self.mDupTeamId then
        self.mDupTeamId = teamIdList[1]
    end
end

-- 将指定队伍置为出战列表首位，使阵型面板默认选中该队伍（保留全部队伍，仅调整默认选中）
function setDefaultTeam(self, teamId)
    if not teamId or teamId == 0 then
        return
    end
    local Manager = formation.FormationManager
    local fightList = Manager.m_fightTeamIdList
    -- 阵型尚未初始化（出战列表为空）时，用服务器 dupList 生成的队伍列表兜底。
    -- 注意：此处必须显式用 self.mLayer 作为 dataId，而不能用 getAllTeamIdList()
    -- （其依赖 getDataId()，此时 openFormation 尚未调用、m_dataId 仍是上一次/初始值，
    -- 会导致 getTeamIdListByType 取到错误的层）。dataId 应严格对应当前 layer。
    if not fightList or #fightList == 0 then
        fightList = formation.getTeamIdListByType(formation.TYPE.VISION, self.mLayer)
    end
    if fightList and #fightList > 0 then
        local newList = { teamId }
        for _, id in ipairs(fightList) do
            if id ~= teamId then
                table.insert(newList, id)
            end
        end
        Manager.m_fightTeamIdList = newList
    end
end

function updateDupItem(self, dupItem, dupVo, index)
   dupItem:getChildGO("mTxtName"):GetComponent(ty.Text).text =  _TT(153203,index)
end

function updateTeamList(self, dupItem, teamId)
    local heroContent = dupItem:getChildTrans("mHeroContent")
    local formationHeroList = teamId and formation.FormationVisionManager:getSelectFormationHeroList(teamId) or {}
    -- 英雄不按 heroPos 摆放，直接把有英雄的从左到右依次排列，后面空位显示 null
    local heroVoList = {}
    for _, formationHeroVo in pairs(formationHeroList) do
        if formationHeroVo and formationHeroVo.heroId and formationHeroVo.heroId ~= 0 then
            table.insert(heroVoList, formationHeroVo)
        end
    end
    for pos = 1, 5 do
        local teamItem = SimpleInsItem:create(self.mTeamItem, heroContent, "visionHeroInfoTeamItem")
        local formationHeroVo = heroVoList[pos]
        self:updateTeamItem(teamItem, formationHeroVo,teamId)
        -- 点击队伍格子，打开对应的阵型并定位到该队伍
        self:addUIEvent(teamItem:getGo(), function()
            self:onTeamItemClick(teamId)
        end)
        table.insert(self.mTeamItemList, teamItem)
    end
end

-- 点击队伍格子：打开 VISION 阵型界面，并将对应队伍置为默认选中
function onTeamItemClick(self, teamId)
    if not teamId or teamId == 0 then
        return
    end


    self:setDefaultTeam(teamId)
    -- 进入阵型前先把当前层数写入 VisionManager，供 FormationVisionPanel 直接取用（避免 m_dataId 取不到）
    vision.VisionManager:setCurVisionLayer(self.currentClickId)

     formation.checkFormationFight(
        self.mArgs.battleType or PreFightBattleType.Vision,
        self.mArgs.dupType or DupType.Vision,
        self.mDupVo.stageId,
        self.mArgs.formationType or formation.TYPE.VISION,
        self.currentClickId,
        nil,
        nil
    )

    --formation.openFormation(formation.TYPE.VISION, self.currentClickId, nil, nil)
    self:close()
end

function updateTeamItem(self, teamItem, formationHeroVo,teamId)
    local isHasHero = formationHeroVo ~= nil and formationHeroVo.heroId ~= nil and formationHeroVo.heroId ~= 0
    self:setItemGoActive(teamItem, "mIsHidden", false)
    self:setItemGoActive(teamItem, "mIsNull", not isHasHero)

    if isHasHero then
        local heroVo = hero.HeroManager:getHeroVo(formationHeroVo.heroId)
        if heroVo then
            local grid = HeroHeadGrid:poolGet()
            -- 等资源加载完成后，把 HeroHeadGrid 根 GO 的点击监听绑定为本面板的队伍点击逻辑（onTeamItemClick）。
            -- HeroHeadGrid 自身无 Button、不处理点击，直接给它加监听即可让点击英雄头像（盖在队伍格子上层）
            -- 也打开对应阵型并定位队伍，避免其 Image 拦截射线导致 teamItem 收不到点击。
            grid:setData(hero.HeroManager:getHeroConfigVo(heroVo.tid), nil, function()
                local trans = grid:getTrans()
                if trans and not gs.GoUtil.IsGoNull(trans.gameObject) then
                    self:addUIEvent(trans.gameObject, function() self:onTeamItemClick(teamId) end)
                end
            end)
            grid:setStarLvl(heroVo.evolutionLvl)
            grid:setLvl(heroVo.lvl)
            grid:setType(true)
            grid:setEleType(true)
            grid:setParent(teamItem:getChildTrans("mHeroHeadContent"))
            grid:setRes(true)
            table.insert(self.mHeroGridList, grid)
        end
    end
end

function getFormationHeroVoByPos(self, formationHeroList, pos)
    for _, formationHeroVo in pairs(formationHeroList or {}) do
        if formationHeroVo.heroPos == pos then
            return formationHeroVo
        end
    end
end


function setItemGoActive(self, item, name, isActive)
    local isOk, go = pcall(function()
        return item:getChildGO(name)
    end)
    if isOk and go then
        go:SetActive(isActive)
    end
end

function clearItemList(self)
    for i = 1, #self.mHeroGridList do
        self.mHeroGridList[i]:poolRecover()
    end
    self.mHeroGridList = {}

    for i = 1, #self.mTeamItemList do
        self.mTeamItemList[i]:poolRecover()
    end
    self.mTeamItemList = {}

    for i = 1, #self.mDupItemList do
        self.mDupItemList[i]:poolRecover()
    end
    self.mDupItemList = {}
end

function onBtnFightClick(self)
    if not self.mDupVo then
        return
    end

    -- 默认选中玩家进入本界面时选择的关卡对应的队伍
    self:setDefaultTeam(self.mDupTeamId)

    -- 进入阵型前先把当前层数写入 VisionManager，供 FormationVisionPanel 直接取用（避免 m_dataId 取不到）
    vision.VisionManager:setCurVisionLayer(self.currentClickId)
    -- 参照 VisionPanel：battleType/dupType/dupId/formationType 走 mArgs，cusDataId 用当前选中层 currentClickId
    formation.checkFormationFight(
        self.mArgs.battleType or PreFightBattleType.Vision,
        self.mArgs.dupType or DupType.Vision,
        self.mDupVo.stageId,
        self.mArgs.formationType or formation.TYPE.VISION,
        self.currentClickId,
        nil,
        nil
    )
    self:close()
end

-- 点击敌方预览按钮：打开对应的敌方阵型预览界面
function onBtnAnemyClick(self, dupVo)
    if not dupVo then
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_FORMATION_PREVIEW, { dupVo = dupVo })
end

return _M

