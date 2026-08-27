local base = require("Game.ActivitySummer.Year22.UINActSum22MainBtn")
local UINActSum22MainSelectBtn = class("UINActSum22MainSelectBtn", base)

function UINActSum22MainSelectBtn:RefreshSum22BtnUnlock()
  self._isUnlock = true
  self.ui.ani_selected.enabled = true
  self.ui.finished:SetActive(false)
  self.ui.tex_CNName.gameObject:SetActive(true)
  self.ui.tex_ENName.gameObject:SetActive(true)
end

function UINActSum22MainSelectBtn:RefreshSum22Locked()
  self._isUnlock = false
  self.ui.ani_selected.enabled = false
  self.ui.finished:SetActive(true)
  self.ui.tex_CNName.gameObject:SetActive(false)
  self.ui.tex_ENName.gameObject:SetActive(false)
  local color = Color.New(1, 1, 1, 0.2)
  for i, v in ipairs(self.ui.arr_imgs) do
    v.color = color
  end
end

return UINActSum22MainSelectBtn
