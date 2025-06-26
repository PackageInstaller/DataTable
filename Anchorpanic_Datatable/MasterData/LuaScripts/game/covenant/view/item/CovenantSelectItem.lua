module("covenant.CovenantSelectItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("covenant/item/CovenantSelectItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function setData(self,cusParent,data)
    self:setParentTrans(cusParent)

    self.id = data.id
    self.m_nameTxt.text = _TT(data.name)
    self.m_enNameTxt.text = _TT(data.enName)
    self.m_btnImg:SetImg(UrlManager:getPackPath("covenant/covenant_select"..data.id..".png",false))
end

function configUI(self)
    self.m_btn = self:getChildGO("Btn")
    self.m_btnImg = self:getChildGO("Btn"):GetComponent(ty.AutoRefImage)
    self.m_nameTxt = self:getChildGO("NameTxt"):GetComponent(ty.Text)
    self.m_enNameTxt = self:getChildGO("EnNameTxt"):GetComponent(ty.Text)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end


--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
   
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.m_btn,self.__onBtnClickHandler)
end

function __onBtnClickHandler(self)
    --covenant.CovenantShopPanel.

    GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SELECT_INFO_PANEL,{id = self.id,showInfo = false})
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
