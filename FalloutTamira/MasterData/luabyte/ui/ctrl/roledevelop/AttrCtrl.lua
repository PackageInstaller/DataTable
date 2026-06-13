local AttrCtrl = BaseClass("AttrCtrl")

function AttrCtrl:__init(view)
    self._view = view
end

function AttrCtrl:UpdateData(data, idx)
    if type(data.num) == "number" and data.num <= 0 then
        self._view:SetActive(false)
        return 0
    end

    self._view:SetActive(true)
    self._view.imgIcon:SetPic(data.icon)
    self._view.labDesc:SetText(data.desc)
    self._view.labNum:SetText(tostring(data.num))
    if self._view.bg then self._view.bg:SetActive(idx % 2 == 1) end
    return 1
end

function AttrCtrl:OnDispose()
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return AttrCtrl
