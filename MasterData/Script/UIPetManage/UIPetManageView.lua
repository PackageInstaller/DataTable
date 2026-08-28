local PetManage = {
  self = nil,
  Img_Bg = nil,
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = nil,
    Btn_Home = nil,
    Btn_Menu = nil,
    Btn_Help = {
      self = nil,
      Img_Tips = {
        self = nil,
        Img_icon = nil,
        Txt_ = nil
      }
    }
  },
  Group_PetHouses = {
    self = nil,
    ScrollGrid_PetHouses = {
      self = nil,
      grid = {
        self = nil,
        Img_Bg = nil,
        Group_HouseNo = {
          self = nil,
          Img_Bg = nil,
          Txt_No = nil,
          Txt_ = nil
        },
        Img_HouseIcon = nil,
        Group_HouseFood = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Group_HouseName = {
          self = nil,
          Img_HouseName = {self = nil, Txt_HouseName = nil}
        },
        StaticGrid_Rooms = {
          self = nil,
          grid = {
            self = nil,
            Img_Bg = nil,
            Group_Locked = {
              self = nil,
              Img_Locked = nil,
              Txt_Locked = nil
            },
            Group_CheckIn = {
              self = nil,
              Btn_CheckIn = {
                self = nil,
                Txt_CheckIn = nil,
                Img_CheckIn = nil
              }
            },
            Group_Pet = {
              self = nil,
              Img_ = nil,
              Img_Pet = nil,
              Group_Name = {self = nil, Txt_Name = nil},
              Group_Love = {
                self = nil,
                Img_Heart = nil,
                Txt_LoveLevel = nil
              },
              Group_State = {
                self = nil,
                Group_Bad = {self = nil, Img_Bad = nil},
                Group_Good = {
                  self = nil,
                  Btn_ = nil,
                  Img_Good = nil
                }
              },
              Btn_ = nil
            }
          }
        },
        Group_Place = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Btn_Go = {self = nil, Txt_ = nil}
      }
    },
    Group_PetNum = {
      self = nil,
      Img_Bg = nil,
      Img_ = nil,
      Txt_Num = nil
    }
  },
  Group_Pets = {
    self = nil,
    ScrollGrid_PetList = {
      self = nil,
      grid = {
        self = nil,
        Img_Bg = nil,
        Img_Path = nil,
        Img_Pet = nil,
        Group_Name = {self = nil, Txt_Name = nil},
        Group_OtherHouse = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Group_Love = {
          self = nil,
          Img_Love = nil,
          Txt_Love = nil,
          Txt_Lv = nil
        },
        Group_Selected = {
          self = nil,
          Group_Num = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Group_Fx_NowSelect = {self = nil, Img_ = nil}
        },
        Btn_PetUnit = nil
      }
    },
    Group_TopRight = {
      self = nil,
      Btn_Love = {
        self = nil,
        Img_Normal = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_Select = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Btn_Time = {
        self = nil,
        Img_Normal = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_Select = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Btn_Screen = {
        self = nil,
        Img_Normal = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_Select = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      }
    }
  },
  Btn_PetHouses = {
    self = nil,
    Img_Selected = {self = nil, Txt_ = nil},
    Img_UnSelected = {self = nil, Txt_ = nil}
  },
  Btn_Pets = {
    self = nil,
    Img_Selected = {self = nil, Txt_ = nil},
    Img_UnSelected = {self = nil, Txt_ = nil}
  },
  Img_Selected = {self = nil, Txt_ = nil},
  Btn_foodFeed = {self = nil, Txt_ = nil},
  Screen_Filter = {
    self = nil,
    Btn_BG = {self = nil, Img_ = nil},
    Img_Mask = {self = nil, Img_B = nil},
    Txt_ = nil,
    ScrollGrid_PetVarity = {
      self = nil,
      grid = {
        self = nil,
        Btn_Varity = {
          self = nil,
          Txt_ = nil,
          Img_Select = nil
        }
      }
    },
    Btn_OK = {
      self = nil,
      Img_Icon = nil,
      Txt_T = nil
    },
    Btn_Cancel = {
      self = nil,
      Img_Icon = nil,
      Txt_T = nil
    }
  },
  Group_foodFeed = {
    self = nil,
    Btn_BG = {self = nil, Img_ = nil},
    Group_Window = {
      self = nil,
      Img_WindowBg = nil,
      Img_ = nil,
      Img_Head = {self = nil, Txt_ = nil},
      Group_down = {
        self = nil,
        Img_BG = nil,
        Txt_ = nil,
        ScrollGrid_ = {
          self = nil,
          grid = {
            self = nil,
            Img_NowFood = nil,
            Img_Item = nil,
            Txt_Num = nil,
            Btn_ = nil
          }
        },
        Img_addFoodBg = nil,
        Img_addFood = nil,
        Txt_ = nil,
        Btn_addFood = nil
      },
      ScrollGrid_bar = {
        self = nil,
        grid = {
          self = nil,
          Img_NowFood = nil,
          Img_Item = nil,
          Img_change = nil,
          Btn_change = nil,
          Txt_ = nil,
          Txt_PetFood = nil,
          Txt_address = {
            self = nil,
            Img_ = nil,
            Img_NoBg = nil,
            Txt_No = nil
          },
          Img_addFoodBg = nil,
          Img_addFood = {self = nil, Txt_ = nil},
          Btn_addFood = nil,
          Img_TroughBg = nil,
          Img_ResideFood = nil,
          Group_changeOn = {
            self = nil,
            Btn_BG = {self = nil, Img_ = nil},
            Img_changeBg = {
              self = nil,
              ScrollGrid_foodList = {
                self = nil,
                grid = {
                  self = nil,
                  Img_NowFood = nil,
                  Img_Item = nil,
                  Btn_ = nil
                }
              }
            }
          }
        }
      }
    },
    Group_Tips = {
      self = nil,
      Img_Tips = nil,
      Txt_Tips = nil
    }
  }
}
return PetManage
