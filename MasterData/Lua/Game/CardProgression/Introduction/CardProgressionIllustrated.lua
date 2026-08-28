--- 养成-档案界面

------------ import ------------
---@type Engine.Lib.KTool
local KTool                    = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr              = CardConfMgr:GetInstance()
---@type RoleVoiceMgr
local roleVoiceMgr             = RoleVoiceMgr:GetInstance()
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
---@type CardProgressionUtils
local CardProgressionUtils     = import("Game.CardProgression.CardProgressionUtils")
local CDTimerModule = CS.Engine.Modules.CDTimerModule.GetInstance()
local CriSoundMgr = CS.Engine.Lib.CriSoundMgr
---@type CriWareUtils
local CriWareUtils =  import('Game.Entry.CriWareUtilsFix')
local CardProgressionMgr = import('Game.CardProgression.CardProgressionMgr')
------------ import ------------


------------ define ------------
local ViewType = CardProgressionConstants.IllustratedViewType

local VoiceStatus = CardProgressionConstants.VoiceStatus

local NodeStatus = CardProgressionConstants.NodeStatus
------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaIllustratedHandbook.prefab > name: CultivateOverseaIllustratedHandbook
---@class CardProgressionIllustrated
---@field Env                           	CardProgressionIllustrated              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TextDescIntroduction          	CustomText                              	@ 0    
---@field TextDescCreed                 	CustomText                              	@ 1    
---@field TextDescBaseIntroduction      	CustomText                              	@ 2    
---@field BaseInformation               	UnityEngine.RectTransform               	@ 3    
---@field ArmIntroduction               	UnityEngine.RectTransform               	@ 4    
---@field Lock                          	UnityEngine.RectTransform               	@ 5    
---@field TxtDetails                    	CustomText                              	@ 6    
---@field ScrollView                    	UnityEngine.UI.ScrollRect               	@ 7    
---@field StoryList                     	SuperScrollView.LoopListView2           	@ 8    
---@field ArchivesPanel                 	UnityEngine.RectTransform               	@ 9    
---@field TxtLeftName                   	UnityEngine.UI.Text                     	@ 10   
---@field TxtContent                    	LetterTyperComp                         	@ 11   
---@field DialogueFrameNode             	UnityEngine.RectTransform               	@ 12   
---@field VoiceLoopList                 	SuperScrollView.LoopListView2           	@ 13   
---@field ArmedVoice                    	UnityEngine.RectTransform               	@ 14   
---@field CommonTabToggleUp             	UnityEngine.RectTransform               	@ 15   
---@field PanelAnimation                	UnityEngine.CanvasGroup                 	@ 16   
---@field CatDetails                    	UnityEngine.RectTransform               	@ 17   
---@field ImgCat                        	Engine.UI.ImageAlterable                	@ 18   
---@field CatDetailsTextTitle           	UnityEngine.UI.Text                     	@ 19   
---@field CatDetailsTextDesc            	CustomText                              	@ 20   
---@field MiddlePanel                   	UnityEngine.RectTransform               	@ 21   
local CardProgressionIllustrated = Class('CardProgressionIllustrated')

function CardProgressionIllustrated:__init()
    self._storyIndex = 0
    self._voiceIndex = nil
    
    self._isInitialize = false
end

function CardProgressionIllustrated:__delete()

end

function CardProgressionIllustrated:Awake()
end

function CardProgressionIllustrated:Start()
    self.__EventRequestSuccess = Events.AddListener(CardProgressionConstants.EventNames.RequestSuccess, Bind(self, self.OnEventRequestSuccess))
end

function CardProgressionIllustrated:OnDestroy()
    if self.__EventRequestSuccess then
        Events.RemoveListener(CardProgressionConstants.EventNames.RequestSuccess, self.__EventRequestSuccess)
        self.__EventRequestSuccess = nil
    end
    self:StopTimer()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

-- function CardProgressionIllustrated:OnInitialize()
--     if self._isInitialize then return end
--     self._isInitialize = false

-- end

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

function CardProgressionIllustrated:FreshUI(cardId, selectType)
    self:InitData(cardId, selectType)
    self:FreshModelSwitchNode()
    self:InitTabToggle(cardId)
end

function CardProgressionIllustrated:InitData(cardId, selectType)
    ---@type CardVo
    local cardVo = cardConfMgr:GetCardByRefId(cardId)
    local roleId = cardVo.characterId
    self._roleId = roleId
    self._cardId = checkNumber(cardId)
    self._cardVo = cardVo

    ---@type CardComponent
    local cardComp            = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local playerCardId        = cardComp:GetIdByCardId(self._cardId)
    ---@type CardDojo
    local cardDojo            = cardComp:GetCardById(playerCardId)
    if cardDojo then
        self._storyId2ReceivedRes = cardDojo:GetStoryId2ReceivedRes()
    end
    self._cardDojo            = cardDojo
    self._playerCardId        = playerCardId

    ---@type RolesVo
    self._roleVo = cardConfMgr:GetRolesVo(cardVo.characterId)

    ---@type IllustratedRoleCardVo
    self._illustratedRoleCardVo = cardConfMgr:GetIllustratedRoleCardVo(cardId)

    self._selectIndex = 1
    self._selectType = selectType or ViewType.Introduction
end

function CardProgressionIllustrated:InitTabToggle(cardId)
    local redPointStatus = CardProgressionUtils.IsCanReceiveStoryReward(self._cardDojo, true)

    local limitCatTypeList = parse_strings(cardConfMgr:GetCardProgressionParamsById(CardProgressionConstants.Params.IllustratedCatTypeLimit))
    local catType2res = {}
    for key, value in pairs(limitCatTypeList) do
        catType2res[checkNumber(value)] = true
    end

    ---@type CommonTabToggleUp
    local env = CfUtils.GetLuaScr(self.CommonTabToggleUp.gameObject, CardProgressionConstants.EnvPath.CommonTabToggleUp)

    local viewTypeConfig = {
        {ViewType.Introduction, localize("角色简介"), CardProgressionConstants.ModelType.Role},
        {ViewType.CatDetail,    localize("亲缘"),    CardProgressionConstants.ModelType.Cat},
        {ViewType.Overview,     localize("个人故事")},
        
    }

    if next(self:GetVoiceList()) ~= nil then
        table.insert(viewTypeConfig, {ViewType.Voice,        localize("语音") })
    end

    ---@type CardVo
    local cardVo = self._cardVo
    local catType = cardVo.catType

    local InsertData = function(index, modelType, viewType)
        if modelType then
            self:SwitchModel(modelType)
        end
        self._selectIndex = index
        self._selectType = viewType
        self:FreshSubUI()
    end

    local realIndex = 0
    local toggleDataList = {}
    for index, conf in ipairs(viewTypeConfig) do
        local viewType, text, modelType, checkFunc = SafeUnpack(conf)
        local isCanInsert = true
        if viewType == ViewType.CatDetail then
            --- 【TW0424】养成里增加【亲缘】页签，是猫的卡牌显示该页签，不是猫的隐藏页签（血统猫种表id=1或者2的，隐藏页签）
            -- isCanInsert = catType ~= 1 and catType ~= 2 
            isCanInsert = not catType2res[catType]
            
        end
        if isCanInsert then
            table.insert(toggleDataList, {
                text = text,
                checkFunc = checkFunc,
                func = function (i)
                    InsertData(i, modelType, viewType)
                end,
                redPointStatus = ViewType.Overview == viewType and redPointStatus or false
            })
            realIndex = realIndex + 1
            if viewType == self._selectType then
                self._selectIndex = realIndex
            end
        end

    end
    -- print(table.toString(toggleDataList))

    env:FillToggles(toggleDataList, self._selectIndex)

    self._viewType2SelectFunc = {
        [ViewType.Introduction] = Bind(self, self.FreshIntroductionUI),
        [ViewType.CatDetail] = Bind(self, self.FreshCatDetailUI),
        [ViewType.Overview] = Bind(self, self.FreshOverviewUI),
        [ViewType.Voice] = Bind(self, self.FreshVoiceUI),
    }

    self:FreshSubUI()

end

function CardProgressionIllustrated:FreshSubUI()
    local selectType = self._selectType
    KTool.SetActive(self.ArmedVoice.gameObject,      selectType == ViewType.Voice)
    KTool.SetActive(self.CatDetails.gameObject,      selectType == ViewType.CatDetail)
    KTool.SetActive(self.ArchivesPanel.gameObject,   selectType == ViewType.Overview)
    KTool.SetActive(self.ArmIntroduction.gameObject, selectType == ViewType.Introduction)
    local func = self._viewType2SelectFunc[selectType]
    if func then
        func()
    end
end

---------------------------------------------------
--- Introduction begin --
---------------------------------------------------

function CardProgressionIllustrated:FreshIntroductionUI()
    if self._isInitIntroduction then
        return
    end
    self._isInitIntroduction = true
    
    local roleVo = self._roleVo
    if roleVo == nil then
        return
    end
    local baseInfos = {
        localize("全名：_name_", {_name_ = roleVo.allName}),
        localize("CV：_name_",  {_name_ = self._cardVo.cv}),
        localize("生日：_name_", {_name_ = roleVo.birthday}),
        localize("性格：_name_", {_name_ = roleVo.personality}),
        localize("象征：_name_", {_name_ = roleVo.symbolize}),
    }

    local child  = self.TextDescBaseIntroduction
    local parent = self.BaseInformation.gameObject
    for index, value in ipairs(baseInfos) do
        if index == 1 then
            child.text = value
        else
            local go = parent:AddChild(child.gameObject)
            local textComp = go:GetComponent(CardProgressionConstants.CompType.TextType)
            if isNotNull(textComp) then
                textComp.text = value
            end
        end
    end

    self.TextDescCreed.text = roleVo.faith
    self.TextDescIntroduction.text = roleVo.info
end

---------------------------------------------------
--- Introduction end --
---------------------------------------------------

---------------------------------------------------
--- CatDetail begin --
---------------------------------------------------
function CardProgressionIllustrated:FreshCatDetailUI()
    ---@type CardVo
    local cardVo = self._cardVo
    local catType = cardVo.catType
    
    ---@type CatTypeVo
    local vo = cardConfMgr:GetCatTypeVoById(catType)
    self.CatDetailsTextTitle.text = vo.name
    self.CatDetailsTextDesc.text = vo.introduction
    self.ImgCat:LoadSprite(vo.collectionBook)

    self:PlayCatVoice(vo.voice)
end

function CardProgressionIllustrated:StopCatVoice()
    if self._voice then
        CriWareUtils.StopById(self._voice)
        self._voice = nil
    end
end
function CardProgressionIllustrated:PlayCatVoice(voice)
    self:StopPlayedVoice()
    self:StopCatVoice()
    local se = CriWareUtils.PlaySeById(voice)
    if isNull(se) then
        self._voice = voice
        printError("对应%s缺少指定音效资源，请检查音效资源表------>>", voice)
    end
    
end

---------------------------------------------------
--- CatDetail end --
---------------------------------------------------


function CardProgressionIllustrated:FreshOverviewUI()
    self:FreshStoryList()
    self:FreshDetail(self._storyIndex)
    
    self.ScrollView.verticalNormalizedPosition = 1

end

function CardProgressionIllustrated:FreshDetail(index)
    if index <= 0 then
        return
    end
    local storyList = self:GetStoryList()
    local storyData = storyList[index]
    local isUnlock  = storyData.status == NodeStatus.Unlock
    
    KTool.SetActive(self.Lock.gameObject, not isUnlock)
    KTool.SetActive(self.ScrollView.gameObject, isUnlock)
    if isUnlock then
        self.TxtDetails.text = storyData.text
        
    end
end

---------------------------------------------------
--- story begin --
---------------------------------------------------
function CardProgressionIllustrated:FreshStoryList()
    local ScrollView = self.StoryList
    local count = #self:GetStoryList()

    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetStoryItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end

function CardProgressionIllustrated:OnGetStoryItemByIndex(listView, index)
    if index < 0 then
        return nil
    end

    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local storyCell = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionIllustratedStoryCell)
    ---@type CardProgressionIllustratedStoryCell
    local env = storyCell.Env
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        storyCell:Init()
        env = storyCell.Env
        env:SetCallback(function (data, index)
            -- local unlockLv = self._unlockFiles[index]
            local isLock  = data.status == NodeStatus.Lock
            if isLock then
                GameUtils.Toast(localize("好感度_num_级解锁", {_num_ = data.limitLv}))
                return
            end
            if self._storyIndex ~= index then
                local status = data.status
                local isCanUnlock = status == NodeStatus.CanUnlock
                if isCanUnlock then
                    -- if true then
                    --     ---@type CardDojo
                    --     local cardDojo     = self._cardDojo
                    --     cardDojo:AddStoryId2ReceivedRes(index)
                    --     Events.Broadcast(CardProgressionConstants.EventNames.RequestSuccess, Interfaces.OverseaCardStoryRewardsReceive, {rewards = {{goodsId = 3000002, num = 5}} , storyId = index})
                    --     return
                    -- end
                    self:RequestStoryUnlock(index)
                else
                    self:SwitchStory(index, status)
                end
                
            end
        end)
    end
    if not KTool.IsNull(env) then
        local luaIndex  = index + 1
        local storyList = self:GetStoryList()
        local storyData = storyList[luaIndex]
        env:FreshUI(storyData, luaIndex)
        env:FreshSelectState(self._storyIndex == luaIndex and storyData.status == NodeStatus.Unlock)

    end
        
    return cell
end

function CardProgressionIllustrated:SwitchStory(index, status)
    self:FreshStoryCellSelectState(self._storyIndex, false)
    self:FreshStoryCellSelectState(index, true, false, status == NodeStatus.CanUnlock)
    self._storyIndex = index
    self:FreshDetail(index)
    
    if status == NodeStatus.Unlock then
        self.ScrollView.verticalNormalizedPosition = 1
    end
end

function CardProgressionIllustrated:FreshStoryCellSelectState(index, isSelect, isShowRedPoint, isPlayUnlockAni)
    if index <= 0 then
        return
    end
    local cell = self.StoryList:GetShownItemByItemIndex(index - 1)
    ---@type CardProgressionIllustratedStoryCell
    local env = CfUtils.GetLuaScr(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionIllustratedStoryCell)
    if isNull(env) then
        return
    end
    env:FreshSelectState(isSelect)
    if isPlayUnlockAni then
        env:PlayAnimationUnlock()
    end
    if isShowRedPoint ~= nil then
        env:FreshRedPoint(isShowRedPoint)
    end
end

function CardProgressionIllustrated:RequestStoryUnlock(index)
    ---@type CardProgressionMgr
    local ins = CardProgressionMgr:GetInstance()
    ins:RequestOverseaStoryRewardsReceive({playerCardId = self._playerCardId, storyId = index})
end

---------------------------------------------------
--- story end --
---------------------------------------------------

---------------------------------------------------
--- voice begin --
---------------------------------------------------

function CardProgressionIllustrated:FreshVoiceUI()
    self:FreshVoiceList()
    self:FreshDialogue(false)
end


function CardProgressionIllustrated:FreshVoiceList()
    local ScrollView = self.VoiceLoopList
    local count = #self:GetVoiceList()
    if not ScrollView.IsListViewInit then
        ScrollView:InitListView(count, Bind(self, self.OnGetVoiceItemByIndex))
    else
        GameUtils.ReloadData(ScrollView, count)
    end
end

function CardProgressionIllustrated:OnGetVoiceItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem(CardProgressionConstants.NodeNames.Cell)
    local storyCell = GetLuaBehaviour(cell.gameObject, CardProgressionConstants.EnvPath.CardProgressionIllustratedVoiceCell)
    ---@type CardProgressionIllustratedVoiceCell
    local env = storyCell.Env
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        storyCell:Init()
        env = storyCell.Env
        env:SetCallback(Bind(self, self.OnClickVoiceNodeAction))
    end
    if not KTool.IsNull(env) then
        local luaIndex = index + 1
        local voiceList = self:GetVoiceList()
        local voiceData = voiceList[luaIndex]
        env:FreshUI(voiceData)
        
    end
    return cell
end

function CardProgressionIllustrated:FreshVoiceCellSelectState(index, status, progress)
    local cell = self.VoiceLoopList:GetShownItemByItemIndex(index - 1)
    if isNull(cell) then
        return
    end
    ---@type CardProgressionIllustratedVoiceCell
    local env = CfUtils.GetLuaScr(cell, CardProgressionConstants.EnvPath.CardProgressionIllustratedVoiceCell)
    if isNull(env) then
        return
    end
    env:FreshStatus(status, progress)

end

function CardProgressionIllustrated:FreshVoiceCellProgress(index, progress)
    local cell = self.VoiceLoopList:GetShownItemByItemIndex(index - 1)
    ---@type CardProgressionIllustratedVoiceCell
    local env = CfUtils.GetLuaScr(cell, CardProgressionConstants.EnvPath.CardProgressionIllustratedVoiceCell)
    if isNull(env) then
        return
    end
    env:FreshProgress( progress)

end

---点击播放开始倒计时
---@param leftTime number 语音的时间
function CardProgressionIllustrated:StartLeftSecond(leftTime)
    local totalCount = math.ceil(leftTime) --每隔0.1秒计数一次
    self:StopTimer()
    -- 
    self._timer = CDTimerModule:AddCD(0.1, function (count, id)
        local progress = count / totalCount
        
        if count >= totalCount then --语音播放完成
            self:StopPlayedVoice()
            local voiceData = self:GetVoiceList()[self._voiceIndex]
            voiceData.status = VoiceStatus.Pause
            self:FreshVoiceCellSelectState(self._voiceIndex, VoiceStatus.Pause, progress)
            self:StopDialogue()
            self._voiceIndex = nil
            self._playedVoice = nil
        else
            self:FreshVoiceCellProgress(self._voiceIndex, progress)
        end
    end, totalCount, true, true, false, true)
end

function CardProgressionIllustrated:StopTimer()
    if not isNull(self._timer) then
        CDTimerModule:RemoveCD(self._timer)
        self._timer = nil
    end
end

function CardProgressionIllustrated:FreshDialogue(isShow, name, desc)
    KTool.SetActive(self.DialogueFrameNode.gameObject, isShow)
    if not isShow then return end
    -- self:CloseWaitCo()
    
    local txtContent = self.TxtContent
    -- txtContent:ResetArgs()
    if CS.Engine.I18N.I18NModule.Lang ~= "en_US" and CS.Engine.I18N.I18NModule.Lang ~= "en_UK" then
        local ChapterUtils = import('Game.Chapter.ChapterUtils')
        desc = ChapterUtils.ReplaceStr(desc, " ", utf8.char(160))
    end
    CfUtils.FillCfText(self.TxtDesc, desc)
    
    txtContent:SetText(desc, true)
    
    -- txtContent:SetText("")
    -- txtContent.PendingTime     = 0.02 -- 0.02
    -- txtContent.AppearDuration  = 0.2 -- 0.2
    -- txtContent.IgnoreTimeScale = true
    -- txtContent.TextWillFill    = desc
    
    self.TxtLeftName.text = name
    
    -- self._waitCo = CoStart(function()
    --     coroutine.yield(txtContent:StartType())
    --     self._waitCo = nil
    -- end)

end

function CardProgressionIllustrated:StopPlayedVoice()
    if isNotNull(self._playedVoice) then
        CriSoundMgr.Stop(self._playedVoice.CueInfo)
        self._playedVoice = nil
    end
end

-- function CardProgressionIllustrated:CloseWaitCo()
--     if self._waitCo == nil then return end
--     CoStop(self._waitCo)
--     self._waitCo = nil

-- end

function CardProgressionIllustrated:StopDialogue()
    -- local txtContent = self.TxtContent
    -- txtContent:StopType()
    -- txtContent:ShowAll()
    -- self:CloseWaitCo()
    self:FreshDialogue(false)
end

---------------------------------------------------
--- voice end --
---------------------------------------------------

--- OnEnter
--- 进入时调用
function CardProgressionIllustrated:OnEnter()
    
    
end

--- OnEnter
--- 离开时时调用
function CardProgressionIllustrated:OnLeave()
    
    
end

function CardProgressionIllustrated:FreshModelSwitchNode()
    ---@type CardProgressionModelSwitchNode
    local env    = self:GetModelSwitchNodeEnv()
    if isNull(env) then
        return
    end
    env:SetIsInitialize(true)

    if self._cardDojo then
        local skinId = checkNumber(self._cardDojo.cardSkin)
        env:FreshUI(skinId, self._cardDojo)
    else
        local skinId = checkNumber(self._cardVo.defaultSkin)
        env:FreshUI(skinId, nil, true)
    end
end

function CardProgressionIllustrated:SwitchModel(modelType)
    ---@type CardProgressionModelSwitchNode
    local env = self:GetModelSwitchNodeEnv()
    if isNotNull(env) then
        env:OnClickLabelNodeAction(modelType)
    end
end



---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------

function CardProgressionIllustrated:SetFavorLv(favorLevel)
    self._isChange = self._favorLevel ~= favorLevel
    self._favorLevel = checkInt(favorLevel)
end

function CardProgressionIllustrated:GetStoryList()
    if self._storyList and not self._isChange then
        return self._storyList
    end
    self._isChange = false
    local cardId     = self._cardId
    local favorLevel = self._favorLevel
    
    local storyId2ReceivedRes = self._cardDojo and self._cardDojo:GetStoryId2ReceivedRes() or {}

    local informationList = self._illustratedRoleCardVo.informationList
    local storyDataList = {}
    local ids = cardConfMgr:GetFavorableExpRewardIdGroup(cardId)
    for i, id in ipairs(ids) do
        ---@type FavorableExpRewardVo
        local vo = cardConfMgr:GetFavorableExpRewardVo(id)
        local file = checkNumber(vo.file)
        if file > 0 then
            local status = NodeStatus.Lock
            if favorLevel >= vo.level and vo.level > 0 then
                status = storyId2ReceivedRes[file] and NodeStatus.Unlock or NodeStatus.CanUnlock
            end
            
            storyDataList[file] = {
                text = informationList[file],
                status = status,
                limitLv = vo.level,
            }
        end
    end

    self._storyIndex = storyDataList[1].status == NodeStatus.Unlock and 1 or 0
    self._storyList = storyDataList
    return storyDataList
end

function CardProgressionIllustrated:GetVoiceList()
    if self._voiceList then
        return self._voiceList
    end
    ---@type CardComponent
    local cardComp     = GameUtils.GetEntityCompByType(ECSComponentType.Constants.CardComponent)
    local voiceList    = {}
    ---@type RoleVoiceVo[]
    local voiceVos     = roleVoiceMgr:GetVoicesByRoleId(self._roleId)
    local cardId       = self._cardId
    local playerCardId = cardComp:GetIdByCardId(cardId)
    ---@type CardDojo
    local dojo         = cardComp:GetCardById(playerCardId)

    local count = 0
    for k, v in pairs(voiceVos) do
        local voCardId = v.cardID
        if (v.roleType == 3 or v.roleType == 2) and (voCardId == cardId) then
            ---@type SoundVo
            local vo = CfUtils.GetCfVo(AutoIds.IdSetting567, "SoundVo", v:GetVoicecode())
            if vo then
                local errText 
                local status = VoiceStatus.Pause
                
                if (dojo == nil) and checkNumber(voCardId) ~= 0 then --没解锁
                    status = VoiceStatus.Lock
                    errText = localize("获得情绪武装：_name_后解锁", {_name_ = self._cardVo.name})
                else
                    local favorabilityLevel = checkNumber(dojo.favorabilityLevel)
                    local unlockNum = string.split(v.targetNum, ",")[1]
                    if checkNumber(favorabilityLevel) < checkNumber(unlockNum) then--好感度满足
                        status = VoiceStatus.Lock
                        errText = localize("好感度达到_favorLevel_级解锁", {_favorLevel_ = unlockNum})--好感度达到X级解锁
                    end
                end
                count = count + 1
                table.insert(voiceList, {v = v, voiceTime = vo.voiceTime / 1000, status = status, errText = errText, index = count})

            else
                printError("对应%s缺少指定音效资源，请检查音效资源表------>>", v:GetVoicecode())
            end
        end
    end
    self._voiceList = voiceList
    return voiceList
end

---@return CardProgressionModelSwitchNode
function CardProgressionIllustrated:GetModelSwitchNodeEnv()
    if isNull(self._modelSwitchNodeEnv) then
        self._modelSwitchNodeEnv = CfUtils.GetLuaScr(self.MiddlePanel, CardProgressionConstants.EnvPath.CardProgressionModelSwitchNode)
    end
    return self._modelSwitchNodeEnv
end

---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------

function CardProgressionIllustrated:OnClickVoiceNodeAction(voiceData)
    self:StopTimer()
    self:StopDialogue()
    if self._voiceIndex then
        -- if isNotNull(self._playedVoice) then
        --     CriSoundMgr.Stop(self._playedVoice.CueInfo)
        -- end
        self:StopPlayedVoice()
        local oldVoiceData = self:GetVoiceList()[self._voiceIndex]
        oldVoiceData.status = VoiceStatus.Pause

        self:FreshVoiceCellSelectState(self._voiceIndex, VoiceStatus.Pause, 0)
    end
    local index = voiceData.index
    if self._voiceIndex == voiceData.index then
        self._voiceIndex = nil
        return
    end

    if voiceData.status == VoiceStatus.Lock then
        if voiceData.errText then
            GameUtils.Toast(voiceData.errText)
        end
        return
    end

    self._voiceIndex = index
    
    voiceData.status = VoiceStatus.Play
    ---@type RoleVoiceVo
    local voiceVo = voiceData.v
    local status = voiceData.status
    self:FreshVoiceCellSelectState(index, status, 0)
    self:FreshDialogue(true, voiceVo.name, voiceVo:GetDesk())
    self:StopCatVoice()
    self._playedVoice = CriWareUtils.PlayVoiceVoById(voiceVo)

    self:StartLeftSecond(voiceData.voiceTime)
end


function CardProgressionIllustrated:OnEventRequestSuccess(interface, localData)
    if interface == Interfaces.OverseaCardStoryRewardsReceive then
        local rewards = localData.rewards
        if rewards then
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {rewards = rewards})
        end

        local storyId   = localData.storyId
        local storyData = self._storyList[storyId]
        local oldStatus = storyData.status
        storyData.status = NodeStatus.Unlock

        local cardDojo     = self._cardDojo
        cardDojo:AddStoryId2ReceivedRes(storyId)

        self:SwitchStory(storyId, oldStatus)

        ---@type CommonTabToggleUp
        local env = CfUtils.GetLuaScr(self.CommonTabToggleUp.gameObject, CardProgressionConstants.EnvPath.CommonTabToggleUp)
        if isNotNull(env) then
            env:FreshRedPointStatus(self._selectIndex, CardProgressionUtils.IsCanReceiveStoryReward(self._cardDojo, true))
        end

    end
end
---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CardProgressionIllustrated
