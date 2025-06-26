local AlertBaseView = require("game/common/logic_ui/AlertBaseView");
module('AlertOKCancel', Class.impl(AlertBaseView))
UIRes = UrlManager:getUIPrefabPath('common/AlertUI2Btn.prefab')
local gIns = nil
function getInstance()
    if gIns == nil then
        gIns = AlertOKCancel.new()
        gIns:addEventListener(View.EVENT_VIEW_DESTROY, gIns.onDestroyViewHandler, gIns)
    end
    return gIns
end

function onDestroyViewHandler(self)
    gIns = nil
end

function configUI(self)
    super.configUI(self)
    
    local yesBtn = self:getChildGO('YesBtn')
    local function _yesBtnClick()
        if self.m_tipCall then
            self.m_tipCall(self.m_isSelect)
        end

        if self.m_call then
            self.m_call(gud.ALERT_OK)
        end
        self:close()
    end
    self:addOnClick(yesBtn, _yesBtnClick)
    self:_setBtnTitleComponent(gud.ALERT_OK, self:getChildGO('YesText'):GetComponent(ty.Text))

    local cancelBtn = self:getChildGO('CancelBtn')
    local function _cancelBtnClick()
        if self.m_call then
            self.m_call(gud.ALERT_CANCEL)
        end
        self:close()
    end
    self:addOnClick(cancelBtn, _cancelBtnClick)
    self:_setBtnTitleComponent(gud.ALERT_CANCEL, self:getChildGO('CanccelText'):GetComponent(ty.Text))
end

function active(self)
    super.active(self)
    self:__updateTip()
end

function deActive(self)
    super.deActive(self)
end

function __updateTip(self)
    local selectGo = self:getChildGO('ImgSelect')
    self.m_isSelect = false
    selectGo:SetActive(self.m_isSelect)
    local function _groupTipClick()
        self.m_isSelect = not self.m_isSelect
        selectGo:SetActive(self.m_isSelect)
    end

    local groupTip = self:getChildGO('GroupTip')
    if self.m_tipCall then
        groupTip:SetActive(true)
        self:addOnClick(groupTip, _groupTipClick)
    else
        groupTip:SetActive(false)
        self:removeOnClick(groupTip, _groupTipClick)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
