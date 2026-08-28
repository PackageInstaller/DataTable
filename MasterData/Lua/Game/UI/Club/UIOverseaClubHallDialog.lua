-------------------------------------------------------------------------------
-- 社团 - 社团大厅界面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-03-12 17:06:35
-------------------------------------------------------------------------------

local UIEffectCapturedImage   = CS.UGUI.Effects.UIEffectCapturedImage
local ClubHallSceneController = import('Game.UI.Club.UIOverseaClubHallSceneController')

local SwitchSignboardBlockName = 'UIOverseaClubHallDialog_SwitchSignboardBlockName'  -- 切换猫看板

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubHallDialog.prefab > name: OverseaClubHallDialog
---@class UIOverseaClubHallDialog
---@field Env                           	UIOverseaClubHallDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RootNode                      	UnityEngine.RectTransform               	@ 0    根节点
---@field SwitchUIBtn                   	UnityEngine.RectTransform               	@ 1    开关UI按钮
---@field SwitchUIImage                 	UnityEngine.RectTransform               	@ 2    开关UI图片
---@field ContainerNode                 	UnityEngine.RectTransform               	@ 3    内容更节点
---@field ClubAvatarBtn                 	UnityEngine.RectTransform               	@ 4    社团形象按钮
---@field ClubActivityBtn               	UnityEngine.RectTransform               	@ 5    社团-活动按钮
---@field ClubStoreBtn                  	UnityEngine.RectTransform               	@ 6    社团-商店按钮
---@field ClubDetailsBtn                	UnityEngine.RectTransform               	@ 7    社团-详情按钮
---@field ClubDonateBtn                 	UnityEngine.RectTransform               	@ 8    社团-建设按钮
---@field ChatNodeBtn                   	UnityEngine.RectTransform               	@ 9    聊天按钮
---@field CatActListBtn                 	UnityEngine.RectTransform               	@ 10   
---@field CatInteractionBtnRoot         	UnityEngine.RectTransform               	@ 11   
---@field CatInteractionAnimation       	UnityEngine.Animation                   	@ 12   
local UIOverseaClubHallDialog = Class('UIOverseaClubHallDialog')


function UIOverseaClubHallDialog:__init()
    ---@type UnityEngine.Transform @ 遮黑加载界面
    self.uiBlackOverlay_ = nil

    ---@type Engine.Lib.BehaviourAction @ 更新组件
    self.mainLoopAction_ = nil

    ---@type UIOverseaClubHallSceneController @ 场景控制器
    self.sceneController_ = nil

    ---@type UnityEngine.Coroutine @ 切换看板板协程
    self.switchSignboardCo_ = nil

    ---@type UGUI.Effects.UIEffectCapturedImage @ 退出时截屏控件（防止一瞬间先露出主界面）
    self.sceneCapturedImg_ = nil
end


function UIOverseaClubHallDialog:__delete()
    self.uiBlackOverlay_    = nil
    self.mainLoopAction_    = nil
    self.sceneController_   = nil
    self.switchSignboardCo_ = nil
    self.sceneCapturedImg_  = nil
end


function UIOverseaClubHallDialog:OnFocus(isFocus)
    if isFocus then
        CfUtils.SetTopRightProjection(0)
        CfUtils.SetUICameraProjection(false, 26)

        -- update topGoods
        local buildGetGoodsId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.BUILD1_GET_GID)
        CfUtils.RefreshTopGoods({Constants.Currency.FreeDiamondId, Constants.Currency.GoldId, buildGetGoodsId})

        -- 遇到过一个问题：点击详情按钮，打开的信息界面中也需要侦听 Constants.RedPointConst.ClubMembers
        -- 然后关闭信息界面时，会移除自己建立过的全部侦听，这时会把大厅界面的响应也置空掉
        -- 所以解决方案是，从信息界面回来时，重新建立本界面的红点侦听
        self:BindRedPoint_()
    end
end


function UIOverseaClubHallDialog:Awake()
    self.sceneController_      = ClubHallSceneController.New()
    self.sceneCapturedImg_     = CfUtils.GetOrAddComponent(self.controller.gameObject, UIEffectCapturedImage)
    self.mainLoopAction_       = CfUtils.BehaviourActionAdd(self.controller, Bind(self, self.OnMainUpdateBehaviourHandler_))
    --self.updateInfoEventCB_    = Events.AddListener(ClubUtils.EventName.UPDATE_INFO, Bind(self, self.OnClubUpdateInfoHandler_))
    --self.updateNameEventCB_    = Events.AddListener(ClubUtils.EventName.UPDATE_NAME, Bind(self, self.OnClubUpdateNameHandler_))
    --self.kickoutSelfEventCB_   = Events.AddListener(ClubUtils.EventName.KICKOUT_SELF, Bind(self, self.OnClubKickoutSelfHandler_))
    --self.updateMembersEventCB_ = Events.AddListener(ClubUtils.EventName.UPDATE_MEMBERS, Bind(self, self.OnClubUpdateMembersHandler_))
    --self.onFeedCatCloseEventCB_ = Events.AddListener(ClubUtils.EventName.FeedCat_Close, Bind(self, self.OnFeedCatCloseHandler_))
    
    self.eventsDecorated_ = CfUtils.EventsDecorated({
        [ClubUtils.EventName.UPDATE_INFO] = Bind(self, self.OnClubUpdateInfoHandler_),
        [ClubUtils.EventName.UPDATE_NAME] = Bind(self, self.OnClubUpdateNameHandler_),
        [ClubUtils.EventName.KICKOUT_SELF] = Bind(self, self.OnClubKickoutSelfHandler_),
        [ClubUtils.EventName.UPDATE_MEMBERS] = Bind(self, self.OnClubUpdateMembersHandler_),
        [ClubUtils.EventName.FeedCat_Open] = Bind(self, self.OnFeedCatOpenHandler_),
        [ClubUtils.EventName.FeedCat_Close] = Bind(self, self.OnFeedCatCloseHandler_),
        [ClubUtils.EventName.FeedCat_CatClick] = Bind(self,self.OnClickClubDonateButtonHandler_)
    })
    
    SetButtonAction(self.SwitchUIBtn, Bind(self, self.OnClickSwitchUIButtonHandler_))
    SetButtonAction(self.ClubStoreBtn, Bind(self, self.OnClickClubStoreButtonHandler_))
    SetButtonAction(self.ClubAvatarBtn, Bind(self, self.OnClickClubSignboardButtonHandler_))
    SetButtonAction(self.ClubActivityBtn, Bind(self, self.OnClickClubActivityButtonHandler_))
    SetButtonAction(self.ClubDetailsBtn, Bind(self, self.OnClickClubDetailsButtonHandler_))
    SetButtonAction(self.ClubDonateBtn, Bind(self, self.OnClickClubDonateButtonHandler_))
    SetButtonAction(self.CatActListBtn, Bind(self, self.OnClickCatListButtonHandler_))

    self.actListOpen = false
    local actBtnCounts = self.CatInteractionBtnRoot.childCount

    for i = 1, actBtnCounts do
        local btnName = 'BtnAct'
        if i > 1 then
            btnName = btnName .. tostring(i)
        end
        local btnGo = self.CatInteractionBtnRoot:Find(btnName)
        if btnGo then
            SetButtonAction(btnGo, function ()
                self:OnClickCatActButtonHandler_(i)
            end)
        end
    end
end


function UIOverseaClubHallDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = CfUtils.DialogSafeParameters(self.controller)

        -- init chatButton
        ---@type OverseaChatButtonNode
        local chatButtonNode = CfUtils.GetLuaScr(self.ChatNodeBtn, 'Game.OverseaChat.OverseaChatButtonNode')
        if isNotNull(chatButtonNode) then
            local ChatConstants = import('Game.OverseaChat.ChatConstants')
            chatButtonNode:SetChannelFilter({ChatConstants.Channels.Union})
            chatButtonNode:SetButtonCallback(function()
                CfUtils.DialogOpen(Constants.UITypeIds.OverseaChatMainDialog, {type = ChatConstants.Channels.Union})
            end)
        end

        -- init controller
        self.sceneController_:OnStart()

        -- bind redPoint
        self:BindRedPoint_()

        -- init views
        self:SetHideUIMode(false)
        self:ShowBlackOverlay_()
        self.sceneCapturedImg_.raycastTarget = false

        -- request homeData
        GameUtils.Request(Interfaces.OverseaClubHomeData, {}, function(request, response)
            if checkInt(response.errCode) == 0 then
                
                -- update clubHomeData
                local responseData = checkTable(response.data)
                ClubUtils.GetClubComp():UpdateClubData(responseData)

                if isNotNull(responseData.unDrawClubCatCarTrackChest) and checkNumber(responseData.unDrawClubCatCarTrackChest) == 0 then
                    GameUtils.SetRedPointNum(Constants.RedPointConst.ClubCatCarTrackChest, 1)
                else
                    GameUtils.SetRedPointNum(Constants.RedPointConst.ClubCatCarTrackChest, 0)
                end

                ---@type OverseaClubFeedCatMgr
                local feedCatMgr = import("Game.UI.Club.FeedCat.OverseaClubFeedCatMgr"):GetInstance()
                --TODO deleteThis
                feedCatMgr:Reset()
                feedCatMgr.Server.dojo:Init(responseData)
                ClubUtils.GetClubComp():CheckDonationRedPoint()

                ---gvg red point
                ClubUtils.GetClubComp():CheckGvgRedPoint()
                
                -- to load scene
                self.sceneController_:LoadScene(function()
                    -- self:CheckPopupInfo()
                end)

            else
                -- request error to return
                self.sceneController_.isSceneLoaded_ = true
                CoStart(function()
                    CoYield()
                    CfUtils.DialogBack()
                    GameUtils.Toast(tostring(response.errMsg))
                end)
            end
        end)

        while checkBool(self.sceneController_:IsSceneLoaded()) == false do
            CoYield()
        end
    end)
end


function UIOverseaClubHallDialog:OnFinalize()
    return CoWaitDo(function()
        self:HideBlackOverlay_()
        self:CancelSwitchSignboard_()
        self.sceneController_:UnloadScene()
        
        if self.sceneController_.connectToServer then
            ClubUtils.GetClubComp():ExitScene()
        end

        CfUtils.BehaviourActionDel(self.mainLoopAction_)
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true) -- 主场景 场景显示

        -- remove event
        CfUtils.EventsUndecorated(self.eventsDecorated_)

        -- remove redPoint
        self:UnbindRedPoint_()

        self.sceneController_:OnDestroy()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


function UIOverseaClubHallDialog:OnCaptureAction()
    -- 按back键的执行顺序：OnHide -> OnCaptureAction
    -- 按home键的执行顺序：OnCaptureAction -> OnHide
    -- 所以为了兼容两种情况，避免执行两次截屏，截屏过就要标记为nil，防止二次执行
    if self.sceneCapturedImg_ then
        self.sceneCapturedImg_:Capture()
        self.sceneCapturedImg_ = nil
        CoYield() -- wait capture
    end
end


function UIOverseaClubHallDialog:OnHide()
    return CoWaitDo(function()
        CoYield(self:OnCaptureAction())
    end)
end


-------------------------------------------------
-- get / set

---@return boolean
function UIOverseaClubHallDialog:IsHideUIMode()
    return checkBool(self.IsHideUIMode_)
end
function UIOverseaClubHallDialog:SetHideUIMode(isHide)
    self.IsHideUIMode_ = checkBool(isHide)
    self:UpdateUISwitchState_()
end


-------------------------------------------------
-- public

function UIOverseaClubHallDialog:CheckPopupInfo()
    if self:CheckClubBossResult() then
        return
    end
    if self:CheckImpeachResult() then
        return
    end
end


--- 检查 社团boss结果
---@return boolean
function UIOverseaClubHallDialog:CheckClubBossResult()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    if next(clubHomeDojo.bossResultInfo) ~= nil then
        CfUtils.DialogOpen(Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel, {
            levelUpType = Constants.UICultivateLevelUpFinishType.ClubBossRankConfirm,
            data        = clubHomeDojo.bossResultInfo,
            closeCb     = function()
                clubHomeDojo.bossResultInfo = {}
                self:CheckPopupInfo()
            end
        })
        return true
    end
    return false
end


--- 检查 会长弹劾结果
---@return boolean
function UIOverseaClubHallDialog:CheckImpeachResult()
    local clubHomeDojo    = ClubUtils.GetClubComp():GetHomeDojo()
    local impeachmentDojo = clubHomeDojo.impeachmentDojo
    if impeachmentDojo.isNewImpeachment then
        CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubImpeachFail, {
            close = function()
                impeachmentDojo.isNewImpeachment = false
                self:CheckPopupInfo()
            end
        })
        return true
    else
        if impeachmentDojo:IsImpeachSuccess() then
            local managerPlayerId   = impeachmentDojo.newClubManagerId
            local managerMemberDojo = ClubUtils.GetClubComp():ClubMemberFind(managerPlayerId)
            if managerMemberDojo then
                CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubImpeachSuccess, {
                    memberDojo = managerMemberDojo,
                    closeCb    = function()
                        impeachmentDojo.newClubManagerId = 0
                        ClubUtils.GetClubComp():ClubMemberChangeJob(managerPlayerId, ClubUtils.JobType.CHAIRMAN)
                        self:CheckPopupInfo()
                    end})
                return true
            end
        end
    end
    return false
end


-------------------------------------------------
-- private

function UIOverseaClubHallDialog:BindRedPoint_()
    GameUtils.BindRedPoint(Constants.RedPointConst.ClubMembers, self.ClubDetailsBtn, true)
    GameUtils.BindRedPoint(Constants.RedPointConst.ClubDonation, self.ClubDonateBtn, true)
    GameUtils.BindRedPoint(Constants.RedPointConst.ClubActivity, self.ClubActivityBtn, true)
end


function UIOverseaClubHallDialog:UnbindRedPoint_()
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.ClubMembers)
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.ClubDonation)
    GameUtils.RemoveRedPointCallBack(Constants.RedPointConst.ClubActivity)
end


-- 显示 遮黑加载界面
function UIOverseaClubHallDialog:ShowBlackOverlay_()
    local entryTime, endTime, uiBlackOverlayGo = GameUtils.ShowBlackOverlay(nil, function()
        while self.sceneController_:IsSceneLoaded() == false do
            CoYield()
        end
    end, function()
        self:CheckPopupInfo()
    end)
    self.uiBlackOverlay_ = uiBlackOverlayGo
end


-- 关闭 遮黑加载界面
function UIOverseaClubHallDialog:HideBlackOverlay_()
    if isNotNull(self.uiBlackOverlay_) then
        CfUtils.SafeDelete(self.uiBlackOverlay_.gameObject)
        self.uiBlackOverlay_ = nil
    end
end


function UIOverseaClubHallDialog:UpdateUISwitchState_()
    local isHideUIMode = self:IsHideUIMode()
    CfUtils.SetCanvasGroupInteractable(self.ContainerNode, not isHideUIMode)
    CfUtils.SetCanvasGroupAlpha(self.ContainerNode, isHideUIMode and 0 or 1)
    CfUtils.SetUISwitchImage(self.SwitchUIImage, isHideUIMode and 1 or 2)
end


function UIOverseaClubHallDialog:StarSwitchSignboardCo_()
    CfUtils.ConditionAppend(SwitchSignboardBlockName)
    self.switchSignboardCo_ = CoStart(function()
        -- 切换完成前，锁操作
        local myselfDojo = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
        while not self.sceneController_:IsExitSignboardCat(myselfDojo.playerId) do
            CoYield()
        end
        self:CancelSwitchSignboard_()
    end)
end


function UIOverseaClubHallDialog:CancelSwitchSignboard_()
    CfUtils.ConditionRemove(SwitchSignboardBlockName)
    if self.switchSignboardCo_ then
        CoStop(self.switchSignboardCo_)
        self.switchSignboardCo_ = nil
    end
end


-------------------------------------------------
-- handler

function UIOverseaClubHallDialog:OnMainUpdateBehaviourHandler_()
    if self.sceneController_ then
        self.sceneController_:OnUpdate()
    end
end


function UIOverseaClubHallDialog:OnClubUpdateInfoHandler_()
    self.sceneController_:UpdateTvClubHead()
end


function UIOverseaClubHallDialog:OnClubUpdateNameHandler_()
    self.sceneController_:UpdateTvClubName()
end


function UIOverseaClubHallDialog:OnClubUpdateMembersHandler_(data)
    ---@type ClubMemberDojo
    local newMemberDojo = data.newMemberDojo
    if newMemberDojo then
        self.sceneController_:SignboardCatAppend(newMemberDojo.playerId, newMemberDojo.clubSignboarId)
    else
        local removePlayerId = checkInt(data.removePlayerId)
        self.sceneController_:SignboardCatRemove(removePlayerId)
    end
end


function UIOverseaClubHallDialog:OnClickSwitchUIButtonHandler_()
    self:SetHideUIMode(not self:IsHideUIMode())
end


function UIOverseaClubHallDialog:OnClickClubSignboardButtonHandler_()
    CfUtils.SetActive(self.RootNode, false)
    self.sceneController_:FocusExchangeVcam()

    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubHallChangeCatDialog, {
        closeCb = function()
            CfUtils.SetActive(self.RootNode, true)
            if self.sceneController_ then
                self.sceneController_:UnfocusExchangeVcam()
            end
        end,
        setCatCb = function(signboardId)
            local myselfDojo = ClubUtils.GetClubComp():GetHomeDojo().myselfDojo
            self.sceneController_:SignboardCatRemove(myselfDojo.playerId)
            self.sceneController_:SignboardCatAppend(myselfDojo.playerId, signboardId)
            self:StarSwitchSignboardCo_()
        end,
    })
end


function UIOverseaClubHallDialog:OnClickClubActivityButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubActivityDialog)
end


function UIOverseaClubHallDialog:OnClickClubStoreButtonHandler_()
    ---@type GroceryUtils
    local GroceryUtils = import('Game.Grocery.GroceryUtils')
    ---@type GroceryConstants
    local GroceryConstants = import('Game.Grocery.GroceryConstants')
    GroceryUtils.OpenGroceryStore(GroceryConstants.GroceryType.Club, {
        UIArgs(Constants.UITypeIds.UIOverseaClubHallDialog)
    })
end


function UIOverseaClubHallDialog:OnClickClubDetailsButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubEntryDialog)
end


function UIOverseaClubHallDialog:OnClickClubDonateButtonHandler_()
    if self.feedCatOpened then
        return
    end
    CfUtils.DialogOpen(Constants.UITypeIds.OverseaClubFeedCatMain)
end

function UIOverseaClubHallDialog:OnClickCatListButtonHandler_()
    self.actListOpen = not self.actListOpen

    if self.actListOpen then
        CfUtils.PlayAnimation(self.CatInteractionAnimation, "OverseaClubHallDialog_CatInteract_Go")
    else
        CfUtils.PlayAnimation(self.CatInteractionAnimation, "OverseaClubHallDialog_CatInteract_Back")
    end
    
end

function UIOverseaClubHallDialog:OnClickCatActButtonHandler_(index)
    printInfo("[UIOverseaClubHallDialog] cat act button click, index: %s", index)
    if self.sceneController_.connectToServer then
        AppService:GetInstance():SendTcpData(Constants.Packets.OverseaClubPlayInteraction, {type=index})
    end
    Events.Broadcast(ClubUtils.EventName.DO_INTERACTION, GameUtils.GetPlayerId(), index)
end


function UIOverseaClubHallDialog:OnClubKickoutSelfHandler_()
    GameUtils.Toast(localize('您已被踢出社团'))
    Events.Broadcast(Constants.EventNames.CLOSE_COMMON_TIPS_BOARD, {name = 'CommonPlayerHeadOption'})
    CfUtils.StartCoroutineWithBlocker(function()
        Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)  -- 显示主场景，防止一瞬间出现的天空盒
        CoYield(CfUtils.DialogCloseAll())
        CoYield(CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubListDialog, nil, {UIArgs(Constants.UITypeIds.UIHomeView)}))
    end)
end

function UIOverseaClubHallDialog:OnFeedCatOpenHandler_()
    self.feedCatOpened = true
    self:SetHideUIMode(true)
    CfUtils.SetCanvasGroupAlpha(self.SwitchUIBtn, 0)
    self.sceneController_:FocusFeedCatVcam()
end
function UIOverseaClubHallDialog:OnFeedCatCloseHandler_()
    self.feedCatOpened = false
    self:SetHideUIMode(false)
    CfUtils.SetCanvasGroupAlpha(self.SwitchUIBtn, 1)
    self.sceneController_:UnfocusFeedCatVcam()
end

return UIOverseaClubHallDialog
