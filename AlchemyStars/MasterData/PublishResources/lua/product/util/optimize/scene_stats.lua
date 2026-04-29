_class("SceneStats", Object)
SceneStats = SceneStats

function SceneStats:Constructor()
end

function SceneStats:OnGetTexturePixelPercentageDataCoroutine(TT, meshRenderers, wait)
  local textureDic = {}
  local count = meshRenderers.Length
  local ret = {}
  for i = 0, count - 1 do
    local mesh = meshRenderers[i]
    local pixPercentage = self:OnGetRenderTexturePixel(mesh)
    local materialName = string.sub(tostring(mesh.material.name), 1, -12)
    local textures = mesh.material:GetTexturePropertyNames()
    for j = 0, textures.Length - 1 do
      local curTextName = textures[j]
      local curTexture = mesh.material:GetTexture(curTextName)
      if curTexture then
        local textureName = curTexture.name
        if not textureDic[textureName] then
          textureDic[textureName] = TexturePixelPercentageData:New(textureName, materialName, mesh.material, mesh.gameObject, curTexture)
        end
        local curTexture = textureDic[textureName]
        if not curTexture.pixPercentage or pixPercentage > curTexture.pixPercentage then
          curTexture:SetPixPercentage(pixPercentage)
          curTexture:SetObj(mesh.gameObject)
        end
      end
    end
    if i == count - 1 then
      local tmp = self:OnSetCameraCullingMask(textureDic)
      table.appendArray(ret, tmp)
    elseif wait then
      YIELD(TT, 500)
    end
  end
  return ret
end

function SceneStats:OnGetTexturePixelPercentageData(mode)
  Log.debug("[SceneStats]")
  local world = GameGlobal:GetInstance():GetMainWorld()
  local boardEntity = world:GetRenderBoardEntity()
  local renderBoardCmpt = boardEntity:RenderBoard()
  local goScene = renderBoardCmpt:GetSceneGO("SceneRoot")
  local cMainCamera = world:MainCamera()
  local csCamera = cMainCamera:Camera()
  local meshRenderers = goScene:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
  if meshRenderers.Length > 0 then
    GameGlobal.TaskManager():CoreGameStartTask(function(TT)
      self:OnGetTexturePixelPercentageDataCoroutine(TT, meshRenderers, true)
    end)
  end
end

function SceneStats:OnSetCameraCullingMask(textureDic)
  local textureList = {}
  for i, v in pairs(textureDic) do
    table.insert(textureList, v)
  end
  table.sort(textureList, function(a, b)
    return a.pixPercentage > b.pixPercentage
  end)
  Log.debug("[场景资源使用检测]   开始 按照使用该图片纹理的物体渲染占屏幕比例，从大到小排列")
  local strTextureName, strPixPercentage, strSize, strMaterial, strObj
  local retList = {}
  for _, v in ipairs(textureList) do
    local textureData = v
    strTextureName = textureData:GetTextureName()
    strPixPercentage = string.format("%.2f", textureData:GetPixPercentage()) .. "%"
    strSize = textureData:GetTexture().width .. "x" .. textureData:GetTexture().height
    strMaterial = textureData:GetMaterialName()
    strObj = textureData:GetObj().name
    local ret = strTextureName .. "," .. strPixPercentage .. "," .. strSize .. "," .. strMaterial .. "," .. strObj
    table.insert(retList, ret)
    Log.debug("[场景资源使用检测]", "   图片纹理:", strTextureName, "   使用占比:", strPixPercentage, "   图片尺寸:", strSize, "   材质:", strMaterial, "   使用该图占比最大的物体:", strObj)
  end
  Log.debug("[场景资源使用检测]   结束")
  return retList
end

function SceneStats:OnGetRenderTexturePixel(mesh)
  local csTex2d = OptimizeHelper.GetOptimizeTexture2D(mesh.gameObject)
  local texw = csTex2d.width
  local texh = csTex2d.height
  local pixels = csTex2d:GetPixels()
  local index = 0
  local pixTotal = 0
  local pixActualDraw = 0
  for y = 0, texh - 1 do
    for x = 0, texw - 1 do
      local r = pixels[index].r
      local g = pixels[index].g
      local b = pixels[index].b
      local isEmptyPix = self:IsEmptyPix(r, g, b)
      if isEmptyPix == false then
        pixTotal = pixTotal + 1
      end
      index = index + 1
    end
  end
  OptimizeHelper.OnRenderTextureClear()
  local pixPercentage = pixTotal / pixels.Length * 100
  return pixPercentage
end

function SceneStats:IsEmptyPix(r, g, b)
  return r < 0.001 and g <= 0.001 and b <= 0.001
end
