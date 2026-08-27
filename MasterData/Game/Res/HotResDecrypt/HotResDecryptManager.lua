local HotResDecryptManager = {}
local CS_AESEncrypt = CS.AESEncrypt

function HotResDecryptManager.TryDecryptHotRes(decryptDic)
  local systemSaveData = PersistentManager:GetDataModel(PersistentConfig.ePackage.SystemData)
  for resPath, key in pairs(decryptDic) do
    if not systemSaveData:IsDecryptedHotRes(resPath) then
      local function completeFunc()
        systemSaveData:SetDecryptedHotRes(resPath)
      end
      
      if isEditorMode then
        print("Editor解密资源:" .. tostring(resPath))
        completeFunc()
      else
        CS_AESEncrypt.DecryptHotRes(resPath, key, completeFunc)
      end
    end
  end
end

return HotResDecryptManager
