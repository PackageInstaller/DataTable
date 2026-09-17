local this = class("cellSituationItem", G_UIModuleBase)

function this.bind()
  return {
    active_select = false,
    active_selectEmpty = false,
    txt_name = "",
    active_lock = false,
    active_unSelect = false,
    active_unSelectEmpty = false
  }
end

function this.methods()
  return {
    onClick = function(self)
      self:emit("onClick", self.bind.id)
    end
  }
end

function this:open()
  L_SituationStore:listenCallFunc(L_SituationStore.event.coverChanged, self.onCoverChanged, self)
  L_SituationStore:listenCallFunc(L_SituationStore.event.nameChanged, self.onNameChanged, self)
end

function this:refresh()
  local isEmpty = self.bind.solutionData == nil
  self.bind.active_lock = isEmpty
  if self.bind.solutionData and not self.bind.solutionData.coverName then
    self.bind.active_selectEmpty = true
    self.bind.active_unSelectEmpty = true
  end
  if self.bind.solutionData then
    self.bind.txt_name = self.bind.solutionData.name
  end
  self:showImg()
end

function this:refreshSelect(id)
  local isEmpty = self.bind.solutionData == nil
  if not isEmpty then
    self.bind.active_select = self.bind.id == id
    self.bind.active_unSelect = self.bind.id ~= id
  end
end

function this:onCoverChanged(id, tex)
  if id == self.bind.id and tex and tex and self.bindComponents.rawImg and self.bindComponents.rawImg2 then
    self.bindComponents.rawImg.texture = tex
    self.bindComponents.rawImg2.texture = tex
    if self.mat then
      C_UnityObject.Destroy(self.mat)
      self.mat = nil
    end
    local mat = C_UnityObject.Instantiate(self.bindComponents.rawImg.material)
    mat:EnableKeyword("FIX_TO_GAMMA")
    self.bindComponents.rawImg.material = mat
    self.bindComponents.rawImg2.material = mat
    self.mat = mat
    self.bind.active_selectEmpty = false
    self.bind.active_unSelectEmpty = false
  end
end

function this:onNameChanged(id)
  if id == self.bind.id then
    local info = L_SituationStore:getSolutionInfo(id)
    if info then
      self.bind.txt_name = info.name
    end
  end
end

function this:showImg()
  if self.texture then
    C_UnityObject.Destroy(self.texture)
  end
  L_SituationManager:getCoverTex(self.bind.id, function(tex)
    if tex and self.bindComponents.rawImg and self.bindComponents.rawImg2 then
      self.bindComponents.rawImg.texture = tex
      self.bindComponents.rawImg2.texture = tex
      if self.texCache then
        C_PhotoManager.ReleaseTexture(self.texCache)
        self.texCache = nil
      end
      self.texCache = tex
    else
      C_PhotoManager.ReleaseTexture(tex)
    end
    if self.mat then
      self.mat:DisableKeyword("FIX_TO_GAMMA")
    end
  end)
end

function this:close()
  L_SituationStore:unListenCallFunc(L_SituationStore.event.coverChanged, self.onCoverChanged, self)
  L_SituationStore:unListenCallFunc(L_SituationStore.event.nameChanged, self.onNameChanged, self)
  if self.texCache then
    CS.Lens.Gameplay.Managers.PhotoManager.ReleaseTexture(self.texCache)
    self.texCache = nil
  end
  if self.mat then
    C_UnityObject.Destroy(self.mat)
    self.mat = nil
  end
end

return this
