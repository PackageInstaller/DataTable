local this = class("dungeonBlockInfo")
local soundNodeName = "[Sound]"

function this:ctor()
  self.name = nil
  self.prefabPath = nil
  self.pos = nil
  self.rot = nil
  self.active = false
  self.gameObject = nil
  self.root = nil
  self.blockSize = 0
  self.showBlockList = nil
  self.isAsyncCreate = false
  self.isDestroy = false
end

function this:dispose()
  if L_CommonUtil.isValid(self.gameObject) then
    Unity.GameObject.DestroyImmediate(self.gameObject)
  end
  self.name = nil
  self.prefabPath = nil
  self.pos = nil
  self.rot = nil
  self.active = false
  self.gameObject = nil
  self.root = nil
  self.blockSize = 0
  self.showBlockList = nil
  self.isAsyncCreate = false
  self.isDestroy = true
end

function this:judgeInCurBlcok(position)
  if position.x < self.pos.x - self.blockSize / 2 then
    return false
  end
  if position.x > self.blockSize / 2 + self.pos.x then
    return false
  end
  if position.z < self.pos.z - self.blockSize / 2 then
    return false
  end
  if position.z > self.blockSize / 2 + self.pos.z then
    return false
  end
  return true
end

function this:setActive(isActive, isSync)
  if isActive == self.active then
    return
  end
  self.active = isActive
  if self.prefabPath == nil then
    return
  end
  if self.active then
    if not L_CommonUtil.isValid(self.gameObject) then
      if self.isAsyncCreate then
        return
      end
      self.isAsyncCreate = true
      
      local function _endCal(id, go)
        if self.isDestroy then
          Unity.GameObject.DestroyImmediate(go)
          return
        end
        local roadGo = go
        roadGo.name = tostring(self.name or "")
        roadGo.transform:SetParent(self.root.transform)
        L_Vector3.setLocalPos(roadGo.transform, self.pos)
        L_Vector3.setLocalRot(roadGo.transform, self.rot)
        local soundNode = roadGo.transform:Find(soundNodeName)
        local listener = C_CameraManager.mainCamera:GetComponent(typeof(C_CriAtomListener))
        if L_CommonUtil.isValid(soundNode) then
          local soundListenList = L_GameUtil.getComponentListAllByType(soundNode, typeof(C_CriAtomSource))
          for i = 1, #soundListenList do
            soundListenList[i].listenerOnStart = listener
          end
        end
        self.gameObject = roadGo
        self.gameObject:ActiveTrans(self.active)
      end
      
      if isSync == true then
        local roadGo = L_ResPool:syncGameObject(self.prefabPath)
        _endCal(roadGo)
      else
        L_ResPool:asyncGameObject(self.prefabPath, _endCal)
      end
    else
      self.gameObject:ActiveTrans(true)
    end
  elseif L_CommonUtil.isValid(self.gameObject) then
    self.gameObject:ActiveTrans(false)
  end
end

return this
