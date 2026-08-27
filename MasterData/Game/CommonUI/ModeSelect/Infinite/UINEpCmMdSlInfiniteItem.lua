local base = UIBaseNode
local UINEpCmMdSlInfiniteItem = class("UINEpCmMdSlInfiniteItem", base)

function UINEpCmMdSlInfiniteItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.Btn_Check, self, self._OnClickDetail)
  UIUtil.AddButtonListener(self.ui.Btn_Root, self, self._OnClickRoot)
end

function UINEpCmMdSlInfiniteItem:InitEpCmMdSlInfiniteItem(idx, epFmtSaveData, selectFunc)
  self._idx = idx
  self._epFmtSaveData = epFmtSaveData
  self._selectFunc = selectFunc
  if idx == 1 then
    self.ui.Tex_Title:SetIndex(0)
    self.ui.Img_Icon:SetIndex(0)
  else
    local envCfg = epFmtSaveData:GetFmtSvEnvCfg()
    self.ui.Tex_Title.text.text = LanguageUtil.GetLocaleText(envCfg.env_name)
    self.ui.Img_Icon:SetIndex(1)
  end
  self.ui.Tex_Score.text = tostring(epFmtSaveData:GetFmtSvScore())
  self:SelectEpCmMdSlInfiniteItem(false)
end

function UINEpCmMdSlInfiniteItem:SelectEpCmMdSlInfiniteItem(isSelect)
  self.ui.Obj_Selected:SetActive(isSelect)
end

function UINEpCmMdSlInfiniteItem:_OnClickDetail()
  UIManager:ShowWindowAsync(UIWindowTypeID.InfinityFmtCheck, function(win)
    if win == nil then
    end
    win:InitFmtSaveChipPanel(self._epFmtSaveData)
  end)
end

function UINEpCmMdSlInfiniteItem:_OnClickRoot()
  if self._selectFunc ~= nil then
    self._selectFunc(self._idx)
  end
end

function UINEpCmMdSlInfiniteItem:OnDelete()
  base.OnDelete(self)
end

return UINEpCmMdSlInfiniteItem
