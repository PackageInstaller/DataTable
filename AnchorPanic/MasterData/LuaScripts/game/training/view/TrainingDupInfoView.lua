module('training.TrainingDupInfoView', Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("training/TrainingDupInfoView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    self.mImgDiffLvlDic = {}
    self.mItemList = {}
    self.mSignList = {}
end

--初始化UI
function configUI(self)
    self.mTxtInfo = self:getChildGO('mTxtInfo'):GetComponent(ty.Text)
    self.mTxtName = self:getChildGO('mTxtName'):GetComponent(ty.Text)
    self.mTxtDiffLvl = self:getChildGO('mTxtDiffLvl'):GetComponent(ty.Text)

    self.mTxtCost = self:getChildGO('mTxtCost'):GetComponent(ty.Text)
    self.mBtnFight = self:getChildGO('mBtnFight')
    self.mScrollContent = self:getChildTrans("Content")

    for lvl = 1, 6 do
        self.mImgDiffLvlDic[lvl] = self:getChildGO('ImgDiffLvl_'..lvl)
    end

    self:initViewText()
end

function initViewText(self)
    self.mTxtName.text = _TT(43002) --"阶段考核"
    self.mTxtDiffLvl.text = _TT(43003) --"难度系数"
    self:setBtnLabel(self.mBtnFight, 123, "开始挑战")
end

--激活
function active(self)
    super.active(self)
    self:addOnClick(self.mBtnFight, self.onFightHandler)
end

--非激活
function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnFight, self.onFightHandler)
    self:removeItem()
end

function show(self, parent, cusDupConfigVo)
    self:setParentTrans(parent)
    self:setData(cusDupConfigVo)
end

function setData(self, cusDuoConfigVo)
    self.mDupConfigVo = cusDuoConfigVo
    self.mTxtInfo.text = self.mDupConfigVo:getDes()

    for lvl, go in pairs(self.mImgDiffLvlDic) do
        if(lvl <= self.mDupConfigVo.diffLvl)then
            go:SetActive(true)
        else
            go:SetActive(false)
        end
    end

    local costTid = self.mDupConfigVo.cost[1]
    local costCount = self.mDupConfigVo.cost[2]
    local propsConfigVo = props.PropsManager:getPropsConfigVo(costTid)
    -- self.mTxtCost.text = string.format("·关卡扣除%s：%s", propsConfigVo.name, costCount)

    self:updateItem()
end

function updateItem(self)
    self:removeItem()
    local rewards = AwardPackManager:getAwardListById(self.mDupConfigVo.showAwardId)
    for i = 1, #rewards do
        local vo = rewards[i]
        local propsGrid = PropsGrid:create(self.mScrollContent, { vo.tid, vo.num }, 0.75, false)
        -- propsGrid:setPosition(math.Vector3((i - 1) * 130 + 70, 0, 0))
        table.insert(self.mItemList, propsGrid)
        -- if dup.DupCodeHopeManager:getHadFirstPass(self.mDupConfigVo.dupId) then
        --     local signItem = SimpleInsItem:create(self:getChildGO("ReceiveSign"), propsGrid:getTrans(), "DupCodeHopeInfoReceiveSign")
        --     table.insert(self.mSignList, signItem)
        -- end
    end
end

function removeItem(self)
    for i = #self.mItemList, 1, -1 do
        local item = self.mItemList[i]
        item:poolRecover()
    end
    self.mItemList = {}

    for i = 1, #self.mSignList do
        local item = self.mSignList[i]
        item:poolRecover()
    end
    self.mSignList = {}
end

function onFightHandler(self)
    GameDispatcher:dispatchEvent(EventName.ENTER_TRAINING_FORMATION_SUCCSE)
    local formatoinCallFun = function(callReason)
        GameDispatcher:dispatchEvent(EventName.EXIT_TRAINING_FORMATION_SUCCSE)
    end
    formation.checkFormationFight(PreFightBattleType.Training, nil, self.mDupConfigVo.dupId, formation.TYPE.NORMAL, nil, nil, formatoinCallFun)
    GameDispatcher:dispatchEvent(EventName.CLOSE_TRAINING_INFO_VIEW)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
