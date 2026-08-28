--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyDialog140004.prefab > name: ActivityMonopolyDialog140004
---@class ActivityThrowDiceMainDialog
---@field Env                           	ActivityThrowDiceMainDialog             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field RewardIconNode                	UnityEngine.UI.ScrollRect               	@ 0    
---@field StartingPoint                 	UnityEngine.RectTransform               	@ 1    
---@field ActivityMonopolyRoleNode      	UnityEngine.RectTransform               	@ 2    
---@field ImgRole                       	UnityEngine.RectTransform               	@ 3    
---@field BtnMonopoly                   	UnityEngine.RectTransform               	@ 4    
---@field UIFX_Boom                     	UnityEngine.RectTransform               	@ 5    
---@field UIFX_MoveTrail                	UnityEngine.RectTransform               	@ 6    
---@field UIFX_StartGlow                	UnityEngine.RectTransform               	@ 7    
---@field BtnAnimationRoot              	UnityEngine.RectTransform               	@ 8    
---@field UIFX_Buffglow                 	UnityEngine.RectTransform               	@ 9    
---@field BtnBuff                       	UnityEngine.RectTransform               	@ 10   
---@field VertContent                   	UnityEngine.RectTransform               	@ 11   
---@field RewardCell1                   	UnityEngine.RectTransform               	@ 12   
---@field BossDrawingNode               	Game.Native.Common.DrawingNode          	@ 13   
---@field CommonGoodsListLight          	UnityEngine.RectTransform               	@ 14   
---@field BtnRoleNameNode               	UnityEngine.RectTransform               	@ 15   
---@field TxtTitle1                     	UnityEngine.RectTransform               	@ 16   
---@field TxtTitle2                     	UnityEngine.RectTransform               	@ 17   
---@field ThrowDiceTxtNum               	UnityEngine.RectTransform               	@ 18   
---@field TxtMonopolyNum                	UnityEngine.RectTransform               	@ 19   
---@field BtnReward                     	UnityEngine.RectTransform               	@ 20   
---@field UIFX_CloudChange              	UnityEngine.RectTransform               	@ 21   
---@field ImgBgNoHave                   	UnityEngine.RectTransform               	@ 22   
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 23   
---@field TurnTxtTime                   	UnityEngine.RectTransform               	@ 24   
---@field ImgTitleName                  	UnityEngine.RectTransform               	@ 25   
---@field ActvityTxtTime                	UnityEngine.RectTransform               	@ 26   
---@field ActivityDescrText             	UnityEngine.RectTransform               	@ 27   
---@field BtnTips                       	UnityEngine.RectTransform               	@ 28   
---@field MonopolyNum                   	UnityEngine.RectTransform               	@ 29   
---@field redPoint                      	UnityEngine.RectTransform               	@ 30   
---@field Role                          	UnityEngine.RectTransform               	@ 31   
---@field Props                         	UnityEngine.RectTransform               	@ 32   
---@field OptionalGiftGoodNode          	UnityEngine.RectTransform               	@ 33   
---@field OptionalTxtDesc               	UnityEngine.RectTransform               	@ 34   
---@field ImgPropsIcon                  	UnityEngine.RectTransform               	@ 35   
local ActivityThrowDiceMainDialog = Class('ActivityThrowDiceMainDialog')
---@type GachaponUtils
local GachapontUtils = import("Game.Gachapon.GachaponUtils")
local KTool = CS.Engine.Lib.KTool
local UIModule = CS.Engine.UI.UIModule
local KCookie = CS.Engine.Lib.KCookie
local Yielders = CS.Engine.Lib.Yielders
local cs_coroutine = import('XLua.cs_coroutine')
local POS_20 = {
    [1] = Vector3(130,391,0),
    [2] = Vector3(246,311,0),
    [3] = Vector3(362,231.0001,0),
    [4] = Vector3(491,311,0),
    [5] = Vector3(620,391,0),
    [6] = Vector3(504,471,0),
    [7] = Vector3(388,551,0),
    [8] = Vector3(517,631,0),
    [9] = Vector3(646,711,0),
    [10] = Vector3(774,818,0),
    [11] = Vector3(891,711,0),
    [12] = Vector3(1007,631,0),
    [13] = Vector3(1123,551,0),
    [14] = Vector3(994,471,0),
    [15] = Vector3(865,391,0),
    [16] = Vector3(981,311,0),
    [17] = Vector3(1097,231.0001,0),
    [18] = Vector3(1226,311,0),
    [19] = Vector3(1355,391,0),
    [20] = Vector3(1484,498,0),
}
function ActivityThrowDiceMainDialog:__init()
    self.co = nil
    self.preTurn = 1  -- 前一个轮数
    self.preCellNum = 0 -- 当前点的层数    
    self.preBuffId = 0
    self.nowTurn = 1 
    self.nowCellNum = 0 
    self.buffId = 0 
    self.triggerBuffs = {}
    self.config = {}
    self.nowCellNum = 0
    self._activityDojo = nil
    self.isAnimation = false
    self.sequence = nil
    self.nowBuffId = 0
    self.jumpMaps = {}  -- 跳转地图
    self.currentVoRewards = {}
    self.chooseBuffHandler = Events.AddListener("ActivityThrowDiceBuffEffect" , Bind(self, self.ChooseBuffEvent))
    self.goodsChangeEvent = Events.AddListener(Constants.EventNames.EveryThingChangeEventName,Bind(self,self.UpdateEngry))
end

function ActivityThrowDiceMainDialog:__delete()
    self.co = nil
    self.preTurn = nil
    self.preCellNum = nil -- 当前点的层数   
    self.preBuffId = nil 
    self.nowTurn = nil
    self.nowCellNum = nil
    self.buffId = nil
    self.triggerBuffs = nil
    self.nowCellNum = nil
    self.isAnimation = nil
    self._activityDojo = nil
    self.sequence = nil
    self.jumpMaps = nil  -- 跳转地图
    self.currentVoRewards = nil
    self.config = nil
    self.nowBuffId = nil
    if isNotNull(self.chooseBuffHandler)  then
        Events.RemoveListener("ActivityThrowDiceBuffEffect" , self.chooseBuffHandler)
        self.chooseBuffHandler = nil
    end
    if isNotNull(self.goodsChangeEvent)  then
        Events.RemoveListener(Constants.EventNames.EveryThingChangeEventName , self.goodsChangeEvent)
        self.goodsChangeEvent = nil
    end
end

function ActivityThrowDiceMainDialog:Awake()
    local scrollRect =  self.RewardIconNode.transform:GetComponent(typeof(CS.UnityEngine.UI.ScrollRect))
    scrollRect.onValueChanged:AddListener(Bind(self, self.OnScrollValueChanged))
    SetButtonAction(self.BtnMonopoly , function ()
        if isNull(self.currentVoRewards) or table.count(self.currentVoRewards) == 0 then
            return
        end
        if self.isAnimation  then
            return
        end 
        if self.nowTurn >= self.config.turn and self.nowCellNum >= self.config.totalCellNum then
            GameUtils.Toast(localize("已经完成前进之路"))
            return
        end
        self:UpdateHurl()
    end)
    SetButtonAction(self.BtnBuff, function ()
        if checkInt(self.nowBuffId) == 0 then
            GameUtils.Toast(localize("暂无增益"))
            return
        end
        UIModule.OpenDialog({  id = Constants.UITypeIds.ActivityThrowDiceBuffEffectDialog,
        parameters = {
            triggerBuffs = {self.nowBuffId} , 
            activityUuid = self._activityDojo.id 
        }})
    end)
    SetButtonAction(self.BtnReward , function ()
        UIModule.OpenDialog({  id = Constants.UITypeIds.ActivityThrowDiceTaskDialog,
        parameters = {
            activityUuid = self._activityDojo.id , 
            closeCallBack = Bind(self , self.UpdateRedPoint)
        }})
    end)
    SetButtonAction(self.BtnTips , function ()
        if checkInt(self.config.ruleId) > 0 then            
            CfUtils.ShowModuleToast(self.config.ruleId)
        end
    end)
end

function ActivityThrowDiceMainDialog:UpdateEngry()
    self:UpdateCallTime()
end

-- 左右拖动屏幕
function ActivityThrowDiceMainDialog:OnScrollValueChanged(normalizedPosition)
end

function ActivityThrowDiceMainDialog:Start()

end

function ActivityThrowDiceMainDialog:GetCurrentVo()
    local groupId = checkInt(self.config.groupId)
    local nowTurn = self.nowTurn
    ---@type ThrowDiceRewardsVo[]
    local ThrowDiceRewardsVos = CfUtils.GetWholeVo(AutoIds.IdSetting6600 , "ThrowDiceRewardsVo")
    local currentVos = {}
    local isBegin = false
    for voIndex, throwDiceRewardsVo in ipairs(ThrowDiceRewardsVos) do
        if throwDiceRewardsVo.groupId == groupId and throwDiceRewardsVo.turn == nowTurn  then
            isBegin = true
            currentVos[#currentVos+1] = throwDiceRewardsVo
        elseif isBegin then
            break
        end
    end
    return currentVos
end

--region public
---刷新自身
---@param activityDojo ActivityDojo
function ActivityThrowDiceMainDialog:Refresh(activityDojo)
    self._activityDojo = activityDojo
    if isNull(self._activityDojo) then return end
    self:RefreshUI()
end
function ActivityThrowDiceMainDialog:RefreshUI()
    GameUtils.Request(Interfaces.ActivityEvolveRoadHome ,  { activityUuid =  self._activityDojo.id} ,function (request, response)
        if checkNumber(response.errCode) ~= 0 then
            return
        end
        -- local data = table.deserialize([[{"config":{"id":1,"groupId":101,"prefab":0,"name":"\u8fdb\u5316\u4e4b\u5854","turn":9,"unlock":[],"totalCellNum":200,"energyId":9000060,"itemNumCost":1,"ruleId":0},"nowTurn":6,"nowCellNum":198,"nowBuffId":108,"triggerBuffs":[],"questGradeTaskProgress":[]}]])  -- checkTable(response.data) -- response.data 
        local data = response.data 
        -- local data = response.data 
        self.nowTurn = checkInt(data.nowTurn) 
        self.nowBuffId = checkInt(data.nowBuffId) 
        self.nowCellNum = data.nowCellNum
        self.config = data.config 
        if checkInt(self.nowTurn) > checkInt(self.config.turn) then
            self.nowTurn = self.config.turn 
            self.nowCellNum = self.config.totalCellNum
        end
        CfUtils.RefreshTopGoods({ self.config.energyId })
        if isNotNull(data.triggerBuffs) then
            self.triggerBuffs =  data.triggerBuffs 
        else 
            self.triggerBuffs = {}
        end
        self.currentVoRewards = self:GetCurrentVo()
        if #self.triggerBuffs > 0 then
            UIModule.OpenDialog({  id = Constants.UITypeIds.ActivityThrowDiceBuffEffectDialog,
            parameters = {
                triggerBuffs = self.triggerBuffs , 
                activityUuid = self._activityDojo.id 
            }})
        end
        self:InitUI()
    end)
end

function ActivityThrowDiceMainDialog:InitUI(isMove)
   self:InitRightUI()
   self:InitList(isMove)
   self:InitBuff()
   self:UpdateRedPoint()
end

function ActivityThrowDiceMainDialog:InitBuff()
    if checkInt(self.nowBuffId) > 0 then
        ---@type ThrowDiceBuffEffectVo
        local vo =  CfUtils.GetCfVo(AutoIds.IdSetting6601 , "ThrowDiceBuffEffectVo" , self.nowBuffId)
        KTool.SetActive(self.ImgIcon , true)
        KTool.SetActive(self.ImgBgNoHave , false)
        CfUtils.FillImage(self.ImgIcon , CfUtils.GetImageFullPath(vo.Icon))
    else
        KTool.SetActive(self.ImgIcon , false)
        KTool.SetActive(self.ImgBgNoHave , true)
    end 
end
function ActivityThrowDiceMainDialog:InitList(isMove)
    if isMove ~=  false then
        isMove = true
    end
    if self.co  then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    self.co =  cs_coroutine.start(function ()
        for i = 1, 10 do
            local RewardCell = self.VertContent.transform:Find("RewardCell" .. i)
            if isNull(RewardCell) then
                local oneRewardCell = self.VertContent.transform:Find("RewardCell" .. 1)
                RewardCell = CfUtils.InstantiateGo(oneRewardCell , oneRewardCell.transform.parent)
                RewardCell.name = "RewardCell" .. i
            end
            if not KTool.IsActive(RewardCell) then
                KTool.SetActive(RewardCell , true)    
            end
            RewardCell.transform:SetSiblingIndex(i+2)
            ---@type ActivityThrowDiceRewardCell
            local ActivityThrowDiceRewardCell = CfUtils.GetLuaScr(RewardCell , "Game.Activity.ThrowDice.ActivityThrowDiceRewardCell")
            if not isMove then
                ActivityThrowDiceRewardCell:RefreshUI(0 , i , self.currentVoRewards)
            else     
                ActivityThrowDiceRewardCell:RefreshUI(self.nowCellNum , i , self.currentVoRewards , self.config.buffGoodsId )
            end
            
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(Yielders.EndOfFrame))
        end
        if isMove  then
            if self.nowCellNum == 0  then
                self.ActivityMonopolyRoleNode.transform.localPosition = Vector3(124,151,0)
            else
                self.ActivityMonopolyRoleNode.transform.localPosition = self:GetRoleLocalPos(self.nowCellNum)        
            end
            if self.nowCellNum  < 10  then
                self.RewardIconNode.horizontalNormalizedPosition = 0
            else     
                self.RewardIconNode.horizontalNormalizedPosition = self:GetHorizontalNormalizedPosition(self.nowCellNum)
            end 
        end
    end)
end

function ActivityThrowDiceMainDialog:InitRightUI()
    local count = #self.currentVoRewards
    ---@type ThrowDiceRewardsVo
    local ThrowDiceRewardsVo = self.currentVoRewards[count]
    local rewardData =  ThrowDiceRewardsVo.rewardData
    local noCardSkinData = {}
    local cardData = nil
    for k, v in pairs(rewardData) do
        local goodsType = GoodsUtils.GetIdType(v.goodsId)
        if goodsType == Constants.IDType.CharacterCard or
         goodsType == Constants.IDType.CardSkin or 
         goodsType == Constants.IDType.OptionalGift
          then
            cardData = v 
            cardData.type = goodsType
        else
            noCardSkinData[#noCardSkinData+1]  = v  
        end
    end
    if isNotNull(cardData) then
        if cardData.type == Constants.IDType.CharacterCard  then
            CfUtils.SetActive(self.Role.gameObject , true)
            CfUtils.SetActive(self.Props.gameObject , false)
            local vo = CardConfMgr:GetInstance():GetCardByRefId(cardData.goodsId)
            self.BossDrawingNode:Execute(vo.defaultSkin)      
            ---@type CommonBtnRoleNameNode
            local scr = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
            scr:RefreshSelf(cardData.goodsId, vo.rare, function()
                KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._activityDojo.id)
                xTry(function()
                    GachapontUtils.OpenDetail(cardData.goodsId, { { id = Constants.UITypeIds.UIActivityMainDialog } })
                end)
            end)
        elseif cardData.type == Constants.IDType.OptionalGift then
            CfUtils.SetActive(self.Role.gameObject , false)
            CfUtils.SetActive(self.Props.gameObject , true) 
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(cardData.goodsId)
            CfUtils.FillText(self.OptionalTxtDesc , goodsVo.desc) 
            local scr = CfUtils.GetLuaScr(self.OptionalGiftGoodNode, "Game.Behaviours.GoodNodeMB")
            scr:Reload({
            goodsId = cardData.goodsId,
            isShowNo = true,
            text = "x" .. cardData.num,
            })
            scr:SetClickButtonAction(function()
                local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(cardData.goodsId)
                if isTable(vo) then
                    GameUtils.ShowCommonTipsBoard(self.OptionalGiftGoodNode, vo.name, vo.desc, vo.quality, vo.id)
                end
            end)
            CfUtils.FillImage(self.ImgPropsIcon, CfUtils.GetImageFullPath(self.config.photoId)) 
        else 
            CfUtils.SetActive(self.Role.gameObject , true)
            CfUtils.SetActive(self.Props.gameObject , false) 
            ---@type CommonBtnRoleNameNode
            local env = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
            if env then
                KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self._activityDojo.id)
                xTry(function()
                    GachapontUtils.OpenDetail(cardData.goodsId, { { id = Constants.UITypeIds.UIActivityMainDialog } })
                end)
            end    
            self.BossDrawingNode:Execute(cardData.goodsId)
        end        
    end
    CfUtils.RefreshCommonGoodsListLight(self.CommonGoodsListLight,noCardSkinData)
    local ActivityUtils = import("Game.Activity.ActivityUtils")
    CfUtils.FillText(self.ActvityTxtTime, ActivityUtils.ConventActivityDurationTime(self._activityDojo.startTime, self._activityDojo.endTime))
    CfUtils.FillText(self.ActivityDescrText, self._activityDojo.detail)
    CfUtils.FillText(self.TurnTxtTime , localize("第_num_轮" , {_num_ = self.nowTurn}))
    local titleImgUrl = checkString(self._activityDojo.titleImage)
    if string.len(titleImgUrl) > 0 then
        CfUtils.FillWebRawImage(self.ImgTitleName, titleImgUrl)
    end
    self:UpdateCallTime()
end

function ActivityThrowDiceMainDialog:UpdateCallTime()
    if isNull(self.config)  then
        return
    end
    CfUtils.FillText(self.ThrowDiceTxtNum , localize("剩余_num_次" , {_num_ = math.floor(GoodsUtils.GetThingNo(self.config.energyId) /self.config.itemNumCost)})     ) 
end

-- 投骰子 
function ActivityThrowDiceMainDialog:UpdateHurl()
    local energyNum = GoodsUtils.GetThingNo(self.config.energyId ) 
    local itemNumCost = checkInt(self.config.itemNumCost)
    if energyNum < itemNumCost then
        GoodsUtils.ShowCommonLackMaterialDialog({{goodsId = self.config.energyId, num = self.energyNum, gainNum = energyNum - itemNumCost}})
        return
    end
    if self.isAnimation  then
        GameUtils.Toast(localize("努力向前冲"))
        return
    end
    CfUtils.ConditionAppend("ActivityThrowDiceMainDialog.UpdateHurl")
    GameUtils.Request(Interfaces.ActivityEvolveRoadHurl , { activityUuid = self._activityDojo.id } ,function (request, response)
        CfUtils.ConditionRemove("ActivityThrowDiceMainDialog.UpdateHurl")
        xTry(function ()
            if checkNumber(response.errCode) ~= 0 then
                return
            end     
            local data = checkTable(response.data)
            -- local data = checkTable(response.data)
            local oneRewards =  clone(data.rewards)
            
            oneRewards[#oneRewards+1] = {
                goodsId = self.config.energyId ,
                num = -self.config.itemNumCost  
            }
            GoodsUtils.DrawRewards(oneRewards,true)
            self:UpdateCallTime()
            self.preCellNum =  checkInt(self.nowCellNum )
            self.preTurn = checkInt(self.nowTurn) 
            self.preBuffId = self.nowBuffId
            self.nowBuffId = data.nowBuffId
            if self.nowCellNum ==  checkInt(self.config.totalCellNum) then
                if checkInt(self.config.turn) > self.nowTurn then
                    self.nowTurn = self.nowTurn + 1
                    self.nowCellNum = 0    
                end
            end
            if self.nowTurn >  checkInt(self.config.turn) then
                self.nowTurn = checkInt(self.config.turn) 
                self.nowCellNum =  self.config.totalCellNum
            end
            -- self.buffId = checkInt(data.nowBuffId)
            if isNotNull(data.triggerBuffs) then
                self.triggerBuffs = data.triggerBuffs
            else 
                self.triggerBuffs = {}
            end
            if checkInt(self.nowBuffId) == 0 and isNotNull(self.triggerBuffs) and #self.triggerBuffs == 0 then
                self:InitBuff()
            end
            self.isAnimation = true 
            if checkInt(data.nowTurn)  >  checkInt(self.config.turn) then
                self.nowTurn = checkInt(self.config.turn) 
                self.nowCellNum = checkInt(self.config.totalCellNum) 
            else 
                self.nowTurn = checkInt(data.nowTurn) 
                self.nowCellNum = checkInt(data.nowCellNum)
            end
            local jumpMaps = {} 
            if self.nowTurn > self.preTurn then
                for i = 1 + self.preCellNum , checkInt(self.config.totalCellNum), 1 do 
                    jumpMaps[#jumpMaps+1] = {
                        turn = self.preTurn , 
                        cellNum = i 
                    }
                end  
                for i = 1 , self.nowCellNum do
                    jumpMaps[#jumpMaps+1] = {
                        turn = self.nowTurn , 
                        cellNum = i 
                    }
                end 
            elseif self.preTurn == self.nowTurn then
                for i = 1 + self.preCellNum , self.nowCellNum , 1 do 
                    jumpMaps[#jumpMaps+1] = {
                        turn = self.preTurn , 
                        cellNum = i 
                    }
                end  
            end
            self.jumpMaps = jumpMaps
            -- self:GetSequence(self.buffId , jumpMaps , data.point , data.finalPoint)
            self:GetSequence(self.preBuffId , jumpMaps ,data.point , data.finalPoint ,data.rewards ,data.triggerBuffs)
            -- 1. 点击骰子 播放骰子动画 如果有buff  播放buff 飞入动画为0.5 播放 buff 增益动画
            -- 2. 开始跳骰子 ，同时移动 ， 同步进行 跳到当前位置弹出获取动画奖励 
            -- 3. 跳骰子过程中 会出现到达下一层的现象 ， 播放 云的动画 ， 切换到新一层 执行 2. 
        end, function ()
            self.isAnimation = false 
        end)
    end
    ,function(exception)
        CfUtils.ConditionRemove("ActivityThrowDiceMainDialog.UpdateHurl")
    end)
end
function ActivityThrowDiceMainDialog:UpdateRedPoint()
    ---@type ActivityMgr
    local ActivityMgr = import("Game.Activity.ActivityMgr"):GetInstance()
    local redPoint = self.redPoint
    local hasRedPoint = ActivityMgr:HasActivityDojoRedDotHint(self._activityDojo.id)
    KTool.SetActive(redPoint ,hasRedPoint)
end
---@param buffId integer @ 技能id 
function ActivityThrowDiceMainDialog:GetSequence(buffId ,jumpMaps ,point ,  finalPoint ,rewards , triggerBuffs)
    local seeRect = self.VertContent.transform.parent.transform:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local contentWidth = self.VertContent.rect.width
    local oneWith = contentWidth -  seeRect.rect.width 
    local DOTween  = CS.DG.Tweening.DOTween
    local sequence = DOTween.Sequence()
    local throwSeq = DOTween.Sequence()
    local totalTime = 0 
    local throwAnimationTime = CfUtils.GetAnimationTime(self.BtnAnimationRoot ,"ActivityMonopolyDialog_BtnMonopoly_DiceGo") 
    throwSeq:AppendCallback(function ()
        CfUtils.PlayAnimation(self.BtnAnimationRoot , "ActivityMonopolyDialog_BtnMonopoly_DiceGo")
        CfUtils.FillText(self.TxtMonopolyNum , "")
    end)
    throwSeq:AppendInterval(throwAnimationTime)
    throwSeq:AppendCallback(function ()
        CfUtils.FillText(self.TxtMonopolyNum , point)
    end)
    -- 如果含有buff ， 增加buff的动画       
    if checkInt(buffId) > 0 and  checkInt(finalPoint) ~= checkInt(point) then
        local startPos =  self.BtnBuff.transform.position 
        local endPos = self.BtnMonopoly.transform.position
        self.UIFX_MoveTrail.transform.position = startPos
        self.UIFX_Boom.transform.position = endPos
        -- 起始位置开始闪光
        throwSeq:AppendCallback(function ()
            KTool.SetActive(self.UIFX_StartGlow , true) 
            KTool.SetActive(self.UIFX_MoveTrail , true) 
            
        end)
        throwSeq:Append(self.UIFX_MoveTrail.transform:DOMove(endPos , 0.5))
        throwSeq:AppendCallback(function ()
            KTool.SetActive(self.UIFX_Boom , true) 
            KTool.SetActive(self.UIFX_StartGlow , false) 
            KTool.SetActive(self.UIFX_MoveTrail , false) 
        end)
        local throwBuffAnimationTime = CfUtils.GetAnimationTime(self.BtnAnimationRoot ,"ActivityMonopolyDialog_BtnMonopoly_DiceBuffGo") 
        throwSeq:AppendCallback(function ()
            CfUtils.PlayAnimation(self.BtnAnimationRoot , "ActivityMonopolyDialog_BtnMonopoly_DiceBuffGo")
        end)
        throwSeq:AppendInterval(throwBuffAnimationTime)
        throwSeq:AppendCallback(function ()
            KTool.SetActive(self.UIFX_Boom , false) 
            CfUtils.FillText(self.TxtMonopolyNum , finalPoint)
        end)
    end
    sequence:Append(throwSeq)
    -- sequence.AppendInterval(throwAnimationTime)
    -- 如果没有进行轮数切换 ， 获取当前轮数切换的数量
    local count = 0 
    for k, v in pairs(jumpMaps) do
        if checkInt(v.turn) == self.preTurn  then
            count = count + 1
        end
    end
    local index736 = 1
    for i =1 , count , 1 do
        local conf = jumpMaps[i]
        local cellNum = conf.cellNum
        local cellIndex = math.floor(cellNum/ 20 )  +  1    
        local index  = cellNum % 20 
        if cellNum > 0 and index == 0 then
            index = 20
            cellIndex = math.floor(cellNum/ 20 )
        end
        local jumpSeq = DOTween.Sequence()
        local oneRewardCell = self.VertContent.transform:Find("RewardCell" .. cellIndex)
        ---@type ActivityThrowDiceRewardCell
        local env =  CfUtils.GetLuaScr(oneRewardCell , "Game.Activity.ThrowDice.ActivityThrowDiceRewardCell") 
        ---@type Engine.Modules.LuaBehaviour
        local RwardNode = env["RwardNode" ..  index]
        ---@type ActivityThrowDiceRewardNode | ActivityThrowDiceBigRewardNode
        local RwardNodeEnv = RwardNode.Env
        local jumpTime = CfUtils.GetAnimationTime(self.ActivityMonopolyRoleNode ,"ActivityMonopolyRoleNode_Jump")
        jumpSeq:AppendCallback(function ()
            CfUtils.PlayAnimation(self.ActivityMonopolyRoleNode , "ActivityMonopolyRoleNode_Jump") 
        end)
        -- local ImgBg =  RwardNode.transform:Find("root/BtnIcon")
        -- local rewardsPosition  = clone(ImgBg.transform.position) 
        -- rewardsPosition.y = rewardsPosition.y + 0.5
        -- rewardsPosition.x = rewardsPosition.x  - 0.5
        -- local monopolyRoleNodePos  = self.ActivityMonopolyRoleNode.transform.position

        local localPos  = self:GetRoleLocalPos(cellNum)
        --self.StartingPoint.transform:InverseTransformPoint(rewardsPosition)
        jumpSeq:AppendCallback(function ()
            ---@type UnityEngine.Animation
            local animation = RwardNodeEnv.root.transform:GetComponent(typeof(CS.UnityEngine.Animation))
            if not KTool.IsNull(animation) then
                animation:PlayQueued("ActivityMonopolyRewardNode_CellJumpEffectEntry",CS.UnityEngine.QueueMode.CompleteOthers)
                animation:PlayQueued("ActivityMonopolyRewardNode_CellJumpEffectOut",CS.UnityEngine.QueueMode.CompleteOthers)
            end
        end)
        jumpSeq:Append(self.ActivityMonopolyRoleNode.transform:DOLocalMove(localPos,  jumpTime))  
        jumpSeq:AppendCallback(function()
            RwardNodeEnv:GetReward()
            local x =  ((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + self.VertContent.localPosition.x + 635)
            local horizontalNormalizedPosition = -1  
            if x > (736 + 236)  then
                 horizontalNormalizedPosition  = (((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + 736) - seeRect.rect.width)  / oneWith    
            elseif x < 0 then
                horizontalNormalizedPosition = (((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + 736) - seeRect.rect.width)  / oneWith    
            end
            local currentHorizontalNormalizedPosition = self.RewardIconNode.horizontalNormalizedPosition
            print("horizontalNormalizedPosition=>" , horizontalNormalizedPosition)
            print("self.RewardIconNode.horizontalNormalizedPosition =>" , self.RewardIconNode.horizontalNormalizedPosition)
            if horizontalNormalizedPosition > -1 and  
            (currentHorizontalNormalizedPosition< horizontalNormalizedPosition or (currentHorizontalNormalizedPosition - horizontalNormalizedPosition >  0.1) )   then
                self.RewardIconNode.horizontalNormalizedPosition =   horizontalNormalizedPosition  
            end
        end)
        if i ~= count then
            jumpSeq:AppendInterval(0.1)
        end
        sequence:Append(jumpSeq)
    end
    -- 如果是在同一轮
    if #jumpMaps == count and self.preTurn == self.nowTurn  then
        sequence:AppendCallback(function ()
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards, cb = function()
                self.isAnimation = false
                CfUtils.FillText(self.TxtMonopolyNum , "")
                CfUtils.PlayAnimation(self.BtnAnimationRoot , "ActivityMonopolyDialog_BtnMonopoly_DiceDefaultLoop")
                CfUtils.SetActive(self.MonopolyNum , false)
                if  #self.triggerBuffs > 0   then
                    UIModule.OpenDialog({  id = Constants.UITypeIds.ActivityThrowDiceBuffEffectDialog,
                    parameters = {
                        triggerBuffs = self.triggerBuffs , 
                        activityUuid = self._activityDojo.id 
                    }})
                end
            end }})
        end)
    else 
        -- 如果不在同一轮
        local entryAnimationTime = CfUtils.GetAnimationTime(self.UIFX_CloudChange , "ActivityMonopolyDialog_CluodChangeEntry")
        local outAnimationTime = CfUtils.GetAnimationTime(self.UIFX_CloudChange , "ActivityMonopolyDialog_CluodChangeOut")
        sequence:AppendCallback(function ()
            KTool.SetActive(self.UIFX_CloudChange ,true)
            local animation2 = self.UIFX_CloudChange.transform:GetComponent(typeof(CS.UnityEngine.Animation))
            if not KTool.IsNull(animation2) then
                animation2:PlayQueued("ActivityMonopolyDialog_CluodChangeEntry", CS.UnityEngine.QueueMode.CompleteOthers)
                animation2:PlayQueued("ActivityMonopolyDialog_CluodChangeOut", CS.UnityEngine.QueueMode.CompleteOthers)
            end
          
            self:InitUI(false)
        end)
        sequence:AppendInterval(entryAnimationTime )
        sequence:AppendCallback(function ()
            local oneRewardCell = self.VertContent.transform:Find("RewardCell" .. 1)
            ---@type ActivityThrowDiceRewardCell
            local env =  CfUtils.GetLuaScr(oneRewardCell , "Game.Activity.ThrowDice.ActivityThrowDiceRewardCell") 
            ---@type Engine.Modules.LuaBehaviour
            local RwardNode = env["RwardNode" ..  1]
            self.RewardIconNode.horizontalNormalizedPosition = 0 
            self.ActivityMonopolyRoleNode.transform.localPosition = Vector3(123,151,0)
        end)
        sequence:AppendInterval(outAnimationTime)
        sequence:AppendCallback(function ()
            local twoSequence = DOTween.Sequence()
            if self.nowCellNum ~= 0 then
                for i = count+1 , #jumpMaps , 1 do
                    local conf = jumpMaps[i]
                    local cellNum = conf.cellNum
                    local cellIndex = math.floor(cellNum/ 20 )  +  1    
                    local index  = cellNum % 20 
                    if cellNum > 0 and index == 0 then
                        index = 20
                        cellIndex = math.floor(cellNum/ 20 )
                    end
                    local jumpSeq = DOTween.Sequence()
                    local oneRewardCell = self.VertContent.transform:Find("RewardCell" .. cellIndex)
                    ---@type ActivityThrowDiceRewardCell
                    local env =  CfUtils.GetLuaScr(oneRewardCell , "Game.Activity.ThrowDice.ActivityThrowDiceRewardCell") 
                    ---@type Engine.Modules.LuaBehaviour
                    local RwardNode = env["RwardNode" ..  index]
                    ---@type ActivityThrowDiceRewardNode | ActivityThrowDiceBigRewardNode
                    local RwardNodeEnv = RwardNode.Env
                    local jumpTime = CfUtils.GetAnimationTime(self.ActivityMonopolyRoleNode ,"ActivityMonopolyRoleNode_Jump")
                    jumpSeq:AppendCallback(function ()
                        CfUtils.PlayAnimation(self.ActivityMonopolyRoleNode , "ActivityMonopolyRoleNode_Jump") 
                    end)
                    -- local ImgBg =  RwardNode.transform:Find("root/BtnIcon")
                    -- local rewardsPosition  = clone(ImgBg.transform.position) 
                    -- rewardsPosition.y = rewardsPosition.y + 0.5
                    -- rewardsPosition.x = rewardsPosition.x  - 0.5
                    -- local monopolyRoleNodePos  = self.ActivityMonopolyRoleNode.transform.position
                    local localPos  = self:GetRoleLocalPos(cellNum)
                    --  self.StartingPoint.transform:InverseTransformPoint(rewardsPosition)
                    jumpSeq:AppendCallback(function ()
                        ---@type UnityEngine.Animation
                        local animation = RwardNodeEnv.root.transform:GetComponent(typeof(CS.UnityEngine.Animation))
                        if not KTool.IsNull(animation) then
                            animation:PlayQueued("ActivityMonopolyRewardNode_CellJumpEffectEntry",CS.UnityEngine.QueueMode.CompleteOthers)
                            animation:PlayQueued("ActivityMonopolyRewardNode_CellJumpEffectOut",CS.UnityEngine.QueueMode.CompleteOthers)
                        end
                    end)
                    jumpSeq:Append(self.ActivityMonopolyRoleNode.transform:DOLocalMove(localPos,  jumpTime))  
                    jumpSeq:AppendCallback(function()
                        RwardNodeEnv:GetReward()
                        if cellNum < 10 then
                            self.RewardIconNode.horizontalNormalizedPosition = 0
                        else    
                            local x =  ((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + self.VertContent.localPosition.x + 635)
                            if x > (736 + 236)  then
                                self.RewardIconNode.horizontalNormalizedPosition = (((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + 736) - seeRect.rect.width)  / oneWith    
                            elseif x < 0 then
                                self.RewardIconNode.horizontalNormalizedPosition = (((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + 736) - seeRect.rect.width)  / oneWith    
                            end 
                        end
                    end)
                    if i ~= count then
                        jumpSeq:AppendInterval(0.1)
                    end
                    twoSequence:Append(jumpSeq)
                end
            end
            twoSequence:AppendCallback(function ()
                UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards, cb = function()
                    self.isAnimation = false
                    CfUtils.FillText(self.TxtMonopolyNum , "")
                    CfUtils.PlayAnimation(self.BtnAnimationRoot , "ActivityMonopolyDialog_BtnMonopoly_DiceDefaultLoop")
                    CfUtils.SetActive(self.MonopolyNum , false)
                    if  #self.triggerBuffs > 0   then
                        UIModule.OpenDialog({  id = Constants.UITypeIds.ActivityThrowDiceBuffEffectDialog,
                        parameters = {
                            triggerBuffs = self.triggerBuffs , 
                            activityUuid = self._activityDojo.id 
                        }})
                    end
                end }})
            end)
        end)
     
    end
end
function ActivityThrowDiceMainDialog:ChooseBuffEvent(param)
    self.nowBuffId = param.buffId 
    ---@type ThrowDiceBuffEffectVo
    local vo =  CfUtils.GetCfVo(AutoIds.IdSetting6601 , "ThrowDiceBuffEffectVo" , self.nowBuffId)
    if checkInt(vo.type) == 5  then
        local rewards = {
            {
                goodsId = vo.parameter[2],
                num = vo.parameter[1]  
            }
        } 
        GoodsUtils.DrawRewards(rewards, true)  
        UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards}})
        self.nowBuffId = 0
        self:UpdateCallTime()
    end
    self.triggerBuffs = {}
    self:InitBuff()
end     
--- 获取当前角色的位置
function ActivityThrowDiceMainDialog:GetRoleLocalPos(nowCellNum)
    if nowCellNum == 0 then
        return  Vector3(123,151,0)
    end
    local cellIndex = math.floor(nowCellNum / 20)
    local index  = nowCellNum % 20 
    if nowCellNum > 0 and index == 0 then
        index = 20
        cellIndex = cellIndex - 1
        -- cellIndex = math.floor(nowCellNum/ 20)
    end
    print("index =>" , index)
    print("cellIndex =>" , cellIndex)
    return Vector3(POS_20[index].x + 1472 * cellIndex + 125,POS_20[index].y-180,0)
end


--- 获取当前角色的位置
function ActivityThrowDiceMainDialog:GetHorizontalNormalizedPosition(nowCellNum)
    local seeRect = self.VertContent.transform.parent.transform:GetComponent(typeof(CS.UnityEngine.RectTransform))
    local contentWidth = self.VertContent.rect.width
    local oneWith = contentWidth -  seeRect.rect.width 
    if checkInt(nowCellNum) == 0 then
        return ((((0  * 1472 ) + self.StartingPoint.transform.localPosition.x) + 236 + 736) - seeRect.rect.width)  / oneWith 
    end
    local cellIndex = math.floor(nowCellNum/ 20 )  +  1    
    local index  = self.nowCellNum % 20 
    if nowCellNum > 0 and index == 0 then
        index = 20
        cellIndex = math.floor(nowCellNum/ 20)
    end
    local oneRewardCell = self.VertContent.transform:Find("RewardCell" .. cellIndex)
    ---@type ActivityThrowDiceRewardCell
    local env =  CfUtils.GetLuaScr(oneRewardCell , "Game.Activity.ThrowDice.ActivityThrowDiceRewardCell") 
    ---@type Engine.Modules.LuaBehaviour
    local RwardNode = env["RwardNode" ..  index]
    local horizontalNormalizedPosition =  (((((cellIndex -1)  * 1472 ) + RwardNode.transform.localPosition.x) + 236 + 736) - seeRect.rect.width)  / oneWith    
    return horizontalNormalizedPosition
end


function ActivityThrowDiceMainDialog:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityThrowDiceMainDialog