local data = {
    isSelectDrag = false,
    isSelectOccupy = false,
    isSelectMove = false,
    isSelectSeat = false,
    pos = "",
    isSeat = false,
    seatDatas = {{id="",angle="0",face="1",isSelect=false}},
};

local this = {
    vm = nil,
    roomDropdownTF = nil,
    buildingDropdownTF = nil,
    roomList = {"","101","102","103","104"},
    buildingList = nil,
    buildingId = "",
    artGO = nil,
    seatListTF = nil,
    addSeatTF = nil,
    seatList = {},
    seatIndex = 0,
    character = nil,
};


this.OnBack = function()
    FoundationMgr.Enter(FoundationMgr.Outside);
end


this.ReadBuildings = function()
    this.buildingList = {};
    local files = LuaMgr.GetFilesName(LuaMgr.GetAssetsPath().."/_BundleResources/Foundation/Building", ".prefab", ".meta");
    local len = files.Length - 1;
    for i = 0, len do
        table.insert(this.buildingList, files[i]);
    end
end


this.SelectBuilding = function(id)
    this.buildingId = id;
    FoundationEditor.ClearGrids();
    this.ClearSeat();
    local scale = 1;
    local input = this.buildingScaleInput.text;
    if (input ~= "") then
        scale = tonumber(input);
    end
    FoundationEditor.SetBuilding(this.buildingId, scale);
    this.vm.data.isSelectDrag = true;
    this.vm.data.isSelectOccupy = false;
    this.vm.data.isSelectMove = false;
    this.vm.data.isSelectSeat = false;
    FoundationEditor.SetGridType(0);
end


this.SelectRoom = function(id)
    this.ClearRoom();
    this.CreateRoom(id);
end


this.CreateRoom = function(id)
    local target = nil;
    if (id == "101") then
        target = FoundationExpoHall.GetThis();
    elseif (id == "102") then
        target = FoundationWorking.GetThis();
    elseif (id == "103") then
        target = FoundationOffice.GetThis();
    elseif (id == "104") then
        target = FoundationTeaRoom.GetThis();
    end
    if (target ~= nil) then
        local editor = FoundationEditor.GetThis();
        local artTF = target.transform:Find("Art");
        this.artGO = GameObject.Instantiate(artTF.gameObject);
        this.artGO.transform:SetParent(editor.transform, false);
        this.artGO.transform.localPosition = Vector3.zero;
        FoundationEditor.InitGrids(id);
    end
end


this.OnMoveBuilding = function(args)
    this.vm.data.pos = string.format("x:%d\ny:%d", args[0], args[1]);
end


this.ClearRoom = function()
    if (this.artGO ~= nil) then
        LuaMgr.DestroyImmediateGO(this.artGO);
        this.artGO = nil;
    end
end


this.SetSeats = function()
    local datas = {};
    local len = #this.seatList;
    for i = 1, len do
        local seat = this.seatList[i];
        datas[i] = {id=tostring(i), angle=tostring(seat.angle), face=tostring(seat.face), isSelect=false};
    end
    this.vm.data.seatDatas = datas;
    this.addSeatTF:SetAsLastSibling();
end


this.AddSeat = function()
    local seat = {angle=0, face=1, x=0, y=0, z=0, grids={}};
    table.insert(this.seatList, seat);
    this.SetSeats();
    this.SelectSeat(#this.seatList);
end


this.RemoveSeat = function(index)
    table.remove(this.seatList, index);
    this.seatIndex = 0;
    this.SetSeats();
    this.SelectSeat(0);
    this.RemoveSitCharacter();
end


this.SetSitCharacter = function(seat)
    local editor = FoundationEditor.GetThis();
    local building = editor.building;
    if (building == nil) then return end

    if (this.character == nil) then
        this.character = FoundationCharacter.New(editor.building.transform);
        this.character:SetData("character", "A0096", "A0096001");
        this.character.character:SetDistortZIntensity(false);
    end
    this.character.character:Play("house_sit", seat.face, true, nil);
    this.character.transform.localPosition = Vector3(seat.x, seat.y, seat.z);
    local spineTF = this.character.character.transform:Find("Spine");
    spineTF.localRotation = UnityEngine.Quaternion.Euler(15, 0, 0);
end


this.RemoveSitCharacter = function()
    if (this.character ~= nil) then
        this.character:Clear();
        this.character = nil;
    end
end


this.SelectSeat = function(index)
    if (this.seatIndex ~= index) then
        if (this.seatIndex > 0) then
            this.SaveSeat(this.seatIndex);
            this.vm.data.seatDatas[this.seatIndex].isSelect = false;
        end
        FoundationEditor.ClearSeatGrids();
        this.seatIndex = index;
        if (this.seatIndex > 0) then
            local seat = this.seatList[this.seatIndex];
            this.SetSitCharacter(seat);
            FoundationEditor.SetAngle(seat.angle);
            FoundationEditor.SetSeatGrids(seat.grids);
            this.vm.data.seatDatas[this.seatIndex].isSelect = true;
        end
    end
end


this.SaveSeat = function(index)
    if (index > 0) then
        local editor = FoundationEditor.GetThis();
        local seat = this.seatList[index];
        local seatTF = this.seatListTF:Find(tostring(index));
        local angle = seatTF:Find("Angle/Input"):GetComponent("InputField");
        seat.angle = tonumber(angle.text);
        local face = seatTF:Find("Face/Input"):GetComponent("InputField");
        seat.face = tonumber(face.text);
        this.character.character:Play("house_sit", seat.face, true, nil);
        local pos = this.character.transform.localPosition;
        seat.x = math.floor(pos.x * 1000) * 0.001;
        seat.y = math.floor(pos.y * 1000) * 0.001;
        seat.z = math.floor(pos.z * 1000) * 0.001;
        seat.grids = {};
        for k, _ in pairs(editor.gridSeat) do
            local list = NumTool.split(k, "_");
            local x = tonumber(list[1]) - editor.buildingConfig.x;
            local y = tonumber(list[2]) - editor.buildingConfig.y;
            table.insert(seat.grids, {x = x, y = y});
        end
    end
end


this.ClearSeat = function()
    this.RemoveSitCharacter();
    this.seatList = {};
    this.seatIndex = 0;
    this.vm.data.isSeat = false;
    FoundationEditor.ClearSeatGrids();
end

local command = {
    OnClickDrag = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isSelectDrag = true;
            this.vm.data.isSelectOccupy = false;
            this.vm.data.isSelectMove = false;
            this.vm.data.isSelectSeat = false;
            this.ClearSeat();
            FoundationEditor.SetGridType(0);
        end
    },
    OnClickOccupy = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isSelectDrag = false;
            this.vm.data.isSelectOccupy = true;
            this.vm.data.isSelectMove = false;
            this.vm.data.isSelectSeat = false;
            this.ClearSeat();
            FoundationEditor.SetGridType(2);
        end
    },
    OnClickMove = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isSelectDrag = false;
            this.vm.data.isSelectOccupy = false;
            this.vm.data.isSelectMove = true;
            this.vm.data.isSelectSeat = false;
            this.ClearSeat();
            FoundationEditor.SetGridType(1);
        end
    },
    OnClickSave = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SaveSeat(this.seatIndex);
            FoundationEditor.SaveConfig(this.seatIndex > 0 and this.seatList or nil);
        end
    },
    OnClickSelectRoom = {
        type = XLuaCommandType.Int,
        execute = function(vm, value, param)
            this.SelectRoom(this.roomList[value + 1]);
        end
    },
    OnClickSelectBuilding = {
        type = XLuaCommandType.Int,
        execute = function(vm, value, param)
            this.SelectBuilding(this.buildingList[value + 1]);
        end
    },
    OnClickSearch = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local input = this.buildingInput.text;
            if (input ~= "") then
                this.SelectBuilding(input);
            end
        end
    },
    OnClickSeat = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.vm.data.isSelectDrag = false;
            this.vm.data.isSelectOccupy = false;
            this.vm.data.isSelectMove = false;
            this.vm.data.isSelectSeat = true;
            this.vm.data.isSeat = true;
            FoundationEditor.SetGridType(4);
            local editor = FoundationEditor.GetThis();
            this.seatList = editor.buildingConfig.seats or {};
            this.SetSeats();
        end
    },
    OnClickSeatItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SelectSeat(param + 1);
        end
    },
    OnClickSeatRemoveItem = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.RemoveSeat(param + 1);
        end
    },
    OnClickAddSeat = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.SaveSeat(this.seatIndex);
            this.AddSeat();
        end
    },
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;
        this.roomDropdownTF = vm.behaviour.transform:Find("root/Middle/Editor/Building/RoomDropdown");
        this.buildingDropdownTF = vm.behaviour.transform:Find("root/Middle/Editor/Building/BuildingDropdown");
        this.buildingScaleInput = vm.behaviour.transform:Find("root/Middle/Editor/Building/BuildingScaleInput"):GetComponent("InputField");
        this.buildingInput = vm.behaviour.transform:Find("root/Middle/Editor/Building/BuildingInput"):GetComponent("InputField");
        this.seatListTF = vm.behaviour.transform:Find("root/Middle/Editor/SeatList/List");
        this.addSeatTF = vm.behaviour.transform:Find("root/Middle/Editor/SeatList/AddSeat"):GetComponent("RectTransform");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end

        LuaMgr.AddUIEventListener(UIEventConst.FoundationEditorMoveBuilding, this.OnMoveBuilding);
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.ReadBuildings();
        LuaMgr.BindDropdownList(this.roomDropdownTF, this.roomList);
        LuaMgr.BindDropdownList(this.buildingDropdownTF, this.buildingList);
        if (#this.buildingList > 0) then
            this.SelectBuilding(this.buildingList[1]);
        end
    end,
    before_deactive = function(vm)
        LuaMgr.RemoveUIEventListener(UIEventConst.FoundationEditorMoveBuilding, this.OnMoveBuilding);
        this.buildingList = nil;
        this.ClearRoom();
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})