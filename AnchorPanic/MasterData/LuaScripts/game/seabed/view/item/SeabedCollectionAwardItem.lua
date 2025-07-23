--[[ 
-----------------------------------------------------
@filename       : SeabedCollectionAwardItem
@Description    : 剧情目标Item
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]] module("seabed.SeabedCollectionAwardItem", Class.impl("lib.component.BaseItemRender"))

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
    self.mTextPro = self:getChildGO("TextPro"):GetComponent(ty.Text)
    self.mTextGet = self:getChildGO("TextGet"):GetComponent(ty.Text)
    self.mTextName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mBlackLine = self:getChildGO("mBlackLine"):GetComponent(ty.Image)

    self:addOnClick(self.mBtnGet, self.__onClickRecHandler)

    self.mTextGet.text = _TT(3)
    self.mTxtIng.text = _TT(36520) -- 进行中
end

function setData(self, param)
    super.setData(self, param)

    self.mData = param

    self:recoverAllGrid()

    self.mBlackLine.gameObject:SetActive(true)
    if self.mData.state == task.AwardRecState.CAN_REC then
        -- 0:已完成未领奖
        self.mBlackLine.color = gs.ColorUtil.GetColor("ffb644ff")
        self.mBtnGet:SetActive(true)
        self.mGroupHasRec:SetActive(false)
        self.mGroupIng:SetActive(false)
    elseif self.mData.state == task.AwardRecState.UN_REC then
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

    local hasNum = 0
    if self.mData.battleType == seabed.SeabedBattleType.Collage then
        hasNum = seabed.SeabedManager:getHisCollNum()
        if self.mData.num > hasNum then
            self.mTextName.text = _TT(111176,self.mData.num)
        else
            self.mTextName.text = _TT(111178,self.mData.num)-- "累计获取收藏品达到:" .. self.mData.num .. "个"
        end
    else

        hasNum = seabed.SeabedManager:getHisBuffNum()
        if self.mData.num > hasNum then
            self.mTextName.text = _TT(111177,self.mData.num)-- "累计获取增益达到:<color=#D53529>" .. self.mData.num .. "</color>个"
        else
            self.mTextName.text = _TT(111179,self.mData.num) --"累计获取增益达到:" .. self.mData.num .. "个"
        end
       
    end

    local awardList = self.mData.reward
    for i = 1, #awardList do
        local propsGrid = PropsGrid:create(self.mGroupContent, awardList[i], 1)
        table.insert(self.mPropsGridList, propsGrid)
    end
end

function __onClickRecHandler(self)
    if self.mData.state == task.AwardRecState.CAN_REC then
        GameDispatcher:dispatchEvent(EventName.REQ_SEABED_COLLECTION_AWARD_GET, {
            id = self.mData.id
        })
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
