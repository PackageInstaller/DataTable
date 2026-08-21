_class("TexturePixelPercentageData", Object)
TexturePixelPercentageData = TexturePixelPercentageData

function TexturePixelPercentageData:Constructor(textureName, materialName, material, obj, texture, pixPercentage, pixCount)
  self.textureName = textureName
  self.materialName = materialName
  self.material = material
  self.obj = obj
  self.texture = texture
  self.pixPercentage = pixPercentage
  self.pixCount = pixCount
end

function TexturePixelPercentageData:GetTextureName()
  return self.textureName
end

function TexturePixelPercentageData:GetMaterialName()
  return self.materialName
end

function TexturePixelPercentageData:GetMaterial()
  return self.material
end

function TexturePixelPercentageData:GetObj()
  return self.obj
end

function TexturePixelPercentageData:SetObj(obj)
  self.obj = obj
end

function TexturePixelPercentageData:GetTexture()
  return self.texture
end

function TexturePixelPercentageData:GetPixPercentage()
  return self.pixPercentage
end

function TexturePixelPercentageData:SetPixPercentage(pixPercentage)
  self.pixPercentage = pixPercentage
end

function TexturePixelPercentageData:GetPixCount()
  return self.pixCount
end

function TexturePixelPercentageData:SetPixCount(pixCount)
  self.pixCount = pixCount
end

_class("TexturePixelPercentageDataRoot", Object)
TexturePixelPercentageDataRoot = TexturePixelPercentageDataRoot

function TexturePixelPercentageDataRoot:Constructor(prefab, name, dataList)
  self.prefab = prefab
  self.name = name
  self.dataList = dataList
end

function TexturePixelPercentageDataRoot:GetPrefabName()
  return self.prefab
end

function TexturePixelPercentageDataRoot:GetName()
  return self.name
end

function TexturePixelPercentageDataRoot:GetDataList()
  return self.dataList
end

function TexturePixelPercentageDataRoot:SetDataList(dataList)
  self.dataList = dataList
end
