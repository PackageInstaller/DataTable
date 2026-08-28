--- 养成-好感度界面

------------ import ------------
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
---@type Engine.UI.UIModule
local UIModule         = CS.Engine.UI.UIModule
---@type Engine.Lib.KCookie
local KCookie          = CS.Engine.Lib.KCookie
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
-- ---@type GoodsConfMgr
-- local goodsConfMgr             = GoodsConfMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
---@type CardProgressionMgr
local CardProgressionMgr       = import("Game.CardProgression.CardProgressionMgr")
local cs_coroutine             = require "XLua.cs_coroutine"
---@type CriWareUtils
local CriWareUtils             =  import('Game.Entry.CriWareUtilsFix')
------------ import ------------


------------ define ------------
local checkInt = checkInt
local AnimInName = "CultivateOverseaFeelingFeelingAnim"
local AnimOutName = "CultivateOverseaFeelingFeelingAnim_Out"

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaFeeling.prefab > name: CultivateOverseaFeeling
---@class CardProgressionFavor
---@field Env                           	CardProgressionFavor                    
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TextNumberUpperLimit          	TMPro.TextMeshProUGUI                   
---@field ScrollView                    	SuperScrollView.LoopListView2           
---@field UnlockContent                 	UnityEngine.RectTransform               
---@field Content                       	UnityEngine.RectTransform               
---@field TextDesc                      	UnityEngine.RectTransform                     
---@field TextNumber                    	TMPro.TextMeshProUGUI                   
---@field ClickArea                     	UnityEngine.RectTransform               
---@field FeelingAnim                   	UnityEngine.Animation               
---@field TxtLeftName                   	UnityEngine.UI.Text                     
---@field TxtContent                    	LetterTyperComp                         
---@field DialogueFrameNode             	UnityEngine.RectTransform               
---@field HightLevel                    	UnityEngine.RectTransform               
---@field TextNumberTodayTimes          	TMPro.TextMeshProUGUI                   
---@field FontStyleButton               	Game.Native.Common.FontStyleButton               
---@field TextNumberDisplay             	TMPro.TextMeshProUGUI                   
---@field TextNumberRight               	TMPro.TextMeshProUGUI                   
---@field TextNumberLeft                	TMPro.TextMeshProUGUI                   
---@field BtnAdd                        	UnityEngine.RectTransform               
---@field BtnReduce                     	UnityEngine.RectTransform               
---@field Slider                        	UnityEngine.UI.Slider                   
---@field QuantitySlider                	UnityEngine.RectTransform               
---@field ImgFavorite                   	UnityEngine.RectTransform               
---@field GoodNode                      	UnityEngine.RectTransform               
---@field Normal                        	UnityEngine.RectTransform               
---@field ConsumeContent                	UnityEngine.RectTransform               
---@field Empty                         	UnityEngine.RectTransform               
---@field BtnNode                       	UnityEngine.RectTransform               
---@field Bottom                        	UnityEngine.RectTransform               
---@field GoodsConsumeNode              	UnityEngine.RectTransform               
---@field ChooseGroup                   	UnityEngine.RectTransform               
---@field ItemMaterial                  	UnityEngine.RectTransform               
---@field RewardNode6                   	UnityEngine.RectTransform               
---@field RewardNode5                   	UnityEngine.RectTransform               
---@field RewardNode4                   	UnityEngine.RectTransform               
---@field RewardNode3                   	UnityEngine.RectTransform               
---@field RewardNode2                   	UnityEngine.RectTransform               
---@field RewardNode1                   	UnityEngine.RectTransform               
---@field CurrentSlider                 	UnityEngine.UI.Slider                   
---@field PreloadSlider                 	UnityEngine.UI.Slider                   
---@field TextLevel                     	TMPro.TextMeshProUGUI                   
---@field TextExp                       	TMPro.TextMeshProUGUI                   
---@field EffectGive                    	UnityEngine.RectTransform               
---@field HighestLevelAnim              	UnityEngine.RectTransform               
local CardProgressionFavor = Class('CardProgressionFavor')


function CardProgressionFavor:__init()
    self._consumeNodes = {}
    --self._goodsId2ConsumeData = {}
    self._cos = {}
    self._particleSystems = nil
    self._goodsInfo = nil
    self._isCanCloseAni = false
end


function CardProgressionFavor:__delete()
    self.controller = nil
end


function CardProgressionFavor:Awake()
    KTool.SetActive(self.FeelingAnim.gameObject, false)
    KTool.SetActive(self.CurrentSlider.gameObject, true)
    KTool.SetActive(self.PreloadSlider.gameObject, true)
    self.Slider.minValue = 1
    
end

function CardProgressionFavor:Start()
    self:InitAction()
    
end

function CardProgressionFavor:OnDestroy()

    for key, value in pairs(self._listenerConf) do
        Events.RemoveListener(key, value)
    end
    
    self:CloseWaitCo()
    for k, v in pairs(self._cos) do
        if not isNull(v) then
            cs_coroutine.stop(v)
        end
    end
end

function CardProgressionFavor:OnFocus(focus)
    if self._focus == focus then
        return
    end
    self._focus = focus
    if focus and self._isPresentGiftSuccess then
        KTool.SetActive(self.Content.gameObject, true)
        self:FreshDialogueNode(true, CardProgressionConstants.FavorWordType.PresentGift)
        --KTool.SetActive(self.FeelingAnim.gameObject, false)
        
    end

end


-- function CardProgressionFavor:OnInitialize()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         --- 显示养成场景
--         Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusGrowSceneEventName, true)
--         Events.Broadcast(Constants.EventNames.MainHomeRoleActive, {isShowCultivate = true})
--         cs_coroutine.yield_return()
        
--         self:InitData()
--         self:InitAction()
--         self:FreshUI()
        
--     end))
--     return coWait
-- end

-- function CardProgressionFavor:OnShow()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         self:LoadModel()
--         self:FreshDialogueNode(true, CardProgressionConstants.FavorWordType.Getting)

--     end))
--     return coWait
-- end

-- function CardProgressionFavor:OnFinalize()
--     ---@type Engine.Lib.CoWait
--     local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
--         for key, value in pairs(self._listenerConf) do
--             Events.RemoveListener(key, value)
--         end
        
--         self:CloseWaitCo()
--         for k, v in pairs(self._cos) do
--             if not isNull(v) then
--                 cs_coroutine.stop(v)
--             end
--         end
        
--         self.controller = nil --删除lua层引⽤用到的c#对象
--         self:Delete()
--         self = nil
--     end))
--     return coWait
-- end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionFavor:Fresh(playerCardId)
    self:InitData(playerCardId)
    
    self:FreshUI()

    self:LoadModel()
    self:FreshDialogueNode(true, CardProgressionConstants.FavorWordType.Getting)
end

function CardProgressionFavor:InitData(playerCardId)
    -- local parameters    = self.controller.Argument.parameters
    -- local playerCardId  = parameters.playerCardId

    ---@type CardComponent
    local cardComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    ---@type CardDojo
    local cardDojo      = cardComponent:GetCardById(playerCardId)
    self._cardDojo      = cardDojo

    local cardId        = cardDojo.cardId
    local ids           = cardConfMgr:GetFavorableExpRewardIdGroup(cardId)
    local expRewardList = {}
    
    local maxLevel      = 0
    for i, id in ipairs(ids) do
        local expData = cardConfMgr:GetFavorableExpData(id)
        ---@type FavorableExpRewardVo
        local vo      = cardConfMgr:GetFavorableExpRewardVo(id)
        if vo ~= nil then
            local level = vo.level
            maxLevel = math.max(maxLevel, level)
            --- RewardNode1 ... maxLevel
            local rewardNode = self[string.format("RewardNode%s", level)]
            expRewardList[level] = {vo = vo, expData = expData, rewardNode = rewardNode}
        end
    end
    self._expRewardList = expRewardList
    self._maxLevel      = maxLevel
    
    self._limitTimes = checkNumber(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.TodaySendGiftLimitTimes))

    self._receivedLevel2Res = cardDojo:GetFavorLv2ReceivedRes()
    
    ---@type RoleCardFavorableGiftVo
    self._giftVo = cardConfMgr:GetRoleCardFavorableGiftVo(cardId)
    
    ---@type CardProgressionControllerRole
    self._controllerEnv = CardProgressionUtils.GetRoleControllerEnv()

    self._goodsInfo = KCookie.Get(CardProgressionConstants.CookieNames.FavorGoodsData)
    if self._goodsInfo then
        self._goodsInfo.selectNum = 1
        self.TextNumberDisplay.text = 1
        KCookie.Set(CardProgressionConstants.CookieNames.FavorGoodsData)
    end
end

function CardProgressionFavor:InitAction()
    SetButtonAction(self.BtnNode, Bind(self, self.OnClickBtnNodeAction))
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnClickBtnAction))
    SetButtonAction(self.BtnReduce, Bind(self, self.OnClickBtnReduceAction))
    SetButtonAction(self.BtnAdd, Bind(self, self.OnClickBtnAddAction))
    SetButtonAction(self.ClickArea, Bind(self, self.OnClickAreaAction))
    

    local listenerConf = {
        [CardProgressionConstants.EventNames.RequestSuccess] =  Bind(self, self.OnEventRequestSuccess),
        [CardProgressionConstants.EventNames.SelectFavorGoodsComplete] =  Bind(self, self.OnEventSelectFavorGoodsComplete),
    }
    for key, value in pairs(listenerConf) do
        Events.AddListener(key, value)
    end
    self._listenerConf = listenerConf

    CardProgressionUtils.RegRoleSwipeRegion(self.controller)

    self.Slider.onValueChanged:AddListener(Bind(self, self.OnGiftValeChangeAction))
end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionFavor:FreshUI()
    if next(self._expRewardList) == nil then
        return
    end

    local maxLevelExpData      = self._expRewardList[self._maxLevel].expData
    local cardDojo             = self._cardDojo
    self._arrivalsMaxLvNeedExp = maxLevelExpData.totalExp - checkNumber(cardDojo.favorabilityExp)
    
    self:FreshTextNumberUpperLimit()

    self:FreshChooseGroup()

    self:FreshLevelInfo()

    self:FreshBottom()

end

function CardProgressionFavor:FreshTextNumberUpperLimit()
    
    local originLevel       = checkNumber(self._cardDojo.favorabilityLevel)
    ---@type FavorableExpRewardVo
    local vo                = self._expRewardList[originLevel].vo
    self.TextNumberUpperLimit.text = vo.mood
end

function CardProgressionFavor:FreshLevelInfo()
    self:CalcLevelAndFreshInfo()

    self:FreshRewardNodes()

end

function CardProgressionFavor:CalcLevelAndFreshInfo()
    local expAddition = self:GetExpAddition()
    local progressOrigin, progress, newLevel, feedingTotalExp, maxLvTotalExp = self:GetLevelInfo(expAddition)
    self._currentLevel = newLevel
    local isMaxLevel = self._originLevel >= self._maxLevel
    KTool.SetActive(self.TextExp.gameObject,          not isMaxLevel)
    KTool.SetActive(self.ItemMaterial.gameObject,     not isMaxLevel)
    KTool.SetActive(self.Normal.gameObject,           not isMaxLevel)
    KTool.SetActive(self.HighestLevelAnim.gameObject, isMaxLevel)

    self._feedingTotalExp = feedingTotalExp
    self:FreshLevel()
    self:FreshSlider(progressOrigin, progress, expAddition)
    if not isMaxLevel then
        self:FreshExp(feedingTotalExp, maxLvTotalExp, expAddition)
    end
end

function CardProgressionFavor:FreshLevel()
    local level      = self._currentLevel
    local isChangeLv = level ~= self._originLevel
    if isChangeLv then
        self.TextLevel.text = string.format("<color=#06efec>%s</color>", level)
    else
        self.TextLevel.text = level
    end
end

function CardProgressionFavor:FreshExp(feedingTotalExp, maxLvTotalExp, expAddition)
    local isChange = expAddition > 0
    if isChange then
        self.TextExp.text = string.format("<color=#06efec>%s</color>/%s", feedingTotalExp, maxLvTotalExp)
    else
        self.TextExp.text = string.format("%s/%s", feedingTotalExp, maxLvTotalExp)
    end
end

function CardProgressionFavor:FreshSlider(progressOrigin, progress)
    self.CurrentSlider.value = progressOrigin
    self.PreloadSlider.value = progress 
end


function CardProgressionFavor:FreshRewardNodes()
    for i, data in ipairs(self._expRewardList) do
        local rewardNode = data.rewardNode
        if rewardNode then
            self:FreshRewardNode(rewardNode, data)
        end
    end
end

function CardProgressionFavor:FreshRewardNode(node, data)
    ---@type CardProgressionFavorRewardNode
    local env = CfUtils.GetLuaScr(node, CardProgressionConstants.EnvPath.CardProgressionFavorRewardNode)
    if not isNull(env) then
        env:SetCallback(Bind(self, self.OnClickRewardNodeAction))
        env:FreshUI(data, self._receivedLevel2Res[data.vo.level] ~= nil, self._currentLevel, self._originLevel, self._cardDojo.cardId, self._expRewardList[self._originLevel])
    end
end

function CardProgressionFavor:FreshChooseGroup()
    local goodsInfo     = self._goodsInfo
    local isSelectGoods = goodsInfo ~= nil
    KTool.SetActive(self.Empty.gameObject, not isSelectGoods)
    KTool.SetActive(self.ConsumeContent.gameObject, isSelectGoods)
    KTool.SetActive(self.QuantitySlider.gameObject, isSelectGoods)
    if isSelectGoods then
        ---@type CardFavorableGoodsVo | RestaurantCookingGoodsVo
        local vo = goodsInfo.vo
        --ownNum
        --isFavor
        --favorAddiNum
        CfUtils.RefeshGoodGo2(self.GoodNode, vo.id, goodsInfo.ownNum)
        KTool.SetActive(self.ImgFavorite.gameObject, goodsInfo.isFavor)
        self.TextNumberLeft.text = 1
        self.TextNumberRight.text = math.min(goodsInfo.ownNum, self._limitTimes - self._cardDojo.todaySendGiftTimes)
        self:FreshQuantitySlider(true)
    end

end

function CardProgressionFavor:FreshBottom()
    local isMaxLevel = self._originLevel >= self._maxLevel
    KTool.SetActive(self.FontStyleButton.gameObject, not isMaxLevel)
    KTool.SetActive(self.HightLevel.gameObject, isMaxLevel)
        
    self.TextNumberTodayTimes.text = string.format("%s/%s", self._limitTimes - self._cardDojo.todaySendGiftTimes, self._limitTimes)
    self:FreshBtnStyle()
end

function CardProgressionFavor:FreshBtnStyle()
    local isSelectGoods = self._goodsInfo ~= nil
    self.FontStyleButton:ResetFontStyle(isSelectGoods and "B1" or "B17")
end

---FreshDialogueNode
---@param isNormal boolean 是否是正常情况
---@param groupId number 对话组
function CardProgressionFavor:FreshDialogueNode(isNormal, groupId)
    local name, desc, voice, action = self:GetDialogue(isNormal, groupId)
    
    self.TxtLeftName.text = name
    local txtContent = self.TxtContent
    txtContent:ResetArgs()
    txtContent:SetText("", true)
    txtContent.PendingTime     = 0.02
    txtContent.AppearDuration  = 0.2
    txtContent.IgnoreTimeScale = true
    txtContent.TextWillFill    = desc

    self:CloseWaitCo()
    self._waitCo = cs_coroutine.start(function()
        cs_coroutine.yield_return(txtContent:StartType())

        self._waitCo = nil
    end)
    
    if not string.isEmpty(voice) then
        CriWareUtils.PlayVoiceById(voice)
    end
end

function CardProgressionFavor:CloseWaitCo()
    if self:IsFinish() then return end

    cs_coroutine.stop(self._waitCo)
    self._waitCo = nil

end

function CardProgressionFavor:IsFinish()
    return isNull(self._waitCo)
end

function CardProgressionFavor:ShowEffectGive()
    local particleSystems = self._particleSystems
    if particleSystems == nil then
        KTool.SetActive(self.EffectGive.gameObject, true)
        self._particleSystems = self.EffectGive.gameObject:GetComponentsInChildren(CardProgressionConstants.CompType.ParticleSystemType)
    else
        for i = 0, particleSystems.Length - 1 do 
            ---@type UnityEngine.ParticleSystem
            local ps = particleSystems[i]
            ps:Play(true)
        end
    end
end

---LoadModel
---加载模型
---@param isDisableEnter boolean 是否禁用入场
function CardProgressionFavor:LoadModel(isDisableEnter)
    ---@type CardProgressionControllerRole
    local controllerEnv = self._controllerEnv
    local cardDojo = self._cardDojo
    controllerEnv:LoadRole(cardDojo.cardSkin, isDisableEnter, {CardProgressionConstants.CameraState.CultivateRoleFull}, nil, cardDojo)
end

---FreshQuantitySlider
---刷新进度
function CardProgressionFavor:FreshQuantitySlider()
    local goodsInfo = self._goodsInfo
    local selectNum = goodsInfo.selectNum
    local ownNum    = goodsInfo.ownNum
    local count     = self._limitTimes - self._cardDojo.todaySendGiftTimes
    self.Slider.maxValue = math.min(ownNum, count)
    self.Slider.value    = selectNum
    
end

---FreshUnlockContent
---刷新解锁内容
---@param isChange boolean 好感度等级是否改变
---@param favorLevel number 好感度等级
function CardProgressionFavor:FreshUnlockContent(isChange, favorLevel)
    KTool.SetActive(self.UnlockContent.gameObject, isChange)
    if not isChange then
        return
    end

    local data = self._expRewardList[favorLevel]
    local t    = CardProgressionUtils.CollectFavorLevelRewards(data, self._cardDojo.cardId, true)
    self._curLvRewardsData = t

    self:FreshListView()
end

function CardProgressionFavor:FreshListView()
    local listDataLength = #self._curLvRewardsData
    if not self.ScrollView.IsListViewInit then
        self.ScrollView:InitListView(listDataLength, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.ScrollView, listDataLength)
    end
end

function CardProgressionFavor:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local node = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionFavorRewardTipsDescNode)

    ---@type CardProgressionFavorRewardTipsDescNode
    local nodeEnv
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        node:Init()
        nodeEnv = node.Env
    else
        nodeEnv = node.Env
    end

    if nodeEnv then
        local position = index + 1
        local data = self._curLvRewardsData[position]
        nodeEnv:FreshUI(data)
    end

    return cell
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionFavor:GetExpAddition()
    local goodsInfo           = self._goodsInfo
    if goodsInfo == nil then
        return 0
    end
    local selectNum           = goodsInfo.selectNum
    local favorAddiNum        = goodsInfo.favorAddiNum
    local expAddition         = selectNum * favorAddiNum
    return expAddition
end

function CardProgressionFavor:GetLevelInfo(expAddition)
    ---@type CardDojo
    local cardDojo          = self._cardDojo
    local originLevel       = checkNumber(cardDojo.favorabilityLevel)
    local originExp         = checkNumber(cardDojo.favorabilityExp)
    local maxLevel          = self._maxLevel
    local maxLevelExpData   = self._expRewardList[maxLevel].expData
    local newLevelNextLvExp = nil
    self._originLevel       = originLevel
    local newLevel          = originLevel
    local progressOrigin    = 0
    local progress          = 0
    local feedingTotalExp  = originExp + expAddition
    if expAddition > 0 then
        local isMaxExp         = feedingTotalExp >= maxLevelExpData.totalExp

        if isMaxExp then
            progress = 1
            newLevel = maxLevel
            -- newLevelNextLvExp = "----"

        else
            local floor           = math.floor
            local leftLv, rightLv = newLevel, maxLevel
            while leftLv <= rightLv do
                local middle = floor((leftLv + rightLv) * 0.5)
                local totalExp = self._expRewardList[middle].expData.totalExp
                if totalExp > feedingTotalExp then
                    rightLv = middle - 1
                else
                    leftLv = middle + 1
                end
            end
            newLevel        = rightLv
            progress = (newLevel - 1) / (maxLevel - 1)
        end
    elseif maxLevel == originLevel then
        progressOrigin = 1
    else
        --- 当前等级下一等级经验配置 
        progressOrigin = (originLevel - 1) / (maxLevel - 1)
    end

    if newLevelNextLvExp == nil then
        newLevelNextLvExp = self._expRewardList[math.min(newLevel+1, maxLevel)].expData.totalExp
    end
    return progressOrigin, progress, newLevel, feedingTotalExp, newLevelNextLvExp
end

function CardProgressionFavor:GetDialogue(isNormal, groupId)
    local desc, voice, action
    local cardId = self._cardDojo.cardId
    -----@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)
    local name = cardVo.name
    if isNormal then
        local t = cardConfMgr:GetFavorableCardWordVoByGroupId(cardId, groupId)
        if t then
            ---@type FavorableCardWordVo
            local vo = t[math.random(1, #t)]
            if CfUtils.IsWoman()  then
                local text = string.isEmpty(vo.desk2) and vo.desk or vo.desk2
                desc =  string.gsub(text or '', "\\n", "\n")
                voice = vo.voice2
                action = vo.action
            else
                desc =  string.gsub(vo.desk or '', "\\n", "\n")
                voice = vo.voice
                action = vo.action
            end
        end
    else
        local ids = PhoneUtils.GetOrderGiveFoodTalkVos(cardVo.characterId)
        local count = #ids
        if count > 0 then
            local id = math.random(1, count)
            ---@type OrderGiveFoodTalkVo
            local vo = PhoneUtils.GetOrderGiveFoodTalkVo(id)
            action = vo.action
            voice = vo.voicecode
            desc =  string.gsub(vo.text, "\\n", "\n")
        end

    end
    return name, desc, voice, action
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionFavor:OnClickRewardNodeAction(data)
    local playerCardId = self._cardDojo.id
    ---@type FavorableExpRewardVo
    local vo           = data.vo
    local level        = vo.level
    CardProgressionMgr:GetInstance():RequestOverseaCardDrawFavorRewards({playerCardId = playerCardId, favorabilityLevel = level}, vo)
end

function CardProgressionFavor:OnClickBtnNodeAction()
    local todaySendGiftTimes = checkNumber(self._cardDojo.todaySendGiftTimes)
    if todaySendGiftTimes >= self._limitTimes then
        GameUtils.Toast(localize("今日送料理已达上限"))
        return
    end
    
    CardProgressionUtils.OpenDialog(Constants.UITypeIds.CardProgressionFavorPopup, {
        playerCardId = self._cardDojo.id, selectGoodsId = self._goodsInfo ~= nil and self._goodsInfo.vo.id or nil}, {UIArgs(Constants.UITypeIds.CardProgressionIntroduction)})

end

function CardProgressionFavor:OnGiftValeChangeAction(num)
    local selectNum = checkInt(num)
    local goodsInfo = self._goodsInfo
    if selectNum == goodsInfo.selectNum then
        return
    end
    goodsInfo.selectNum = selectNum

    self.TextNumberDisplay.text = selectNum

    self:FreshQuantitySlider()
    self:FreshLevelInfo()
end

function CardProgressionFavor:OnClickBtnReduceAction()
    local selectNum = self._goodsInfo.selectNum
    selectNum       = math.max(selectNum - 1, 1)
    self:OnGiftValeChangeAction(selectNum)
    
end

function CardProgressionFavor:OnClickBtnAddAction()
    if self._arrivalsMaxLvNeedExp <= 0 then return end
    local goodsInfo = self._goodsInfo
    local selectNum = goodsInfo.selectNum
    local count = math.min(goodsInfo.ownNum, self._limitTimes - checkNumber(self._cardDojo.todaySendGiftTimes))
    selectNum       = math.min(selectNum + 1, count)
    self:OnGiftValeChangeAction(selectNum)
    
end

function CardProgressionFavor:OnClickBtnAction()
    if self._goodsInfo == nil then
        GameUtils.Toast(localize('当前未选择材料'))
        return
    end

    local todaySendGiftTimes = checkNumber(self._cardDojo.todaySendGiftTimes)
    if todaySendGiftTimes >= self._limitTimes then
        GameUtils.Toast(localize("今日送料理已达上限"))
        return
    end

    local maxLevelExpData  = self._expRewardList[self._maxLevel].expData
    local overflowExp       = self._feedingTotalExp - maxLevelExpData.totalExp
    if overflowExp > 0 then
        GameUtils.SecondConfirm(localize("溢出_num_点好感度经验，是否确认赠送？",{ _num_ = overflowExp} ) , function ()
            self:RequestCardGift()
        end)
    else
        self:RequestCardGift()
    end
    

    
end

function CardProgressionFavor:RequestCardGift()
    local goodsInfo    = self._goodsInfo
    local goodsId      = goodsInfo.vo.id
    local selectNum    = goodsInfo.selectNum
    local configIsFavor = goodsInfo.configIsFavor
    local isFavor      = goodsInfo.isFavor
    
    local goodsId2count = {[tostring((goodsId))] = selectNum}
    local consumes = {{goodsId = goodsId, num = -selectNum}}
    local favorGiftIdStr
    ---未显示好感度图标并且该道具是特殊喜好道具 则处理插入
    if not isFavor and configIsFavor then
        local favorGiftIds = parse_strings(checkString(self._cardDojo.favorGiftId), ",")
        table.insert(favorGiftIds, goodsId)
        favorGiftIdStr = table.concat(favorGiftIds, ",")
    end
    
    self:ShowEffectGive()
    local newTodaySendGiftTimes = self._cardDojo.todaySendGiftTimes + selectNum
    CardProgressionMgr:RequestOverseaCardGift({playerCardId = self._cardDojo.id, goods = table.serialize(goodsId2count)}, consumes, newTodaySendGiftTimes, favorGiftIdStr)
end

function CardProgressionFavor:OnClickAreaAction()
    if not self._isCanCloseAni then
        return
    end
    self._isCanCloseAni = false
    GameUtils.PlayAndWaitForAnim(self.FeelingAnim, AnimOutName, function() 
        KTool.SetActive(self.FeelingAnim.gameObject, false)
        KTool.SetActive(self.Content.gameObject, true)
        self:FreshDialogueNode(true, CardProgressionConstants.FavorWordType.PresentGift)
    end, AnimOutName)
    
end

---OnEventSelectFavorGoodsComplete
---@param goodsInfo table {
---     vo: CardFavorableGoodsVo | RestaurantCookingGoodsVo
---     ownNum : number
---     isFavor: boolean
---     favorAddiNum: number
---}
function CardProgressionFavor:OnEventSelectFavorGoodsComplete(goodsInfo)
    self._goodsInfo = goodsInfo
    if goodsInfo then
        goodsInfo.selectNum = 1
        self.TextNumberDisplay.text = 1
        self:FreshBtnStyle()
    end
    self:FreshChooseGroup()
    self:FreshLevelInfo()
    
end

function CardProgressionFavor:OnEventRequestSuccess(interface, localData)
    if interface == Interfaces.OverseaCardGift then
        local co = CardProgressionUtils.BlockerAndStartCo("CardProgressionFavor.RequestSuccessGift", function ()
            
            ---@type CardDojo
            local dojo              = localData.dojo
            local originLevel       = checkNumber(dojo.favorabilityLevel)
            local isChange = self._originLevel ~= originLevel
            self._originLevel = originLevel
            self._cardDojo = dojo
            
            self._goodsInfo = nil
            
            self._isCanCloseAni = not isChange
            KTool.SetActive(self.FeelingAnim.gameObject, isChange)
            KTool.SetActive(self.Content.gameObject, not isChange)
            self:FreshUI()

            self:FreshUnlockContent(isChange, originLevel)
            if isChange then
                Events.Broadcast(CardProgressionConstants.EventNames.FavorChange, originLevel)
                
                CriWareUtils.PlaySe(UISheets.SFX_UI_SE.path, UISheets.SFX_UI_SE.ui_se_love_upgrade)
                self.TextNumber.text = originLevel
                cs_coroutine.yield_return()
                
                self.FeelingAnim:Play(AnimInName)
                while self.FeelingAnim:IsPlaying(AnimInName) do
                    cs_coroutine.yield_return()
                end


                self._isCanCloseAni = true
            else
                CriWareUtils.PlaySe(UISheets.SFX_UI_SE.path, UISheets.SFX_UI_SE.ui_se_love_gift)
                self:FreshDialogueNode(true, CardProgressionConstants.FavorWordType.PresentGift)
            end

            
            self._cos[Interfaces.OverseaCardGift] = nil
        end)

        self._cos[Interfaces.OverseaCardGift] = co

    elseif interface == Interfaces.OverseaCardDrawFavorRewards then
        ---@type CardDojo
        local dojo              = localData.dojo
        self._cardDojo          = dojo
        self._receivedLevel2Res = dojo:GetFavorLv2ReceivedRes()

        self:FreshRewardNodes()
        
        local rewards, property, level = localData.rewards, localData.property, localData.level
        local closeCallback = function()
            if not string.isEmpty(property) then
                KTool.SetActive(self.Content.gameObject, false)
                self._isPresentGiftSuccess = true
                local lv2res = clone(self._cardDojo:GetFavorLv2ReceivedRes())
                lv2res[level] = nil
                local attributes = CardProgressionUtils.CompareDojoAttributes(self._cardDojo, {favorLv2ReceivedRes = lv2res})
                UIModule.OpenDialog(UIArgs(Constants.UITypeIds.CardProgressionAttributePromoteSuccess, {attributes = attributes}))
                
            end
        end

        if next(rewards) then
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = rewards, cb = closeCallback } })
        else
            closeCallback()
        end

    end
end


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionFavor
