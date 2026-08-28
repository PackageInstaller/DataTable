
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import

--endregion

--region define
local Dark = 1
local SetActive = CfUtils.SetActive
local UISwitchImageType           = typeof(CS.Game.Native.Common.UISwitchImage)
--endregion

---@class StarGroup
local StarGroup = Class('StarGroup')

function StarGroup:__init()
    self._uiSwitchImages = {}
end


function StarGroup:__delete()

end

function StarGroup:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

local GetLightCount = function(highlightNum, limitRowCount)
    if highlightNum <= limitRowCount then
        return highlightNum
    end
    local count = highlightNum % limitRowCount
    return count == 0 and limitRowCount or count
end

---@param highlightNum number 高亮个数
---@param limitRowCount? number 一行限制多少个
---@param grayIsHide? boolean 一行限制多少个
function StarGroup:RefreshUI(highlightNum, limitRowCount, grayIsHide)
    limitRowCount = limitRowCount or 5

    local lightCount = GetLightCount(highlightNum, limitRowCount)
    local statusOffset  = math.max(math.ceil(highlightNum / limitRowCount), 1)

    for i = 1, limitRowCount do
        local uiSwiImage = self._uiSwitchImages[i]
        if isNull(uiSwiImage) then
            local transform = self.controller.transform
            local img = transform:Find("ImgStar" .. i)
            if isNull(img) then
                img = self.controller.gameObject:AddChild(transform:GetChild(0).gameObject)
            end
            
            uiSwiImage = img:GetComponent(UISwitchImageType)
            self._uiSwitchImages[i] = uiSwiImage
        end
        local status = self:GetStatus(lightCount, i, statusOffset)
        if grayIsHide and status == 1 then
            CfUtils.SetActive(uiSwiImage, false)
        else
            CfUtils.SetActive(uiSwiImage, true)
            uiSwiImage.Status = status
        end

    end


end

function StarGroup:GetStatus(count, i, statusOffset)
    local status
    if count >= i then
        status = statusOffset + Dark
    else
        status = statusOffset
    end
    return status
end

--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return StarGroup
