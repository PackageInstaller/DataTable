local ContainerData = class("ContainerData")

function ContainerData:ctor()
  self.imgCount = 0
  self.imgPath = nil
  self.urlType = 1
  self.urlValue = nil
end

function ContainerData:Init(imgPath, urlType, urlValue)
  self.imgPath = imgPath
  self.urlType = urlType
  self.urlValue = urlValue
end

function ContainerData:GetUrl()
  return self.urlValue, self.urlType
end

return ContainerData
