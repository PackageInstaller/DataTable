local cell = class("cellActivateWorldBuff", G_UIModuleBase)

function cell.bind()
  return {txt_buffDesc = ""}
end

function cell.methods()
  return {}
end

function cell:onSetData(param)
  self._buffId = param.buffId
  self._buffDesc = param.buffDesc
  self:OnRefreshInfo()
end

function cell:OnRefreshInfo()
  if not self.isBind then
    return
  end
  self.bind.txt_buffDesc = self._buffDesc
end

return cell
