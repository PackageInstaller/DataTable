-- @FileName:   SandPlayFishAchieveItem.lua
-- @Description:   文件描述
-- @Author: ZDH
-- @Date:   2023-12-20 14:48:32
-- @Copyright:   (LY) 2023 雷焰网络

module("sandPlay.SandPlayFishAchieveItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtPro = self:getChildGO("mTxtPro"):GetComponent(ty.Text)
    self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    self.mTextNoGet = self:getChildGO("mTextNoGet"):GetComponent(ty.Text)

    self.Content = self:getChildTrans("Content")
    self.mBtnGet = self:getChildGO("mBtnGet")
    self.mImgNoGet = self:getChildGO("mImgNoGet")
    self.mImgGeted = self:getChildGO("mImgGeted")
end

function setData(self, data)
    super.setData(self, data)

    self.mTxtName.text = data.config.name
    self.mTxtPro.text = string.format("<size=40><color=#202226>%s</color></size><color=#202226>/%s</color>", data.info.count, data.config.count)
    self.mTxtDes.text = data.config.des

    self:recoverAllGrid()
    local list = self.data.config.reward
    if not table.empty(list) then
        for i, vo in ipairs(list) do
            local propsGrid = PropsGrid:createByData({tid = vo[1], num = vo[2], parent = self.Content, showUseInTip = true})
            table.insert(self.mPropsGridList, propsGrid)
        end
    end

    self.mBtnGet:SetActive(self.data.info.state == 0)
    self.mImgNoGet:SetActive(self.data.info.state == 1)
    self.mImgGeted:SetActive(self.data.info.state == 2)

    self.mTextNoGet.text = _TT(98966)
end

-- UI事件管理
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnGet, function()
        GameDispatcher:dispatchEvent(EventName.SANDPLAY_FISHING_ONREQ_ACHIEVEAWARD, self.data.config.id)
    end)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
    self:recoverAllGrid()

end

function recoverAllGrid(self)
    if self.mPropsGridList then
        for i = 1, #self.mPropsGridList do
            self.mPropsGridList[i]:poolRecover()
        end
    end
    self.mPropsGridList = {}
end

function clearFish(self)
    if self.mFishItemList then
        for k, v in pairs(self.mFishItemList) do
            v:recover()
        end
    end

    self.mFishItemList = {}
end

return _M
