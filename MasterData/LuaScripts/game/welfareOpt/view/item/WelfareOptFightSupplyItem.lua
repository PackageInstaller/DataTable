module('welfareOpt.WelfareOptFightSupplyItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("welfareOpt/item/WelfareOptFightSupplyItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.mHeadItem = {}
    self.mItemList = {}
end
--析构  
function dtor(self)
end

function initData(self)
end

function configUI(self)
    -- self.mTxtColor = self:getChildGO("mTxtColor"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mImgColor = self:getChildGO("mImgColor"):GetComponent(ty.AutoRefImage)
    
    -- self.mLine = self:getChildGO("mLine")
    self.mItemGrid = self:getChildTrans("mItemGrid")
    self.mEquipGrid = self:getChildTrans("mEquipGrid")
end


--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function recoverItem(self)
    if self.mItemList then
        for i, v in pairs(self.mItemList) do
            v:poolRecover()
        end
    end
    self.mItemList = {}

end


function setData(self, cusParent, data,type)
    self:recoverItem()
    self:setParentTrans(cusParent)

    for id,da in pairs(data) do
        local item = welfareOpt.WelfareProPropsItem:poolGet()
        item:setData(self.mItemGrid,da)
        table.insert(self.mItemList, item)
    end
   
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
