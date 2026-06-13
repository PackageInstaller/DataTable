local DotsToggler = BaseClass("DotsToggler", UIBaseComponent )
local M = DotsToggler


function M:OnCreate( unity_dotsToggler )
    -- body
    self._unity_dotsToggler = unity_dotsToggler
    self.currentIndex = self._unity_dotsToggler.currentIndex 
    self.length = 0 
end

--设置长度
function M:SetLength(length)
    self.length = length 
    self.total = length 
    self._unity_dotsToggler:SetLength(length)
end

--设置索引  索引从 
function M:SetIndex(index)
    if index == nil or self.length == 0 then 
        return 
    end
    if index < 0 or index >= self.length then 
        Logger.LogError("the range of index must be within 1 ~ length ")
        return 
    end
    self._unity_dotsToggler:SetIndex(index)
    self.currentIndex = self._unity_dotsToggler.currentIndex 
end

return DotsToggler