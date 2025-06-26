--[[ 
-----------------------------------------------------
@filename       : InfiniteCityTargetItem
@Description    : 无限城目标奖励item
@date           : 2021-03-10 10:43:05
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('infiniteCity.InfiniteCityTargetItem', Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mImgComplete = self:getChildGO("mImgComplete")
    self.mTxtCount = self:getChildGO("mTxtCount"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mScollContent = self:getChildTrans("Content")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnOver = self:getChildGO("mBtnOver")
    self.mBtnGo = self:getChildGO("mBtnGo")
    self.mImgOver = self:getChildGO("mImgOver")

    self:addOnClick(self.mBtnGet, self.onGet)
    self:addOnClick(self.mBtnOver, self.onOver)
    self:addOnClick(self.mBtnGo, self.onGo)
end

function setData(self, param)
    super.setData(self, param)

    -- 服务器数据（当前数量和状态）
    self.targetMsgData = infiniteCity.InfiniteCityManager:getTargetMsgData(self.data.id)

    self.mTxtCount.text = string.format("%s/%s", self.targetMsgData.count, self.data.args)
    if self.data.args >= 10000 then
        self.mTxtCount.fontSize = 20
    elseif self.data.args >= 1000 then
        self.mTxtCount.fontSize = 24
    elseif self.data.args >= 100 then
        self.mTxtCount.fontSize = 30
    else
        self.mTxtCount.fontSize = 38
    end
    self.mTxtDes.text = self.data:getDes()

    self:updateState()
    self:updateGrid()
end

function onGet(self)
    GameDispatcher:dispatchEvent(EventName.REQ_INFINITE_GET_TARGET, { id = self.data.id })
end
function onGo(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.data.uiCode })
end
function onOver(self)
    -- gs.Message.Show("已领取")
    gs.Message.Show(_TT(7))
end

function updateState(self)
    -- 状态0-未完成1-已完成未领取2-已领取
    if self.targetMsgData.state == 0 then
        self.mImgOver:SetActive(false)
        self.mImgComplete:SetActive(false)

        self.mBtnGet:SetActive(false)
        self.mBtnGo:SetActive(true)
        self.mBtnOver:SetActive(false)

    elseif self.targetMsgData.state == 1 then
        self.mImgOver:SetActive(false)
        self.mImgComplete:SetActive(true)

        self.mBtnGet:SetActive(true)
        self.mBtnGo:SetActive(false)
        self.mBtnOver:SetActive(false)
    else
        self.mImgComplete:SetActive(true)
        self.mImgOver:SetActive(true)

        self.mBtnGet:SetActive(false)
        self.mBtnGo:SetActive(false)
        self.mBtnOver:SetActive(true)
    end
end

function updateGrid(self)
    self:poolrecover()
    for i, v in ipairs(self.data.rewards) do
        local grid = PropsGrid:create(self.mScollContent, { v[1], v[2] }, 0.5)
        table.insert(self.gridList, grid)
    end
end

function poolrecover(self)

    if self.gridList then
        for i, v in ipairs(self.gridList) do
            v:poolRecover()
        end
    end
    self.gridList = {}
end

function deActive(self)
    super.deActive(self)
    self:poolrecover()
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mBtnGet)
    self:removeOnClick(self.mBtnOver)
    self:removeOnClick(self.mBtnGo)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
