module("disaster.DisasterFightAwardItem", Class.impl('lib.component.BaseItemRender'))
-- 构造函数
function ctor(self)
    super.ctor(self)
end

function onInit(self, go)
    super.onInit(self, go)
    self.mStageAwardItemList = {}
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mGroupIng = self:getChildGO("mGroupIng")
    self.mContent = self:getChildTrans("mContent")
    self.mGroupGeted = self:getChildGO("mGroupGeted")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtIng = self:getChildGO("mTxtIng"):GetComponent(ty.Text)

    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mImgState = self:getChildGO("mImgState"):GetComponent(ty.Image)

    self:addOnClick(self.mBtnGet, self.onClickGetHandler)
end

function setData(self, param)
    super.setData(self, param)
    self:recoverAllGrid()
    self.mTxtGet.text = _TT(412) -- 领取
    self.mTxtIng.text = _TT(36520) -- 进行中
    self.mTxtTitle.text = _TT(104003) .. param.targetDamage

    if param.state == 0 then
        self.mBtnGet:SetActive(true)
        self.mGroupIng:SetActive(false)
        self.mGroupGeted:SetActive(false)
        self.mImgState.color = gs.ColorUtil.GetColor("FAAC31ff")
        self.mImgState.gameObject:SetActive(true)
    elseif param.state == 1 then
        self.mBtnGet:SetActive(false)
        self.mGroupIng:SetActive(true)
        self.mGroupGeted:SetActive(false)
        self.mImgState.color = gs.ColorUtil.GetColor("24262bff")
        self.mImgState.gameObject:SetActive(true)
    else
        self.mBtnGet:SetActive(false)
        self.mGroupIng:SetActive(false)
        self.mGroupGeted:SetActive(true)
        self.mImgState.gameObject:SetActive(false)
    end

    for _, awardVo in pairs(param.reward) do
        local tempGrid = PropsGrid:create(self.mContent, {awardVo[1], awardVo[2]}, 1, false)
        table.insert(self.mStageAwardItemList, tempGrid)
    end
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()
end

function onDelete(self)
    super.onDelete(self)

end

function onClickGetHandler(self)
    GameDispatcher:dispatchEvent(EventName.REQ_GAIN_DAMAGE_REWARD, {
        id = self.data.id
    })
end

function recoverAllGrid(self)
    for i = 1, #self.mStageAwardItemList do
        self.mStageAwardItemList[i]:poolRecover()
    end
    self.mStageAwardItemList = {}
end

return _M
