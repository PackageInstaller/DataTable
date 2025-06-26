module("rogueLike.RogueLikeShowBuffItem", Class.impl(BaseReuseItem))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeShowBuffItem.prefab")

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构
function dtor(self)
end

function initData(self)
    self.isSelect = false
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mNameTxt = self:getChildGO("mNameTxt"):GetComponent(ty.Text)
    self.mShowDesBtn = self:getChildGO("mShowDesBtn")
    -- self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
end

-- 激活
function active(self)
    super.active(self)
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mShowDesBtn, self.onClick)
end

function setData(self, cusParent, buffId)
    self:setParentTrans(cusParent)

    self.goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(buffId)
    self.mNameTxt.text = self.goodsConfigVo:getName()
end

function onClick(self)
    gs.Message.Show(self.goodsConfigVo:getDes())
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
