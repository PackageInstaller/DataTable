module("fightUI.FightDataPreItem", Class.impl("lib.component.BaseItemRender"))

function onInit(self, go)
    super.onInit(self, go)

    self.mHeroContent = self:getChildTrans("mHeroContent")
    self.mHeroName = self:getChildGO("mHeroName"):GetComponent(ty.Text)

    self.mDataList = {}

    self.mSliderImg1 =  self:getChildGO("mSilderImg1"):GetComponent(ty.RectTransform)
    self.mSliderImg2 =  self:getChildGO("mSilderImg2"):GetComponent(ty.RectTransform)
    self.mSliderImg3 =  self:getChildGO("mSilderImg3"):GetComponent(ty.RectTransform)
end

--GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
function setData(self, data)
    super.setData(self, data)
    self.data = data

    local dataList = {}

    local startNum = data.startShowNum
    local maxNum = data.maxValue
   
    for i = 1, #self.mDataList do
        self.mDataList[i]:SetActive(i<= #data.kvList)


        -- if i <= #dataList then
        --     self.mDataList[i].transform:GetComponent(ty.Text).text = dataList[i].key
        --     self.mDataList[i].transform:Find("mSliderImg/mNumTxt"):GetComponent(ty.Text).text = dataList[i].value
        --     local img = self.mDataList[i].transform:Find("mSliderImg"):GetComponent(ty.RectTransform)
        --     gs.TransQuick:SizeDelta01(img, dataList[i].value / maxNum * 200)
        -- end
    end

end

function onDelete(self)
    super.onDelete(self)
end


return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
