module("covenant.CovenantTaskItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mBtnGoto = self:getChildGO("mBtnGoto")
    self.mTxtGet = self:getChildGO("mTxtGet"):GetComponent(ty.Text)
    self.mTxtGoto = self:getChildGO("mTxtGoto"):GetComponent(ty.Text)
    self.mTxtTitle = self:getChildGO("mTxtTitle"):GetComponent(ty.Text)
    self.mTxtCurNum = self:getChildGO("mTxtCurNum"):GetComponent(ty.Text)
    self.mContent = self:getChildTrans("mContent")
    self.mImgProBar = self:getChildGO("mImgProBar"):GetComponent(ty.Image)
    self.mNoGet = self:getChildGO("mNoGet")
    self.mIngTxt = self:getChildGO("mIngTxt")
    self.mGeted = self:getChildGO("mGeted")
    self.mTxtGet.text = _TT(3) -- 领取
    self.mTxtGoto.text = _TT(4) -- 前往

    self:addOnClick(self.mBtnGet, self.onOpHandler)
    self:addOnClick(self.mBtnGoto, self.onOpHandler)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
end

function onDelete(self)
    super.onDelete(self)
    self:removeOnClick(self.mBtnGet, self.onOpHandler)
    self:removeOnClick(self.mBtnGoto, self.onOpHandler)
end


function setData(self, param)
    super.setData(self, param)

    self.localDataVo = param.localData
    self.serverDataVo = param.serverData

    self:updateView()
end

function updateView(self)
    self.mTxtTitle.text = _TT(self.localDataVo.describe)
    self.mTxtCurNum.text = self.serverDataVo.count .. "/" .. self.localDataVo.time
    self.mImgProBar.fillAmount = self.serverDataVo.count / self.localDataVo.time
    self.mNoGet:SetActive(false)
    self.mGeted:SetActive(false)
    if self.serverDataVo.state == 2 then
        self.mBtnGet:SetActive(false)
        self.mBtnGoto:SetActive(false)
        self.mGeted:SetActive(true)
    elseif self.serverDataVo.state == 0 then
        -- 可领取
        self.mBtnGet:SetActive(true)
        self.mBtnGoto:SetActive(false)
    else
        self.mNoGet:SetActive(true)
        local linkId = self.localDataVo.uiCode
        -- 未领取状态 进行中 无法跳转的
        if linkId == 0 then
            self.mBtnGoto:SetActive(true)
            self.mBtnGet:SetActive(false)
        else
            -- 未领取
            self.mBtnGet:SetActive(false)
            self.mBtnGoto:SetActive(true)
        end
    end

    self:recoverAllGrid()
    for i = 1, #self.localDataVo.reward do
        local vo = {}
        vo.tid = self.localDataVo.reward[i][1]
        vo.num = self.localDataVo.reward[i][2]
        local propsGrid = PropsGrid:create(self.mContent, vo, 1)
        table.insert(self.mGridList, propsGrid)
    end
end

function recoverAllGrid(self)
    if self.mGridList then
        for i = 1, #self.mGridList do
            self.mGridList[i]:poolRecover()
        end
    end
    self.mGridList = {}
end

function onOpHandler(self)
    --1:未完成，0:已完成未领奖，2：已领取奖励
    if self.serverDataVo.state == 0 then
        local ids = {}
        table.insert(ids, self.localDataVo.id)
        GameDispatcher:dispatchEvent(EventName.REQ_GAIN_CONVENANT_TASK, { list = ids })
    elseif self.serverDataVo.state == 1 then
        GameDispatcher:dispatchEvent(EventName.OPEN_LINK_UI, { linkId = self.localDataVo.uiCode })
    else
        gs.Message.Show(_TT(7))
    end
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
