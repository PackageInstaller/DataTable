-------------------------------------------------------------------------------
-- 社团 - 社团改名弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-20 20:11:47
-------------------------------------------------------------------------------

--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubModifyNamePopup.prefab
---@class UIOverseaClubModifyNamePopup
---@field Env                           	UIOverseaClubModifyNamePopup            
---@field controller                    	Engine.UI.UILuaDialog                   
---@field consumePop                    	UnityEngine.RectTransform               @ 消耗节点
---@field modifyBtn                     	UnityEngine.RectTransform               @ 修改按钮
---@field nameRemindText                	UnityEngine.RectTransform               @ 名字结果提示文本
---@field nameInput                     	UnityEngine.UI.InputField               @ 名字输入框
---@field closeBtn                      	UnityEngine.RectTransform               @ 关闭按钮
---@field backBlock                     	UnityEngine.RectTransform               @ 空白区
local UIOverseaClubModifyNamePopup = Class('UIOverseaClubModifyNamePopup')


function UIOverseaClubModifyNamePopup:__init()
    ---@type CommonBtnConsumePop
    self.modifyBtnConsumePop_ = nil
end


function UIOverseaClubModifyNamePopup:__delete()
    self.modifyBtnConsumePop_ = nil
end


function UIOverseaClubModifyNamePopup:Awake()
    self.modifyBtnConsumePop_ = CfUtils.GetLuaScr(self.consumePop, Constants.UILuaTablePath.BtnConsumePop)
    SetButtonAction(self.closeBtn, Bind(self, self.OnClickCloseButtonHandler_))
    SetButtonAction(self.modifyBtn, Bind(self, self.OnClickModifyButtonHandler_))
end


function UIOverseaClubModifyNamePopup:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}

        -- set nameInput limit
        local nameLimitMax = ClubUtils.GetParamValue(ClubUtils.ParamsId.NAME_LENGTH)
        self.nameInput.characterLimit = nameLimitMax

        -- set nameInput placeholder
        CfUtils.FillCfText(self.nameInput.placeholder, localize('请输入社团名称'))

        -- set clubName
        local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()
        self:SetInputClubName(clubHomeDojo.name)

        -- set consumeInfo
        local consumeId  = ClubUtils.GetParamValue(ClubUtils.ParamsId.RENAME_USE_GID)
        local consumeNum = ClubUtils.GetParamValue(ClubUtils.ParamsId.RENAME_USE_GNUM)
        self.modifyBtnConsumePop_:RefreshUI(consumeId, consumeNum)
    end)
end


function UIOverseaClubModifyNamePopup:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- get / set

---@return string
function UIOverseaClubModifyNamePopup:GetInputClubName()
    return checkString(self.nameInput.text)
end
function UIOverseaClubModifyNamePopup:SetInputClubName(clubName)
    self.nameInput.text = checkString(clubName)
end


-------------------------------------------------
-- handler

function UIOverseaClubModifyNamePopup:OnClickCloseButtonHandler_()
    CfUtils.DialogClose(self.controller)
end


function UIOverseaClubModifyNamePopup:OnClickModifyButtonHandler_()
    -- 社团名称检测
    if string.isEmpty(self:GetInputClubName()) then
        GameUtils.Toast(localize('社团名称不能为空'))
        return
    end
    
    -- 消耗道具检测
    local consumeId    = ClubUtils.GetParamValue(ClubUtils.ParamsId.RENAME_USE_GID)
    local consumeNum   = ClubUtils.GetParamValue(ClubUtils.ParamsId.RENAME_USE_GNUM)
    local _, errorTips = GoodsUtils.CheckGoodConsume({{goodsId = consumeId, num = consumeNum}})
    if errorTips then
        GameUtils.Toast(errorTips)
        return
    end

    -- 修改社团名称
    local requestData = {name = self:GetInputClubName()}
    GameUtils.Request(Interfaces.OverseaClubUpdateName, requestData, function(request, response)
        if checkInt(response.errCode) == 0 then
            local responseData = checkTable(response.data)
            local clubHomeDojo = ClubUtils.GetClubComp():GetHomeDojo()

            -- update homeDojo
            clubHomeDojo.name = requestData.name

            -- update consume
            GoodsUtils.ConsumeGoods({{goodsId = consumeId, num = consumeNum}}, true)

            -- change notice 
            Events.Broadcast(ClubUtils.EventName.UPDATE_NAME)
            GameUtils.Toast(localize('社团名称更新成功'))
            CfUtils.DialogClose(self.controller)
        else
            -- show error tips
            CfUtils.SetActive(self.nameRemindText, true)
            CfUtils.FillText(self.nameRemindText, tostring(response.errMsg))
        end
    end)
end


return UIOverseaClubModifyNamePopup
