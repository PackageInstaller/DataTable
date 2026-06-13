local M = BaseClass("MainPreheatActivityItemCtrl", require("Framework.UI.Component.CircularScrollViewItem"))

function M:Init()
    self._view.img_pic:onClick(Bind(self, self.OnClickItem))
end

function M:UpdateItem(data)
    if data == nil then return end

    self.m_data = data
    self._view.img_pic:SetPic(data.SmallPic)
    self._view.rectNew:SetActive(data.IsNew)
    self._view.uiState:SetState(data.IsSelect and 2 or 1)
    if data.IsSelect then
        self._view.uiState:SetState(2)
        self._view.txt_openTime:SetText(string.format("<size=33>%s</size>", data.OpenStr))
    else
        self._view.uiState:SetState(1)
        self._view.txt_openTime:SetText(string.format("<size=30>%s</size>", data.OpenStr))
    end
    if data.IsNew then
        if TimeUtil.GetNowTimeStamp() > data.OpenTime then
            self._view.img_pic:SetColor(255, 255, 255, 255)
        else
            self._view.img_pic:SetColor(200, 200, 200, 255)
        end
    else
        self._view.img_pic:SetColor(255, 255, 255, 255)
    end
    self._view.redPoint:SetParam(0, data.ChapterId)
    self._view.redPoint:Check()
end

function M:OnClickItem(go)
    if self.m_callback then
        self.m_callback(self.m_data)
    end
end

function M:SetCallback(callback)
    self.m_callback = callback
end

function M:OnDispose()
    self.m_data = nil
    self.m_callback = nil
    M.super.OnDispose(self)
end

return M
