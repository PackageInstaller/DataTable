local M = BaseClass("MissionMapUICtrl", BaseUICtrl)

function M:Init()
    self._view.closeBtn:onClick(Bind(self, self.Close))
end

function M:OnEnter(path)
    if string.isNullOrEmpty(path) then
        Logger.LogError("map is null, @四叶填写地图路径.")
        return
    end
    self._view.mapPic:SetPic(path)
end

--点击设置退出键
function M:OnDeviceBack()
    self:Close()
    return true
end

return M
