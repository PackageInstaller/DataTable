module("cycle.CycleRecruitItem", Class.impl(BaseReuseItem))
UIRes = UrlManager:getUIPrefabPath("cycle/item/CycleRecruitItem.prefab")

EVENT_CHANGE = "EVENT_CHANGE"

-- 构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)

    self.mGroupShow = self:getChildGO("mGroupShow")
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)

    self.mImgIcon = self:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage)

    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)

    self.mHeroContent = self:getChildTrans("mHeroContent")

    self.mIsUsed = self:getChildGO("mIsUsed")
end

function active(self)
    super.active(self)

end

function deActive(self)
    super.deActive(self)

    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
    
    self:clearHeroCard()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addOnClick(self:getChildGO("mGroup"), self.onClick)
end

function setData(self, cusParent, cusData,index)
    self:setParentTrans(cusParent)
    self:setGuideTrans("guide_CycleRecruitItem_" .. index, self:getChildTrans("mGroup"))
    
    self.mParentTrans = cusParent
    self.mData = cusData

    self.index = index
    if self.aniSn then
        self:clearTimeout(self.aniSn)
        self.aniSn = nil
    end
    self.UIObject:SetActive(false)
    self.aniSn = self:setTimeout(self.index * 0.03, function()
        self.UIObject:SetActive(true)
        self.UIObject:GetComponent(ty.UIDoTween):BeginTween()
        -- self.mAnimator:SetTrigger("enter")
    end)
    self:updateView()
end

function updateView(self)
    -- local s = "招募类型:"
    -- for i = 1, #self.mData.vo.param do
    --     s = s .. self.mData.vo.param[i] .. " "
    -- end
    self.mTxtName.text = _TT(self.mData.vo.name)
    self.mTxtDes.text = _TT(self.mData.vo.des)

    self.mImgIcon:SetImg(UrlManager:getIconPath(self.mData.vo.icon),false)

    if self.mData.heroId ~= 0 then

        self:clearHeroCard()
        local heroVo = hero.HeroManager:getHeroVo(self.mData.heroId)

        self.heroCard = cycle.CycleHeroCard:poolGet()
        self.heroCard:setData(heroVo)
        self.heroCard:setParent(self.mHeroContent)
        self.heroCard:setScale(1)
    end
    self.mIsUsed:SetActive(self.mData.isUsed)
    self.mGroupShow:SetActive(self.mData.heroId == 0)

    self:getChildGO("mGroup"):GetComponent(ty.Image).raycastTarget = self.mData.heroId == 0 and self.mData.isUsed == false
    -- self:getChildGO("mGroup"):SetActive(self.mData==0 and self.mData.isUsed==false)
end

function clearHeroCard(self)
    if self.heroCard then
        self.heroCard:poolRecover()
        self.heroCard = nil
    end
end

function onClick(self)
    GameDispatcher:dispatchEvent(EventName.CLOSE_CYCLE_RECRUIT_PANEL)
    GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
        step = CYCLE_STEP.SELECT_TICKET,
        args = {self.mData.posId}
    })
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
