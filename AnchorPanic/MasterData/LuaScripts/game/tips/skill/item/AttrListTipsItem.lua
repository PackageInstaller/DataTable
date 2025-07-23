module("tips.AttrListTipsItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mImgBg = self.m_childGos["ImgBg"]
    self.mTextKey = self.m_childGos["TextKey"]:GetComponent(ty.Text)
    self.mTextValue = self.m_childGos["TextValue"]:GetComponent(ty.Text)
end

function setData(self, param)
    super.setData(self, param)

    self.mImgBg:SetActive(self.data.AttrListTipsItemIndex % 2 ~= 0)
    self.mTextKey.text = self.data.key
    self.mTextValue.text = self.data.value
end

function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
