_class("HomelandBreedLandSprite", Object)
HomelandBreedLandSprite = HomelandBreedLandSprite

function HomelandBreedLandSprite:Constructor(parent, cfg)
  self._idleName = "idle_zhongshu"
  self._parent = parent
  self._cfg = cfg
  self._spriteObj = nil
  self._animation = nil
  self._effectReqs = {}
  self._effectObjs = {}
  self:InitSprite()
end

function HomelandBreedLandSprite:InitSprite()
  self._spriteReq = ResourceManager:GetInstance():SyncLoadAsset(self._cfg.BreedSprite .. ".prefab", LoadType.GameObject)
  if self._spriteReq and self._spriteReq.Obj then
    self._spriteObj = self._spriteReq.Obj
    self._spriteObj:SetActive(false)
    self._spriteObj.transform:SetParent(self._parent)
    self._spriteObj.transform.localPosition = Vector3.zero
    self._spriteObj.transform.localRotation = Quaternion.Euler(0, 0, 0)
    self._animation = self._spriteObj:GetComponentInChildren(typeof(UnityEngine.Animation))
  end
  self:LoadEffect()
end

function HomelandBreedLandSprite:ShowSprite(show)
  if self._spriteObj then
    self._spriteObj:SetActive(show)
  end
  if not show then
    for key, _ in pairs(HomelandBreedSpriteEffect) do
      self._effectObjs[key]:SetActive(false)
    end
  end
end

function HomelandBreedLandSprite:Dispose()
  if self._spriteReq then
    self._spriteReq:Dispose()
    self._spriteReq = nil
  end
  if self._spriteObj then
    self._spriteObj:Destroy()
  end
end

function HomelandBreedLandSprite:PlayAnimation(name)
  if self._animation then
    self._animation:PlayQueued(name, UnityEngine.QueueMode.PlayNow)
    self._animation:PlayQueued(self._idleName, UnityEngine.QueueMode.CompleteOthers)
  end
end

function HomelandBreedLandSprite:PlayEffect(key)
  self._effectObjs[key]:SetActive(true)
  if key == "zhaohuan" then
    local animation = self._effectObjs[key]:GetComponent(typeof(UnityEngine.Animation))
    if animation then
      animation:Play("effanim_jy_pt_zhaohuan")
    end
  elseif key == "shifei" then
  elseif key == "jiaoshui" then
    local t1 = GameObjectHelper.FindChild(self._effectObjs[key].transform, "1022001@jiaoshui_texiao")
    local a1 = t1:GetComponent(typeof(UnityEngine.Animation))
    if a1 then
      a1:Play("jiaoshui_texiao")
    end
    local t2 = GameObjectHelper.FindChild(self._effectObjs[key].transform, "eff_jy_1022001_jiaoshui")
    local a2 = t2:GetComponent(typeof(UnityEngine.Animation))
    if a2 then
      a2:Play("effanim_jy_pt_jiaoshui")
    end
  elseif key == "xiaoshi" then
    local animation = self._effectObjs[key]:GetComponent(typeof(UnityEngine.Animation))
    if animation then
      animation:Play("effanim_jy_pt_xiaoshi")
    end
  end
end

function HomelandBreedLandSprite:LoadEffect()
  for key, value in pairs(HomelandBreedSpriteEffect) do
    local req = ResourceManager:GetInstance():SyncLoadAsset(value, LoadType.GameObject)
    local obj
    if req and req.Obj then
      obj = req.Obj
      if key == "shifei" then
        obj.transform:SetParent(GameObjectHelper.FindChild(self._spriteObj.transform, "Dummy001"))
      elseif key == "zhaohuan" then
        obj.transform:SetParent(GameObjectHelper.FindChild(self._spriteObj.transform, "Root"))
      elseif key == "xiaoshi" then
        obj.transform:SetParent(self._parent)
      else
        if key == "jiaoshui" then
          obj.transform:SetParent(self._parent)
        else
        end
      end
      obj.transform.localPosition = Vector3.zero
      obj.transform.localRotation = Quaternion.Euler(0, 0, 0)
      obj:SetActive(false)
    end
    self._effectReqs[key] = req
    self._effectObjs[key] = obj
  end
end
