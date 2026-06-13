local empty = {}
return
{
  Row = 0,
  Column = 0,
  MapID = 110110,
  RoomCount = 0,
  Desc = "地图描述",
  RoomDic = {
    [ 32 ] = {
      WindowPos = { 0.046875, 0.0833333358 },
      RoomNum = 32,
      uuid = 0,
      StartDir = 0,
      EndDir = 2,
      RoomType = 12,
      RowNum = 2,
      ColumnNum = 2,
      LogicNum = 0,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 33,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 33 ] = {
      WindowPos = { 0.09375, 0.0833333358 },
      RoomNum = 33,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 2,
      RowNum = 2,
      ColumnNum = 3,
      LogicNum = 0,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 34,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 38,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 32,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 34 ] = {
      WindowPos = { 0.140625, 0.0833333358 },
      RoomNum = 34,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 13,
      RowNum = 2,
      ColumnNum = 4,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 33,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 35,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 39,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 35 ] = {
      WindowPos = { 0.1875, 0.0833333358 },
      RoomNum = 35,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 11,
      RowNum = 2,
      ColumnNum = 5,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 34,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 38 ] = {
      WindowPos = { 0.09375, 0.166666672 },
      RoomNum = 38,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 2,
      RowNum = 3,
      ColumnNum = 3,
      LogicNum = 0,
      RoomConnectDic = {
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 33,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 43,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 39,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 39 ] = {
      WindowPos = { 0.140625, 0.166666672 },
      RoomNum = 39,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 2,
      RowNum = 3,
      ColumnNum = 4,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 38,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 34,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 3 ] = {
          SrcDir = 3,
          TargetDir = 1,
          TargetRoomNum = 44,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 42 ] = {
      WindowPos = { 0.046875, 0.25 },
      RoomNum = 42,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 13,
      RowNum = 4,
      ColumnNum = 2,
      LogicNum = 0,
      RoomConnectDic = {
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 43,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 43 ] = {
      WindowPos = { 0.09375, 0.25 },
      RoomNum = 43,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 3,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 42,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 44,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 38,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 44 ] = {
      WindowPos = { 0.140625, 0.25 },
      RoomNum = 44,
      uuid = 0,
      StartDir = 3,
      EndDir = 0,
      RoomType = 1,
      RowNum = 4,
      ColumnNum = 4,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 43,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 4 ] = {
          SrcDir = 4,
          TargetDir = 2,
          TargetRoomNum = 45,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        },
        [ 1 ] = {
          SrcDir = 1,
          TargetDir = 3,
          TargetRoomNum = 39,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    },
    [ 45 ] = {
      WindowPos = { 0.1875, 0.25 },
      RoomNum = 45,
      uuid = 0,
      StartDir = 0,
      EndDir = 0,
      RoomType = 2,
      RowNum = 4,
      ColumnNum = 5,
      LogicNum = 0,
      RoomConnectDic = {
        [ 2 ] = {
          SrcDir = 2,
          TargetDir = 4,
          TargetRoomNum = 44,
          IsLocked = false,
          UnlockCondition = empty,
          UnlockDesc = ""
        }
      }
    }
  }
}