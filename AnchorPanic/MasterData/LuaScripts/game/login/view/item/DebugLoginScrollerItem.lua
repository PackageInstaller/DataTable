--[[****************************************************************************
Brief  :debug登录选服item
Author :lizhenghui
****************************************************************************
]]
module('login.DebugLoginScrollerItem', Class.impl('lib.component.BaseItemRender'))


function onInit(self, go)
    super.onInit(self, go)
    self:addOnClick(self.m_childGos['m_btnName'], self.onClickHandler)
    self.m_nameText = self.m_childGos["Text"]:GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)
    self.m_nameText.text = self.data[3]
end

function onClickHandler(self)
	GameDispatcher:dispatchEvent(EventName.DEBUG_LOGIN_SELECT_SERVICE, self.data)
end

return _M 
 
--[[ 替换语言包自动生成，请勿修改！
]]
