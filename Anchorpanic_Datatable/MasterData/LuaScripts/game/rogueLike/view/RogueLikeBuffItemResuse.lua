module("rogueLike.RogueLikeBuffItemResuse", Class.impl(BaseReuseItem))


-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("rogueLike/RogueLikeBuffItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
end
-- 析构
function dtor(self)
end


-- 初始化
function configUI(self)
    super.configUI(self)

    self.mGroupSelect = self:getChildGO("GroupSelect")

    self.mGroup = self:getChildGO("mGroup"):GetComponent(ty.RectTransform)

    self.mImgBg = self:getChildGO("mImgBg"):GetComponent(ty.AutoRefImage)
    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtImprove = self:getChildGO("mTxtImprove"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mIsBuy = self:getChildGO("mIsBuy")
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
    self:addOnClick(self:getChildGO("mGroup"), self.onClick)
end

function setData(self,cusParent,cusCellId,buffId,isByShop,isBuy,improve_efficiency)
    self:setParentTrans(cusParent)
    self:setSelect(false)

    self.mCellId = cusCellId
    self.mBuffId = buffId
    self.isByShop = isByShop
    self.isBuy = isBuy
    if isByShop and isBuy > 0 then
        self.mIsBuy:SetActive(true)
    else
        self.mIsBuy:SetActive(false)
    end

    local goodsConfigVo = rogueLike.RogueLikeManager:getGoodsConfigVo(self.mBuffId)
    self.mTxtName.text = goodsConfigVo:getName()
    self.mTxtDes.text = goodsConfigVo:getDes()
    self.mImgIcon:SetImg(UrlManager:getSkillIconPath(goodsConfigVo:getIcon()), true)
    --这里需要做个特殊的处理 
    if improve_efficiency then
        self.mTxtImprove.gameObject:SetActive(true)
        self.mTxtImprove.text = string.substitute("作战效率：{0}%", improve_efficiency / 10)
    else
        self.mTxtImprove.gameObject:SetActive(false)
        --self.mTxtImprove.text = "作战效率：" .. (goodsConfigVo.efficiency / 10) .. "%"
    end
    
    self.mImgBg:SetImg(UrlManager:getRorueLikeBuffBg(goodsConfigVo.collectionLevel),false)


    gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroup) --立即刷新
end

function setSelect(self,bool)
    self.isSelect = bool
    self:updateState()    
end

function updateState(self)
    if self.isSelect then
        self.mGroupSelect:SetActive(true)
    else
        self.mGroupSelect:SetActive(false)
    end
end

function onClick(self)
    if self.isByShop and self.isBuy>0 then
        gs.Message.Show("已经购买过了")
        return
    end


    if self.isSelect == false then
        self:setSelect(true)
        self:dispatchEvent(self.EVENT_CHANGE, {item = self})
        return
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
