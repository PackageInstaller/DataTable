





local this = {vm=nil};
local colorGray=UnityEngine.Color(193/255,192/255,192/255,255/255);
local colorWhite=UnityEngine.Color(1,1,1,1);
local limitdetaY=30;
local dragSpeed=0.5;
local posLimit={97,-143}
local absorbPos={73,25,-23,-71,-119}
local curYear=nil;
local curMonth=nil;
local curDay=nil;


local minYear=1922;
local maxYear=nil;
local year_upIndex=nil;
local year_downIndex=nil;

local minDay=1;
local maxDay=nil;

local yearDragBehaviour=nil;
local monthDragBehaviour=nil;
local dayDragBehaviour=nil;
local callBack=nil;

local data = {
  
   yearList= {
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,73);
           index=1;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,25),
           tarPos=Vector2(0,0),
           index=2;
       },
       {
           text = "",
           scale = Vector3(1,1,1),
           color = colorWhite,
           pos=Vector2(2.5,-23);
           tarPos=Vector2(0,0),
           index=3;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,-71);
           tarPos=Vector2(0,0),
           index=4;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,-119);
           tarPos=Vector2(0,0),
           index=5;
       },
   },
   monthList= {
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,73);
           index=1;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,25),
           tarPos=Vector2(0,0),
           index=2;
       },
       {
           text = "",
           scale = Vector3(1,1,1),
           color = colorWhite,
           pos=Vector2(2.5,-23);
           tarPos=Vector2(0,0),
           index=3;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,-71);
           tarPos=Vector2(0,0),
           index=4;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,-119);
           tarPos=Vector2(0,0),
           index=5;
       },
   },
   dayList= {
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,73);
           index=1;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,25),
           tarPos=Vector2(0,0),
           index=2;
       },
       {
           text = "",
           scale = Vector3(1,1,1),
           color = colorWhite,
           pos=Vector2(2.5,-23);
           tarPos=Vector2(0,0),
           index=3;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,-71);
           tarPos=Vector2(0,0),
           index=4;
       },
       {
           text = "",
           scale = Vector3(0.8,0.8,0.8),
           color = colorGray,
           pos=Vector2(2.5,-119);
           tarPos=Vector2(0,0),
           index=5;
       },
   }
    
}

local command = {
    closeBtn={
      type=XLuaCommandType.Void,
      execute=function(vm,param)
          LuaMgr.HidePanel(UIName.CalendarViewModel);
      end
    },
    okBtn={
        type=XLuaCommandType.Void,
        execute=function(vm,param)
            if callBack~=nil then
                local birthDay=string.format("%d/%.2d/%.2d",curYear,curMonth,curDay);
                local date=os.date("*t", LuaMgr.Timestamp());
                local isToday=date.month==curMonth and date.day==curDay;
                callBack(birthDay,isToday);
            end
            LuaMgr.HidePanel(UIName.CalendarViewModel);
        end
    },
  
}

local hook = {
    before_awake = function(vm)
        this.vm = vm;

        yearDragBehaviour = vm.behaviour.transform:Find("root/Middle/Group/Content/Year"):GetComponent("OnDragBehaviour");
        yearDragBehaviour.onDrag = this.Year_OnDrag;
        yearDragBehaviour.onEndDrag = this.Year_OnEndDrag;


        monthDragBehaviour = vm.behaviour.transform:Find("root/Middle/Group/Content/Month"):GetComponent("OnDragBehaviour");
        monthDragBehaviour.onDrag = this.Month_OnDrag;
        monthDragBehaviour.onEndDrag = this.Month_OnEndDrag;


        dayDragBehaviour = vm.behaviour.transform:Find("root/Middle/Group/Content/Day"):GetComponent("OnDragBehaviour");
        dayDragBehaviour.onDrag = this.Day_OnDrag;
        dayDragBehaviour.onEndDrag = this.Day_OnEndDrag;
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end

        local date = os.date("*t", LuaMgr.Timestamp());
        curYear=date.year;
        curMonth=1;
        curDay=1;
        if vm.behaviour.Params.Length>0 then
            callBack=vm.behaviour.Params[0];
            local birthDay=vm.behaviour.Params[1];
            if birthDay~=nil and birthDay~="" then
                local births=NumTool.split(birthDay,"/");
                if #births>1 then
                    curYear=tonumber(births[1]);
                    curMonth=tonumber(births[2]);
                    curDay=tonumber(births[3]);
                end
               
            end
            
        end
        maxYear = os.date("*t", LuaMgr.Timestamp()).year;
        this.ParseData();

    end,
    before_deactive = function(vm)
        this.Clear(this.vm.data.yearList);
        this.Clear(this.vm.data.monthList);
        this.Clear(this.vm.data.dayList);
     
    end,
}


this.Clear=function(list)
    for i,v in ipairs(list) do
        v.pos=Vector2(2.5,73-(i-1)*48);
        v.index=i;
        v.color=i==3 and colorWhite or colorGray;
        v.scale=i==3 and Vector3(1,1,1) or Vector3(0.8,0.8,0.8);
    end
end

this.ParseData=function()
    this.InitYear();
    this.InitMonth();
    this.InitDay();
end


this.InitYear=function()
    local value=curYear-2;
    for i=1,5,1 do
        if value>=minYear and value<=maxYear then
            this.vm.data.yearList[i].text=tostring(value);
        else
            this.vm.data.yearList[i].text="";
        end
        value=value+1;
    end
end


this.Year_OnDrag=function(eventData)
    local detaY=eventData.delta.y;
    if detaY>limitdetaY then
        detaY=limitdetaY
    elseif detaY<-limitdetaY then
        detaY=-limitdetaY;
    end
    local dragingY=detaY*dragSpeed;
    this.Year_DoMove(dragingY);
   
end

this.Year_OnEndDrag=function(eventData)
    this.AdsorbMove(this.vm.data.yearList,eventData.delta.y);
  
end


this.AdsorbMove=function(list,dir)
    for i,v in ipairs(list) do
        local tarPos=this.GetAbsorbPos(v);
        DOTWeen.To(function() return v.pos  end,
                function(vect) v.pos=vect end,
                Vector2(2.5,tarPos),0.2);
    end
end



this.GetAbsorbPos=function(item)
    local tmp=100;
    local tarPos=nil;
    for i,v in ipairs(absorbPos) do
       local distance=math.abs(item.pos.y-v);
        if distance<tmp then
            tmp=distance;
            tarPos=v;
        end
    end
    return tarPos;
end



this.Year_DoMove=function(dragingY)
    if dragingY>0  and curYear==maxYear then return end;
    if dragingY<0 and curYear==minYear then return end;
    for i,v in ipairs(this.vm.data.yearList) do
        v.pos=v.pos+Vector2(0,dragingY);
        if v.pos.y>=posLimit[1] then
            local offSetY=v.pos.y-posLimit[1];
            v.pos=Vector2(2.5,posLimit[2])+Vector2(0,offSetY);
            this.Year_SetInfo(v,dragingY);
        elseif v.pos.y<=posLimit[2] then
            local offSetY=v.pos.y-posLimit[2];
            v.pos=Vector2(2.5,posLimit[1])+Vector2(0,offSetY);
            this.Year_SetInfo(v,dragingY);
        end
    end
    
end

this.Year_SetInfo=function(year,dir)
    if dir<0 then
        curYear=curYear-1;
        curYear=curYear<minYear and maxYear or curYear;
        if curYear==minYear+1 then
            year.text="";
        else
            year.text=tostring(curYear-2<minYear and maxYear-minYear+curYear-1 or curYear-2);
        end

    else
        curYear=curYear+1;
        curYear=curYear>maxYear and minYear or curYear;
        if curYear==maxYear-1 then
            year.text="";
        else
            year.text=tostring(curYear+2>maxYear and curYear-maxYear+minYear+1 or curYear+2);
        end
    end
    this.UpdateIndex(this.vm.data.yearList,dir)
    this.InitDay();
end

this.UpdateIndex=function(list,dir)
    local index=nil;
    for i,v in ipairs(list) do
        if dir>0 then
            index=v.index-1
            v.index=index<1 and 5 or index;
        else
            index=v.index+1;
            v.index=index>5 and 1 or index;
        end
        v.scale=v.index==3 and Vector3(1,1,1) or Vector3(0.8,0.8,0.8);
        v.color=v.index==3 and colorWhite or colorGray;
    end
end







this.InitMonth=function()
    local value=curMonth-2;
    for i=1,5,1 do
        if value>=1 and value<=12 then
            this.vm.data.monthList[i].text=tostring(value);
        else
            this.vm.data.monthList[i].text="";
        end
        value=value+1;
    end
    
end

this.Month_OnDrag=function(eventData)
    local detaY=eventData.delta.y;
    if detaY>limitdetaY then
        detaY=limitdetaY
    elseif detaY<-limitdetaY then
        detaY=-limitdetaY;
    end
    local dragingY=detaY*dragSpeed;
    this.Month_DoMove(dragingY);
end

this.Month_OnEndDrag=function(eventData)
    this.AdsorbMove(this.vm.data.monthList,eventData.delta.y);
end


this.Month_DoMove=function(dragingY)
    if dragingY>0  and curMonth==12 then return end;
    if dragingY<0 and curMonth==1 then return end;
    for i,v in ipairs(this.vm.data.monthList) do
        v.pos=v.pos+Vector2(0,dragingY);
        if v.pos.y>=posLimit[1] then
            local offSetY=v.pos.y-posLimit[1];
            v.pos=Vector2(2.5,posLimit[2])+Vector2(0,offSetY);
            this.Month_SetInfo(v,dragingY);
        elseif v.pos.y<=posLimit[2] then
            local offSetY=v.pos.y-posLimit[2];
            v.pos=Vector2(2.5,posLimit[1])+Vector2(0,offSetY);
            this.Month_SetInfo(v,dragingY);
        end
    end
end 

this.Month_SetInfo=function(month,dir)
    if dir<0 then
        curMonth=curMonth-1;
        curMonth=curMonth<1 and 12 or curMonth;
        if curMonth==2 then
            month.text="";
        else
            month.text=tostring(curMonth<3 and curMonth+10 or curMonth-2);
        end

    else
        curMonth=curMonth+1;
        curMonth=curMonth>12 and 1 or curMonth;
        if curMonth==11 then
            month.text="";
        else
            month.text=tostring(curMonth>10 and curMonth-10 or curMonth+2);
        end

        
    end
    this.UpdateIndex(this.vm.data.monthList,dir)
    this.InitDay();
end







this.CalculateRuiYear=function()
    return curYear%4==0 or curYear%400==0;
end


this.CalculateDay=function()
    if curMonth==2 then
        local isRui=this.CalculateRuiYear();
        return isRui and 29 or 28;
    elseif curMonth==1 or curMonth==3 or curMonth==5 or curMonth==7
            or curMonth==8 or curMonth==10 or curMonth==12 then
        return 31;
    else
        return 30;
    end
end


this.InitDay=function()
    this.Clear(this.vm.data.dayList);
    minDay=1;
    maxDay=this.CalculateDay();
    if curDay~=nil and curDay>maxDay then
        curDay=maxDay;
    end
    local value=curDay-2;
    
    for i=1,5,1 do
        if value>=1 and value<=maxDay then
            this.vm.data.dayList[i].text=tostring(value);
        else
            this.vm.data.dayList[i].text="";
        end
        value=value+1;
    end
    
end

this.Day_OnDrag=function(eventData)
    local detaY=eventData.delta.y;
    if detaY>limitdetaY then
        detaY=limitdetaY
    elseif detaY<-limitdetaY then
        detaY=-limitdetaY;
    end
    local dragingY=detaY*dragSpeed;
    this.Day_DoMove(dragingY);
end

this.Day_OnEndDrag=function(eventData)
    this.AdsorbMove(this.vm.data.dayList,eventData.delta.y);
end


this.Day_DoMove=function(dragingY)
    if dragingY>0  and curDay==maxDay then return end;
    if dragingY<0 and curDay==1 then return end;
    for i,v in ipairs(this.vm.data.dayList) do
        v.pos=v.pos+Vector2(0,dragingY);
        if v.pos.y>=posLimit[1] then
            local offSetY=v.pos.y-posLimit[1];
            v.pos=Vector2(2.5,posLimit[2])+Vector2(0,offSetY);
            this.Day_SetInfo(v,dragingY);
        elseif v.pos.y<=posLimit[2] then
            local offSetY=v.pos.y-posLimit[2];
            v.pos=Vector2(2.5,posLimit[1])+Vector2(0,offSetY);
            this.Day_SetInfo(v,dragingY);
        end
    end
end

this.Day_SetInfo=function(day,dir)
    if dir<0 then
        curDay=curDay-1;
        curDay=curDay<1 and maxDay or curDay;
        if curDay==2 then
            day.text="";
        else
            day.text=tostring(curDay<3 and curDay+(maxDay-2) or curDay-2);
        end

    else
        curDay=curDay+1;
        curDay=curDay>maxDay and 1 or curDay;
        if curDay==maxDay-1 then
            day.text="";
        else
            day.text=tostring(curDay>maxDay-2 and curDay-(maxDay-2) or curDay+2);
        end
    end
    this.UpdateIndex(this.vm.data.dayList,dir)
end



return vm({
    data = data,
    command = command,
    hook = hook
})