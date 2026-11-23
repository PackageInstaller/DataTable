UICollectorMainSceneLineVersion2Item = {}

UICollectorMainSceneLineVersion2Item.__index = UICollectorMainSceneLineVersion2Item

function UICollectorMainSceneLineVersion2Item.New(prefab, parent)
	local self = {}
	setmetatable(self, UICollectorMainSceneLineVersion2Item)
	self.gameObject = LuaMgr.InstantiateGO(prefab, parent, false)
	self.transform = self.gameObject:GetComponent("RectTransform")
	return self
end

function UICollectorMainSceneLineVersion2Item:Destroy()
	self.gameObject = nil
	self.transform = nil
end

function UICollectorMainSceneLineVersion2Item:SetData(startPos, endPos)
	SetActive(self.gameObject, true);
	self.transform.anchoredPosition=startPos;
	local X = endPos.x - startPos.x;
	local Y = endPos.y - startPos.y;
	local length = (X ^ 2 + Y ^ 2) ^ 0.5;
	local angle = math.atan(((endPos.y+720) - (startPos.y+720)) ,(endPos.x - startPos.x))
	self.transform.sizeDelta = Vector2(length, 12);
	self.transform.localRotation = Quaternion.Euler(0, 0, angle*180/math.pi);
end

function UICollectorMainSceneLineVersion2Item:Hide()
	SetActive(self.gameObject, false);
end