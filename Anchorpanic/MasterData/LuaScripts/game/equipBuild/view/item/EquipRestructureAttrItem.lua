module("hero.EquipRestructureAttrItem", Class.impl(BaseComponent))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("equipBuild/item/EquipRestructureAttrItem.prefab")

function __initData(self)
    super.__initData(self)
    self.mTxtName = nil
    self.m_textVal = nil
end

-- 设置data
function setData(self, curKey,curVal)
    self:__reset()
    self.m_data ={}
    self.m_data.key = curKey
    self.m_data.value = curVal
end

function __updateCustomView(self)
    self:__initScript()
    self:__updateContent()
end

function __initScript(self)
    self.mTxtName = self.m_childGos["TextName"]:GetComponent(ty.Text)
    self.m_textVal = self.m_childGos["TextValue"]:GetComponent(ty.Text)
end

function __updateContent(self)
    self.mTxtName.text = AttConst.getName(self.m_data.key)
    self.m_textVal.text = AttConst.getValueStr(self.m_data.key, self.m_data.value)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
