_class("HomeStoryEntityModel", HomeStoryEntityMovable)
HomeStoryEntityModel = HomeStoryEntityModel
local ModelSubType = {
  Player = 1,
  Pet = 10,
  Other = 100
}

function HomeStoryEntityModel:Constructor(ID, gameObject, resRequest, storyManager, cfg, parent, skinid)
  HomeStoryEntityModel.super.Constructor(self, ID, gameObject, resRequest, storyManager)
  self._skinID = skinid
  if self._skinID then
    local face_name = self._skinID .. "_face"
    local face = GameObjectHelper.FindChild(self._gameObject.transform, face_name)
    if face then
      local render = face.gameObject:GetComponent(typeof(UnityEngine.SkinnedMeshRenderer))
      if not render then
        Log.error("###[HomeStoryEntityModel] 面部表情节点上找不到SkinnedMeshRenderer：", face_name)
      else
        self._faceMat = render.material
      end
    else
      Log.error("###[HomeStoryEntityModel] 找不到面部表情节点：", face_name)
    end
  end
  self._headSlot = GameObjectHelper.FindChild(self._gameObject.transform, "Bip001 Head")
  if not self._headSlot then
    Log.error("###[HomeStoryEntityModel] model Bip001 Head Not Found. ID-->", ID)
  end
  self._type = HomeStoryEntityType.Model
  self._showBubble = {}
end

function HomeStoryEntityModel:HeadPos()
  if self._headSlot then
    return self._headSlot.position
  else
    return self._gameObject.transform.position + Vector3(0, 1.5, 0)
  end
end

function HomeStoryEntityModel:Pos()
  return self._gameObject.transform.position
end

function HomeStoryEntityModel:GetFaceMat()
  return self._faceMat
end

function HomeStoryEntityModel:_TriggerKeyframe(keyframeData)
  HomeStoryEntityModel.super._TriggerKeyframe(self, keyframeData)
  if keyframeData.FaceSeq ~= nil then
    self:PlayFace(keyframeData.FaceSeq)
  end
  if keyframeData.FaceTo then
    local entityid = keyframeData.FaceTo.ID
    local duration = keyframeData.FaceTo.Duration or 0
    local pos1 = self._storyManager:GetEntityPos(entityid)
    self:_SetLook(pos1, duration)
  elseif keyframeData.BackTo then
    local entityid = keyframeData.BackTo.ID
    local duration = keyframeData.BackTo.Duration or 0
    local pos1 = self._storyManager:GetEntityPos(entityid)
    self:_SetLook(pos1, duration)
  end
  if keyframeData.HeadPos then
    local targetEntityID = keyframeData.HeadPos
    local headPos = self._storyManager:GetEntityHeadPos(targetEntityID)
    self:_SetPosition(headPos)
  end
  if keyframeData.Bubble then
    local bubble = keyframeData.Bubble.ID
    local offset = Vector3(0, 0, 0)
    if keyframeData.Bubble.Offset then
      offset = Vector3(keyframeData.Bubble.Offset[1], keyframeData.Bubble.Offset[2], keyframeData.Bubble.Offset[3])
    end
    local pos = self:HeadPos() + offset * self._storyManager.RootRotation
    self._storyManager:ActiveEntity(bubble, true)
    self._storyManager:SetEntityPos(bubble, pos)
  end
  if keyframeData.HideBubble then
    local bubble = keyframeData.HideBubble
    self._storyManager:ActiveEntity(bubble, false)
  end
end

function HomeStoryEntityModel:SetActive(active)
  self._gameObject:SetActive(active)
end

function HomeStoryEntityModel:SetPos(pos)
  self._gameObject.transform.position = pos
end

function HomeStoryEntityModel:GetBubble(name)
  if not self._bubblePool then
    self._bubblePool = {}
  end
  if not self._bubblePool[name] then
    local request = ResourceManager:GetInstance():SyncLoadAsset(bubbleName, LoadType.GameObject)
    local go = request.Obj
    local data = {}
    data.req = request
    data.go = go
    self._bubblePool[name] = data
  end
  local data = self._bubblePool[name]
  return data.go
end

function HomeStoryEntityModel:Dispose()
  if self._bubblePool then
    for key, value in pairs(self._bubblePool) do
      local req = value.req
      req:Dispose()
    end
    table.clear(self._bubblePool)
    self._bubblePool = nil
  end
end

function HomeStoryEntityModel:Destroy()
  HomeStoryEntityModel.super.Destroy(self)
  self:Dispose()
end

function HomeStoryEntityModel:PlayFace(frame)
  local mat = self:GetFaceMat()
  if mat then
    mat:SetInt("_Frame", frame)
  end
end

function HomeStoryEntityModel:_UpdateAnimation(time)
  local res = HomeStoryEntityModel.super._UpdateAnimation(self, time)
  local allEnd = true
  return res and allEnd
end
