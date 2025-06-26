module('bag.HeroEggRuleItem', Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("bag/item/HeroEggRuleItem.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
    self.mHeadItem = {}
    self.mItemList = {}
    self.colorStr = {"", "038008", "038008", "038008"}
end
--析构
function dtor(self)
end

function initData(self)
end

function configUI(self)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
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


function createItem(self,tid)
    local item = PropsGrid:createByData({
        tid = tid,
        num = 1,
        parent = self.mItemGrid,
        scale = 0.8, 
        showUseInTip = true
    })
    item:setIsShowName(true)
    table.insert(self.mItemList, item)
end



function setData(self, cusParent, ruleList,pr,color)
    -- self.createFinishCall = createFinishCall
    -- self.mRecruit_type = type

    self:setParentTrans(cusParent)
    local color = color
    local pr = pr

    for i = 1, 3 do
        self.m_childGos["mImgQuality_" .. i]:SetActive(color - 1 == i)
    end


    self.mTxtTitle.text = _TT(149925, pr)
    self:recoverItem()
    for i = 1, #ruleList, 1 do
        self:createItem(ruleList[i])
    end
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]
