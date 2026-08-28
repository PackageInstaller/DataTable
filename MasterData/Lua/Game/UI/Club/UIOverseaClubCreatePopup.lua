-------------------------------------------------------------------------------
-- 社团 - 创建/修改社团弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-20 20:10:44
-------------------------------------------------------------------------------

local HeadGridCellPath = 'Game.UI.Club.UIOverseaClubCreateHeadGridCell'
local HeadGridCellName = 'Cell'

local CREATE_STYLE_DEFINE = {
    CREATE = {styleId = Constants.ButtonFontStyle.B3, text = localize('创建')},
    MODIFY = {styleId = Constants.ButtonFontStyle.B3, text = localize('修改')},
}

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCreateAndModifyPopup.prefab
---@class UIOverseaClubCreatePopup
---@field Env                           	UIOverseaClubCreatePopup                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field topTitleTxt                   	UnityEngine.RectTransform               @ 顶部标题文本
---@field consumePop                    	UnityEngine.RectTransform               @ 消耗节点
---@field createBtn                     	Game.Native.Common.FontStyleButton      @ 创建按钮
---@field levelMinTenBtn                	Engine.UI.ButtonLongPress               @ 等级加十按钮
---@field levelAddTenBtn                	Engine.UI.ButtonLongPress               @ 等级减十按钮
---@field levelMinOneBtn                	UnityEngine.RectTransform               @ 等级减一按钮
---@field levelAddOneBtn                	UnityEngine.RectTransform               @ 等级加一按钮
---@field levelField                    	TMPro.TMP_InputField                    @ 等级输入框
---@field levelInfoNode                 	UnityEngine.RectTransform               @ 等级信息节点
---@field freeTypeToggle                	UnityEngine.UI.Toggle                   @ 自由模式切换按钮
---@field applyTypeToggle               	UnityEngine.UI.Toggle                   @ 申请模式切换按钮
---@field nameModifyBtn                 	UnityEngine.RectTransform               @ 修改名字按钮
---@field nameRemindText                	UnityEngine.RectTransform               @ 名字结果提示文本
---@field nameInput                     	UnityEngine.UI.InputField               @ 名字输入框
---@field headGridView                  	SuperScrollView.LoopGridView            @ 头像网格列表
---@field closeBtn                      	UnityEngine.RectTransform               @ 关闭按钮
---@field backBlock                     	UnityEngine.RectTransform               @ 空白区
local UIOverseaClubCreatePopup = Class('UIOverseaClubCreatePopup')


function UIOverseaClubCreatePopup:__init()
    ---@type table<ClubUtils.ApplyType, UnityEngine.UI.Toggle>
    self.applyTypeToggleMap_ = {}
    ---@type CommonBtnConsumePop
    self.createBtnConsumePop_ = nil
end


function UIOverseaClubCreatePopup:__delete()
    self.applyTypeToggleMap_  = nil
    self.createBtnConsumePop_ = nil
end


function UIOverseaClubCreatePopup:Awake()
    self.applyTypeToggleMap_[ClubUtils.ApplyType.FREE] = self.freeTypeToggle
    self.applyTypeToggleMap_[ClubUtils.ApplyType.APPLY] = self.applyTypeToggle
    SetToggleValueChanged(self.freeTypeToggle, Bind(self, self.OnClickApplyTypeToggleHandler_, ClubUtils.ApplyType.FREE))
    SetToggleValueChanged(self.applyTypeToggle, Bind(self, self.OnClickApplyTypeToggleHandler_, ClubUtils.ApplyType.APPLY))
    
    self.createBtnConsumePop_ = CfUtils.GetLuaScr(self.consumePop, Constants.UILuaTablePath.BtnConsumePop)
    SetButtonAction(self.closeBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.createBtn, Bind(self, self.OnClickCreateOrModifyButtonHandler_))
    SetButtonAction(self.nameModifyBtn, Bind(self, self.OnClickNameModifyButtonHandler_))
    SetGridViewAction(self.headGridView, Bind(self, self.OnUpdateHeadGridCellHandler_))

    self.levelAddTenBtn.onClick = Bind(self, self.OnClickLevelButtonHandler_, 10)
    self.levelMinTenBtn.onClick = Bind(self, self.OnClickLevelButtonHandler_, -10)
    self.levelAddTenBtn.onFixLongPress = Bind(self, self.OnClickLevelButtonHandler_, 10)
    self.levelMinTenBtn.onFixLongPress = Bind(self, self.OnClickLevelButtonHandler_, -10)
    SetButtonAction(self.levelAddOneBtn, Bind(self, self.OnClickLevelButtonHandler_, 1))
    SetButtonAction(self.levelMinOneBtn, Bind(self, self.OnClickLevelButtonHandler_, -1))
    self.levelField.onValueChanged:AddListener(Bind(self, self.OnChangedLevelFieldHandler_))

    self.updateNameEventCB_ = Events.AddListener(ClubUtils.EventName.UPDATE_NAME, Bind(self, self.OnClubUpdateNameHandler_))
end


function UIOverseaClubCreatePopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- switch mode
        local isJoinClub   = ClubUtils.GetClubComp():IsJoinClub()
        local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
        self:SetModifyMode(isJoinClub)
        
        -- generate headData list
        local headDataList  = {}
        local defaultHeadId = ClubUtils.GetParamValue(ClubUtils.ParamsId.DEFAULT_HEAD)
        local currentHeadId = isJoinClub and clubHomeDojo.avatar or defaultHeadId
        for headIndex, headId in ipairs(ClubUtils.GetClubHeadIdList()) do
            headDataList[headIndex] = {
                headId = checkInt(headId),
                headVo = ClubUtils.GetClubHeadVo(headId),
            }
        end
        table.sort(headDataList, function(aData, bData)
            local aPriority = 0
            local bPriority = 0
            local aHeadId = aData.headId
            local bHeadId = bData.headId
            ---@type PlayerHeadAvatarVo
            local aHeadVo = aData.headVo
            ---@type PlayerHeadAvatarVo
            local bHeadVo = bData.headVo
            aPriority = aPriority + (aHeadId == currentHeadId and 100 or 0)
            bPriority = bPriority + (bHeadId == currentHeadId and 100 or 0)
            aPriority = aPriority + (aHeadVo.sort < bHeadVo.sort and 10 or 0)
            bPriority = bPriority + (bHeadVo.sort < aHeadVo.sort and 10 or 0)
            aPriority = aPriority + (aHeadId > bHeadId and 1 or 0)
            bPriority = bPriority + (bHeadId > aHeadId and 1 or 0)
            return aPriority > bPriority
        end)
        self:SetHeadDataList(headDataList)

        -- default select first
        self:SetHeadSelectIndex(1)

        -- set applyLevelMax
        local applyLevelMax = ClubUtils.GetParamValue(ClubUtils.ParamsId.APPLY_LEVEL_MAX)
        self:SetApplyLevelMax(applyLevelMax)

        -- set nameInput limit
        local nameLimitMax = ClubUtils.GetParamValue(ClubUtils.ParamsId.NAME_LENGTH)
        self.nameInput.characterLimit = nameLimitMax

        -- default clubName
        self:SetInputClubName(isJoinClub and clubHomeDojo.name or '')

        -- default applyLevelNum
        self:SetApplyLevelNum(isJoinClub and clubHomeDojo.applyLevel or 1)

        -- default applyType
        self:SetApplyType(isJoinClub and clubHomeDojo.applyType or ClubUtils.ApplyType.APPLY)
    end)
end


function UIOverseaClubCreatePopup:OnFinalize()
    return CoWaitDo(function()
        Events.RemoveListener(ClubUtils.EventName.UPDATE_NAME, self.updateNameEventCB_)
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return boolean
function UIOverseaClubCreatePopup:IsModifyMode()
    return checkBool(self.isModifyMode_)
end
function UIOverseaClubCreatePopup:SetModifyMode(isModify)
    self.isModifyMode_ = checkBool(isModify)
    self:UpdateDisplayMode_()
end


---@return table[]
function UIOverseaClubCreatePopup:GetHeadDataList()
    return checkTable(self.headDataList_)
end
function UIOverseaClubCreatePopup:SetHeadDataList(dataList)
    self.headDataList_ = checkTable(dataList)
    self:UpdateHeadGridView_()
end


---@return integer
function UIOverseaClubCreatePopup:GetHeadSelectIndex()
    return checkInt(self.headSelectIndex_)
end
function UIOverseaClubCreatePopup:SetHeadSelectIndex(index)
    local oldHeadSelectIndex = self:GetHeadSelectIndex()
    local newHeadSelectIndex = checkInt(index)
    self.headSelectIndex_ = newHeadSelectIndex
    self:UpdateHeadGridSelected_(oldHeadSelectIndex, newHeadSelectIndex)
end


---@return string
function UIOverseaClubCreatePopup:GetInputClubName()
    return checkString(self.nameInput.text)
end
function UIOverseaClubCreatePopup:SetInputClubName(clubName)
    self.nameInput.text = checkString(clubName)
end


---@return ClubUtils.ApplyType
function UIOverseaClubCreatePopup:GetApplyType()
    return checkInt(self.isApplyType_)
end
function UIOverseaClubCreatePopup:SetApplyType(applyType)
    self.isApplyType_ = checkInt(applyType)
    self:UpdateApplyTypeState_()
end


---@return integer
function UIOverseaClubCreatePopup:GetApplyLevelMax()
    return checkInt(self.applyLevelMax_)
end
function UIOverseaClubCreatePopup:SetApplyLevelMax(levelMax)
    self.applyLevelMax_ = checkInt(levelMax)
    self.levelField.characterLimit = string.len(tostring(self:GetApplyLevelMax()))
end


---@return integer
function UIOverseaClubCreatePopup:GetApplyLevelNum()
    return checkInt(self.applyLevelNum_)
end
function UIOverseaClubCreatePopup:SetApplyLevelNum(levelNum)
    self.applyLevelNum_ = checkInt(levelNum)
    self.levelField.text = tostring(self:GetApplyLevelNum())
end


-------------------------------------------------
-- private

function UIOverseaClubCreatePopup:UpdateDisplayMode_()
    local isModifyMode = self:IsModifyMode()
    self.nameInput.interactable = not isModifyMode

    CfUtils.SetUISwitchText(self.topTitleTxt, isModifyMode and 2 or 1)
    
    local createStyle = isModifyMode and CREATE_STYLE_DEFINE.MODIFY or CREATE_STYLE_DEFINE.CREATE
    self.createBtn:ResetFontStyle(createStyle.styleId, createStyle.text)

    CfUtils.SetActive(self.consumePop, not isModifyMode)
    CfUtils.SetActive(self.levelInfoNode, isModifyMode)
    CfUtils.SetActive(self.nameModifyBtn, isModifyMode)

    if not isModifyMode then
        local consumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.CREATE_USE_GID)
        local consumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.CREATE_USE_GNUM)
        self.createBtnConsumePop_:RefreshUI(consumeId, consumeNum)
    end
end


function UIOverseaClubCreatePopup:UpdateHeadGridView_()
    local gridDataLength = #self:GetHeadDataList()
    -- 这里不推荐使用这个方法
    --[[
        这里不推荐使用这个方法，因为产生了一个bug，流程是这样的，
        执行 GameUtils.ReloadData 时，其实内部其实分别调用了两个方法，
        self.headGridView:SetListItemCount(len)
        此时会让全部12个cell更新一遍，cell的内部回调会让其建立一个头像的加载任务，
        但是同一帧内再次调用了
        self.headGridView:RefreshAllShownItem()
        这时12个cell会被回收并重新分配使用，当再次执行cell的内部回调时，由于旧的头像加载任务已经存在（建立加载人物是根据url记录的）
        所以新刷新的cell不会重新绑定加载成功的回调刷新关系，这就导致了连刷两次后头像和节点对应不一致的问题 @see CAT-26347
    ]]
    -- GameUtils.ReloadData(self.headGridView, gridDataLength)
    self.headGridView:SetListItemCount(gridDataLength)
end


---@param oldSelectIndex integer
---@param newSelectIndex integer
function UIOverseaClubCreatePopup:UpdateHeadGridSelected_(oldSelectIndex, newSelectIndex)
    local oldCellNode = self.headGridView:GetShownItemByItemIndex(oldSelectIndex - 1)
    local newCellNode = self.headGridView:GetShownItemByItemIndex(newSelectIndex - 1)
    if isNotNull(oldCellNode) then
        ---@type UIOverseaClubCreateHeadGridCell
        local oldCellEnv = CfUtils.GetLuaScr(oldCellNode, HeadGridCellPath)
        oldCellEnv:SetSelected(false)
    end
    if isNotNull(newCellNode) then
        ---@type UIOverseaClubCreateHeadGridCell
        local oldCellEnv = CfUtils.GetLuaScr(newCellNode, HeadGridCellPath)
        oldCellEnv:SetSelected(true)
    end
end


function UIOverseaClubCreatePopup:UpdateApplyTypeState_()
    local currentApplyType = self:GetApplyType()
    for applyType, typeToogle in pairs(self.applyTypeToggleMap_) do
        typeToogle.isOn = (applyType == currentApplyType)
    end
end


-------------------------------------------------
-- handler

function UIOverseaClubCreatePopup:OnClickCloseButtonHandler_()
    CfUtils.DialogClose(self.controller)
end


---@param gridView SuperScrollView.LoopGridView
---@param luaIndex integer
---@return SuperScrollView.LoopGridViewItem
function UIOverseaClubCreatePopup:OnUpdateHeadGridCellHandler_(gridView, luaIndex)
    local cellNode = gridView:NewListViewItem(HeadGridCellName)
    local cellData = self:GetHeadDataList()[luaIndex]
    ---@type UIOverseaClubCreateHeadGridCell
    local cellEnv = CfUtils.GetLuaScr(cellNode, HeadGridCellPath)
    if isNotNull(cellEnv) then
        -- init cell
        cellEnv:SetLuaIndex(luaIndex)
        cellEnv:SetCellData(cellData)
        cellEnv:SetClickCellCB(Bind(self, self.OnClickHeadGridCellCallback_))
        -- update state
        cellEnv:SetSelected(self:GetHeadSelectIndex() == luaIndex)
    end
    return cellNode
end


function UIOverseaClubCreatePopup:OnClickHeadGridCellCallback_(luaIndex)
    self:SetHeadSelectIndex(luaIndex)
end


function UIOverseaClubCreatePopup:OnClickNameModifyButtonHandler_()
    CfUtils.DialogOpen(Constants.UITypeIds.UIOverseaClubModifyNamePopup)
end


function UIOverseaClubCreatePopup:OnClubUpdateNameHandler_()
    local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
    self:SetInputClubName(clubHomeDojo.name)
end


---@param applyType ClubUtils.ApplyType
---@param isTooggleOn boolean
function UIOverseaClubCreatePopup:OnClickApplyTypeToggleHandler_(applyType, isTooggleOn)
    if isTooggleOn then
        self:SetApplyType(applyType)
    else
        self:SetApplyType(self:GetApplyType())
    end
end


function UIOverseaClubCreatePopup:OnClickLevelButtonHandler_(changeValue)
    -- 设置text值会触发 onValueChanged 回调，所以边界检测在 OnChangedLevelFieldHandler_ 处理
    self.levelField.text = tostring(self:GetApplyLevelNum() + changeValue)
end


function UIOverseaClubCreatePopup:OnChangedLevelFieldHandler_(fieldText)
    local applyLevelNum = checkInt(fieldText)
    self:SetApplyLevelNum(math.max(1, math.min(applyLevelNum, self:GetApplyLevelMax())))
end


function UIOverseaClubCreatePopup:OnClickCreateOrModifyButtonHandler_()
    local clubHeadData = self:GetHeadDataList()[self:GetHeadSelectIndex()]

    ------------------------------------------------- [modify]
    if self:IsModifyMode() then
        local requestData = {avatar = clubHeadData.headId, applyPermission = self:GetApplyType(), applyLevel = self:GetApplyLevelNum()}
        GameUtils.Request(Interfaces.OverseaClubUpdateInfo, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)
                local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()

                -- update homeDojo
                clubHomeDojo.avatar     = requestData.avatar
                clubHomeDojo.applyType  = requestData.applyPermission
                clubHomeDojo.applyLevel = requestData.applyLevel

                -- change notice 
                Events.Broadcast(ClubUtils.EventName.UPDATE_INFO)
                GameUtils.Toast(localize('社团设置更新成功'))
                CfUtils.DialogClose(self.controller)
            end
        end)

    ------------------------------------------------- [create]
    else
        -- 社团名称检测
        if string.isEmpty(self:GetInputClubName()) then
            GameUtils.Toast(localize('社团名称不能为空'))
            return
        end

        -- 消耗道具检测
        local consumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.CREATE_USE_GID)
        local consumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.CREATE_USE_GNUM)
        GoodsUtils.CheckCurrencyConsume({goodsId = consumeId, num = consumeNum}, function()
            -- 申请创建社团
            local requestData = {name = self:GetInputClubName(), avatar = clubHeadData.headId, applyPermission = self:GetApplyType()}
            GameUtils.Request(Interfaces.OverseaClubCreate, requestData, function(request, response)
                if checkInt(response.errCode) == 0 then
                    local responseData = checkTable(response.data)
    
                    -- init clubData
                    local clubComp = ClubUtils.GetClubComp()
                    clubComp:InitialClubData(responseData)
    
                    GoodsUtils.ConsumeGoods({{goodsId = consumeId, num = consumeNum}}, true)
    
                    -- goto clubHome
                    CfUtils.StartCoroutineWithBlocker(function()
                        CoYield(CfUtils.DialogClose(self.controller))
                        Events.Broadcast(ClubUtils.EventName.JOIN_SUCCED)
                    end)
                else
                    -- show error tips
                    CfUtils.SetActive(self.nameRemindText, true)
                    CfUtils.FillText(self.nameRemindText, tostring(response.errMsg))
                end
            end)
        end)

    end
end


return UIOverseaClubCreatePopup
