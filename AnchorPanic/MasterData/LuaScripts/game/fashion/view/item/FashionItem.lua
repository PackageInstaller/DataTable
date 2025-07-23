module("game.fashion.view.item.FashionItem", Class.impl(BaseReuseItem))

UIRes = UrlManager:getUIPrefabPath("fashion/tab/FashionItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构
function dtor(self)
end

function initData(self)

end

-- 初始化
function configUI(self)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

--激活
function active(self)
    super.active(self)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    RedPointManager:remove(self.mImgIcon.gameObject.transform)
end

function initViewText(self)

end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)

end

function setData(self, cusParent, data)
    self:setParentTrans(cusParent)
    local showVo = data.itemData
    self.mImgIcon:SetImg(showVo:getFashionBodyIcon(), true)
    local isBubble = fashion.FashionManager:isHeroFashionIdBubble(fashion.Type.CLOTHES, fashion.FashionManager:getHeroId(), showVo.fashionId)
    if (isBubble) then
        RedPointManager:add(self.mImgIcon.gameObject.transform, nil, -91, 188)
    else
        RedPointManager:remove(self.mImgIcon.gameObject.transform)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]