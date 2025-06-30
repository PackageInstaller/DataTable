--[[ 
-----------------------------------------------------
@filename       : sxt 
@Description    : 商店二级tab add
@date           : 2020-09-01 10:24:53
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.rank.view.RankTabChildItem', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("rank/RankTabChildItem1.prefab")

function configUI(self)
    self.mBtnNomal = self:getChildGO("mBtnNomal")
    self.mBtnSelect = self:getChildGO("mBtnSelect")
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mBtnNomal, self.onNomalClick, UrlManager:getUIBaseSoundPath("ui_basic_switch.prefab"))
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnNomal)
end

function setData(self, cusVo, cusIndex, cusCallBack, cusThisObject)
    self.vo = cusVo
    self.index = cusIndex
    self.callBack = cusCallBack
    self.thisObject = cusThisObject
    self:updateView()
end

function updateView(self)
    self:setBtnLabel(self.mBtnNomal, self:getLanguageList()[self.index])
    self:setBtnLabel(self.mBtnSelect, self:getLanguageList()[self.index])
    self:setSelect(false)
end

function setSelect(self, bool)
    if bool then
        self.mBtnSelect:SetActive(true)
        self.mBtnNomal:SetActive(false)
    else
        self.mBtnSelect:SetActive(false)
        self.mBtnNomal:SetActive(true)
    end
end

function getLanguageList(self)
    return self.vo.tapLangs
end

function onNomalClick(self)
    GameDispatcher:dispatchEvent(EventName.SET_RANK_SUBTYPE, self.index + 1)
    self.callBack(self.thisObject, self.index)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
