-- baoruichang
-- 2022/3/22 15:02:17
-- 场景中的UI
local GroupPhotoCtrl = BaseClass("GroupPhotoCtrl")
local M = GroupPhotoCtrl


function M:__init(view)
    self._view = view
    self._TempOnLoadFurniture = EventMgr:AddListener(UIMessageNames.LOADFURNITURE, Bind(self, self._OnLoadFurniture))


    OtakuFurniturDataMgr:GetFurnituresByType(9, Bind(self, self._InitItem))
end

-- 进入UI，可传参数
function M:_InitItem()
end

function M:_OnLoadFurniture(type)
    if type ~= 9 then
        return
    end
    EventMgr:RemoveListener(UIMessageNames.LOADFURNITURE, self._TempOnLoadFurniture)
    self:_InitItem()
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.LOADFURNITURE, self._TempOnLoadFurniture)
    self._TempOnLoadFurniture = nil
    if self._view then self._view:OnDispose() end
    self._view = nil
end

return GroupPhotoCtrl
