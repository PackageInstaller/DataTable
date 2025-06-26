--[[ 
-----------------------------------------------------
@filename       : HeroLvlTargetItem
@Description    : 战员等级目标Item
@date           : 2022-2-18 13:44:00
@Author         : Zzz
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module("hero.HeroLvlTargetItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mPropsGridList = {}

    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroupPro = self:getChildGO("GroupPro")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mGroupContent = self:getChildTrans("Content")
    self.mGroupHasRec = self:getChildGO("GroupHasRec")
    self.mImPro = self:getChildGO("ImPro"):GetComponent(ty.Image)
    self.mTxtIng = self:getChildGO("mTxtIng"):GetComponent(ty.Text)
    -- self.mTextDes = self:getChildGO("TextDes"):GetComponent(ty.Text)
    self.mTextPro = self:getChildGO("TextPro"):GetComponent(ty.Text)
    self.mTextGet = self:getChildGO("TextGet"):GetComponent(ty.Text)
    self.mTextName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    -- self.mScrollView = self:getChildGO("Scroll View"):GetComponent(ty.RectTransform)
    -- self.mScrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    -- self.mGroupContentH = self:getChildGO("Content"):GetComponent(ty.HorizontalLayoutGroup)

    self.mBlackLine = self:getChildGO("mBlackLine"):GetComponent(ty.Image)

    self:addOnClick(self.mBtnGet, self.__onClickRecHandler)

    self.mTextGet.text = _TT(3)
    self.mTxtIng.text = _TT(36520)--进行中
end

function setData(self, param)
    super.setData(self, param)

    local heroVo = self.data:getDataVo().heroVo
    local targetConfigVo = self.data:getDataVo().targetConfigVo
    self:recoverAllGrid()
    if (targetConfigVo) then
        self.mImPro.fillAmount = heroVo.lvl / targetConfigVo.heroLvl
        if heroVo.lvl >= targetConfigVo.heroLvl then
            self.mTextPro.text = targetConfigVo.heroLvl .. "/" .. targetConfigVo.heroLvl
        else
            self.mTextPro.text = "<color=#D53529>" .. heroVo.lvl .. "</color>/" .. targetConfigVo.heroLvl
        end

        local state = targetConfigVo:getState(heroVo)

        self.mBlackLine.gameObject:SetActive(true)
        if state == task.AwardRecState.CAN_REC then
            -- 0:已完成未领奖
            self.mBlackLine.color = gs.ColorUtil.GetColor("ffb644ff")
            self.mBtnGet:SetActive(true)
            self.mGroupHasRec:SetActive(false)
            self.mGroupIng:SetActive(false)
        elseif state == task.AwardRecState.UN_REC then
            -- 1:未完成    
            self.mBlackLine.color = gs.ColorUtil.GetColor("000000ff")
            self.mBtnGet:SetActive(false)
            self.mGroupHasRec:SetActive(false)
            self.mGroupIng:SetActive(true)
        else
            -- 2：已领取奖励
            self.mBlackLine.gameObject:SetActive(false)
            self.mBtnGet:SetActive(false)
            self.mGroupHasRec:SetActive(true)
            self.mGroupIng:SetActive(false)
        end

    else
        self.mBtnGet:SetActive(false)
        self.mGroupIng:SetActive(true)
        self.mGroupHasRec:SetActive(false)

        self.mImPro.fillAmount = 0 / targetConfigVo.targetCount
        self.mTextPro.text = 0 .. "/" .. targetConfigVo.targetCount
    end
    self.mTextName.text = _TT(targetConfigVo.des) -- _TT(1008)
    -- self.mTextDes.text = _TT(targetConfigVo.des)

    local awardList = AwardPackManager:getAwardListById(targetConfigVo.awardId)
    -- local length = #awardList * 128 + (#awardList - 1) * self.mGroupContentH.spacing
    -- self.mScrollRect.enabled = self.mScrollView.rect.width < length and true or false
    for i = 1, #awardList do
        local propsGrid = PropsGrid:create(self.mGroupContent, awardList[i], 1)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function __onClickRecHandler(self)
    local heroVo = self.data:getDataVo().heroVo
    local targetConfigVo = self.data:getDataVo().targetConfigVo
    local state = targetConfigVo:getState(heroVo)
    if (state == task.AwardRecState.CAN_REC) then
        GameDispatcher:dispatchEvent(EventName.REQ_HERO_REC_TARGET, { heroTid = heroVo.tid, targetId = targetConfigVo.id })
    end
end

function recoverAllGrid(self)
    for i = 1, #self.mPropsGridList do
        self.mPropsGridList[i]:poolRecover()
    end
    self.mPropsGridList = {}
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(1008):	"目标"
]]