_class("MonsterStats", Object)
MonsterStats = MonsterStats

function MonsterStats:Constructor()
end

function MonsterStats:OnGetTexturePixelPercentageData()
  Log.debug("[MonsterStats]")
  local eulerAnglesList = {
    Vector3(0, 0, 0),
    Vector3(0, 45, 0),
    Vector3(0, 90, 0),
    Vector3(0, 135, 0),
    Vector3(0, 180, 0),
    Vector3(0, 225, 0),
    Vector3(0, 270, 0),
    Vector3(0, 315, 0)
  }
  local world = GameGlobal:GetInstance():GetMainWorld()
  local cfg_monster_class = Cfg.cfg_monster_class()
  local cfgCount = table.count(cfg_monster_class)
  local cMainCamera = world:MainCamera()
  local csCamera = cMainCamera:Camera()
  local rootDic = {}
  self._prefabNameDic = {}
  local calcCount = 0
  GameGlobal.TaskManager():CoreGameStartTask(function(TT)
    UnityEngine.Screen.SetResolution(320, 180, UnityEngine.FullScreenMode.FullScreenWindow, 0)
    YIELD(TT, 1000)
    cMainCamera:_MoveCameraToFocus()
    YIELD(TT, 5000)
    for k, v in pairs(cfg_monster_class) do
      calcCount = calcCount + 1
      local stResPathr = v.ResPath
      local prefabName = string.sub(tostring(stResPathr), 1, -8)
      if "empty.prefab" ~= stResPathr then
        local request = UnityResourceService:GetInstance():LoadGameObject(stResPathr)
        if not request then
          Log.error(stResPathr .. " 该预制体读取不到,monster_calss表里ID=" .. v.ID)
        else
          if not self._prefabNameDic[prefabName] then
            self._prefabNameDic[prefabName] = {}
            local curPrefabNameDic = self._prefabNameDic[prefabName]
            table.insert(curPrefabNameDic, v.ID)
            local go = request.Obj
            go.name = prefabName
            go.transform.position = Vector3(0, 0, -1)
            go.transform.localEulerAngles = Vector3(0, 135, 0)
            YIELD(TT)
            local textureDic = {}
            if not rootDic[prefabName] then
              rootDic[prefabName] = TexturePixelPercentageDataRoot:New(prefabName, StringTable.Get(v.Name), nil)
            end
            local curDic = rootDic[prefabName]
            local meshRenderers = go:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer))
            local skinnedmeshRenderers = go:GetComponentsInChildren(typeof(UnityEngine.SkinnedMeshRenderer))
            local allMeshRenderersList = {}
            if 0 < meshRenderers.Length then
              for i = 0, meshRenderers.Length - 1 do
                local mesh = meshRenderers[i]
                table.insert(allMeshRenderersList, mesh)
              end
            end
            if 0 < skinnedmeshRenderers.Length then
              for i = 0, skinnedmeshRenderers.Length - 1 do
                local mesh = skinnedmeshRenderers[i]
                table.insert(allMeshRenderersList, mesh)
              end
            end
            for _, eulerAngles in pairs(eulerAnglesList) do
              go.transform.localEulerAngles = eulerAngles
              YIELD(TT)
              if 0 < table.count(allMeshRenderersList) then
                for i = 1, table.count(allMeshRenderersList) do
                  local mesh = allMeshRenderersList[i]
                  local pixPercentage, pixCount = self:OnGetRenderTexturePixel(csCamera, mesh)
                  local materialName = string.sub(tostring(mesh.material.name), 1, -12)
                  local textures = mesh.material:GetTexturePropertyNames()
                  for j = 0, textures.Length - 1 do
                    local curTextName = textures[j]
                    local curTexture = mesh.material:GetTexture(curTextName)
                    if curTexture then
                      local texutreName = curTexture.name
                      if not textureDic[texutreName] then
                        textureDic[texutreName] = TexturePixelPercentageData:New(texutreName, materialName, mesh.material, mesh.gameObject, curTexture)
                      end
                      local curtextur = textureDic[texutreName]
                      if not curtextur.pixCount or pixCount > curtextur.pixCount then
                        curtextur:SetPixPercentage(pixPercentage)
                        curtextur:SetObj(mesh.gameObject)
                        curtextur:SetPixCount(pixCount)
                      end
                    end
                  end
                end
              end
            end
            local textureList = {}
            for i, v in pairs(textureDic) do
              table.insert(textureList, v)
            end
            table.sort(textureList, function(a, b)
              return a.pixPercentage > b.pixPercentage
            end)
            curDic:SetDataList(textureList)
            YIELD(TT)
            UnityEngine.Object.Destroy(go)
            YIELD(TT)
          else
            local curPrefabNameDic = self._prefabNameDic[prefabName]
            table.insert(curPrefabNameDic, v.ID)
          end
          if calcCount == cfgCount then
            break
          end
        end
      end
    end
    YIELD(TT, 2000)
    self:OnSetCameraCullingMask(rootDic)
    cMainCamera:_MoveCameraToNormal()
    UnityEngine.Screen.SetResolution(UnityEngine.Screen.width, UnityEngine.Screen.height, UnityEngine.FullScreenMode.FullScreenWindow, 0)
  end)
end

function MonsterStats:OnSetCameraCullingMask(rootDic)
  local world = GameGlobal:GetInstance():GetMainWorld()
  Log.debug("[怪物资源使用检测]   开始 按照使用该图片纹理的物体渲染占屏幕比例，从大到小排列")
  local outDebugPrefabList = {}
  local outDebugTextureList = {}
  local outDebugPixPercentageList = {}
  local outDebugPixCountList = {}
  local outDebugSizeList = {}
  local outDebugMaterialList = {}
  local outDebugIDList = {}
  for i, v in pairs(rootDic) do
    local textureDataRoot = v
    local prefabName = textureDataRoot:GetPrefabName()
    local textureList = textureDataRoot:GetDataList()
    local strID = "   预制体:" .. prefabName
    local idList = self._prefabNameDic[prefabName]
    local stdIDList = "   使用该预制体的ID有:{"
    for _, v in pairs(idList) do
      stdIDList = stdIDList .. v .. ","
    end
    stdIDList = stdIDList .. "}"
    Log.debug(strID)
    if textureList then
      for _, v2 in ipairs(textureList) do
        local textureData = v2
        local targetTexture = textureData:GetTexture()
        if targetTexture then
          local strTextureName = "   图片纹理:" .. textureData:GetTextureName()
          local strPixPercentage = "   使用占比:" .. string.format("%.2f", textureData:GetPixPercentage()) .. "%"
          local strPixCount = "   像素数量:" .. textureData:GetPixCount()()
          local strSize = "   图片尺寸:" .. targetTexture.width .. "x" .. targetTexture.height
          local strMaterial = "   材质:" .. textureData:GetMaterialName()
          Log.debug("[怪物资源使用检测]" .. strID .. strTextureName .. strPixPercentage .. strSize .. strMaterial .. stdIDList)
          table.insert(outDebugPrefabList, strID)
          table.insert(outDebugTextureList, strTextureName)
          table.insert(outDebugPixPercentageList, strPixPercentage)
          table.insert(outDebugPixCountList, strPixCount)
          table.insert(outDebugSizeList, strSize)
          table.insert(outDebugMaterialList, strMaterial)
          table.insert(outDebugIDList, stdIDList)
        end
      end
    end
  end
  Log.debug("[怪物资源使用检测]   结束")
end

function MonsterStats:OnGetRenderTexturePixel(csCamera, mesh)
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
  return pixPercentage, pixTotal
end

function MonsterStats:IsEmptyPix(r, g, b)
  return r < 0.001 and g <= 0.001 and b <= 0.001
end
