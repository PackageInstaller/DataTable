local LotteryProbabilitySpItemCtrl = BaseClass("LotteryProbabilitySpItemCtrl",UIBaseComponent)
local M = LotteryProbabilitySpItemCtrl


function M:Init(quality,probability,upItemIds,normalItemIds)
    self._view.title:Init(quality,probability)
    local upNumber = 0
    local normalHeroNumber = 0
    if  upItemIds ~= nil then
        upNumber = #upItemIds
        for i = 1, #upItemIds do
            local obj = self._view.upPrefab:Instantiate()
            obj.transform:SetParent(self._view.upPrefab.transform.parent)
            obj.transform.localScale = self._view.upPrefab.transform.localScale;
            obj.transform.localPosition = self._view.upPrefab.transform.localPosition;
            local data = IHeroDataMgr:GetHeroDataById(upItemIds[i])
            obj.item:SetItemNameActive(true)
            obj.item:SetInfo(upItemIds[i],0,1,0)
            obj.item:EnablePopItem(true)
            obj.item:SetActive(true);
        end
    end

    if  normalItemIds ~= nil then
        normalHeroNumber = #normalItemIds
        for i = 1 ,#normalItemIds do
            local obj = self._view.normalPrefab:Instantiate()
            obj.transform:SetParent(self._view.normalPrefab.transform.parent)
            obj.transform.localScale = self._view.normalPrefab.transform.localScale;
            obj.transform.localPosition = self._view.normalPrefab.transform.localPosition;
            obj.item:SetItemNameActive(true)
            obj.item:SetInfo(normalItemIds[i],0,1,0)
            obj.item:EnablePopItem(true)
            obj.item:SetActive(true);
        end
    end

    --格式化
    local defaultWidth = self._view.upScroll:GetRectSizeDelta().x
    local defaultNormalWidth = self._view.normalScroll:GetRectSizeDelta().x
    local upX = (defaultWidth/4) * upNumber
    local normalX = (defaultWidth+defaultNormalWidth)-upX
    self._view.upScroll:GetRectTransform():SetRectSizeDeltaX(upX)
    self._view.normalScroll:GetRectTransform():SetRectSizeDeltaX(normalX)

    self._view.normalScroll:SetEnable((upNumber + normalHeroNumber) > 9)
    self._view.normalScroll:SetHorizontal((upNumber + normalHeroNumber) > 9)
    

    self._view:SetActive(true)
end


return M
