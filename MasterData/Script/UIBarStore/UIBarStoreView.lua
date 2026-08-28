local BarStore = {
  self = nil,
  Img_Backgroud = nil,
  Img_BGMask = nil,
  Group_NPC = {
    self = nil,
    Img_Role = nil,
    SpineAnimation_Character = nil,
    SpineAnimation_Alpha = nil,
    Img_Dialog = {self = nil, Txt_Talk = nil},
    Img_Name = {self = nil, Txt_Name = nil}
  },
  Img_NPCMask = nil,
  Group_Main = {
    self = nil,
    Btn_Talk = {
      self = nil,
      Txt_ = nil,
      Img_ = nil,
      Img_RedPoint = {
        self = nil,
        Group_Track_Q = {
          self = nil,
          Img_ = nil,
          UI_guideTip_01 = {
            self = nil,
            ring = nil,
            ring2 = nil,
            glow = nil,
            lizi = nil,
            glow2 = nil
          }
        }
      }
    },
    Btn_Drink = {
      self = nil,
      Txt_ = nil,
      Img_ = nil
    },
    Btn_Store = {
      self = nil,
      Txt_ = nil,
      Img_ = nil,
      Img_RedPoint = nil
    },
    Group_NpcInfo = {
      self = nil,
      Group_Dingwei = {
        self = nil,
        Img_ = nil,
        Txt_Station = nil
      },
      Img_ = nil,
      Txt_ = nil,
      Img_1 = nil,
      Group_1 = {
        self = nil,
        Btn_Tips = nil,
        Txt_1 = nil
      },
      Group_Tips1 = {
        self = nil,
        Btn_Close = nil,
        Img_Btm = nil,
        Txt_Tips1 = nil
      }
    },
    Group_Drink = {
      self = nil,
      Group_Energy = {
        self = nil,
        Img_Icon = nil,
        Txt_1 = nil,
        Txt_Num = nil,
        Img_PBBG = nil,
        Img_PB = nil,
        Btn_Energy = nil
      },
      StaticGrid_Drink = {
        self = nil,
        grid = {
          self = nil,
          Img_BG = nil,
          Img_1 = nil,
          Txt_Name = nil,
          Img_ = nil,
          Img_Item = nil,
          Txt_Cost = nil,
          Btn_Click = nil,
          Txt_Free = nil
        }
      }
    }
  },
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
  Group_TishiWindow = {
    self = nil,
    Btn_Close = nil,
    Img_Mask = {
      self = nil,
      Img_PromptBG2 = nil,
      Img_PromptBG = nil,
      Img_Mask = nil,
      Img_2 = nil
    },
    Group_1 = {
      self = nil,
      Txt_Dec = nil,
      Txt_Time = nil,
      Img_ = nil
    },
    Txt_Tips = nil,
    Txt_1 = nil,
    Img_ = nil,
    Txt_NoReminded = {
      self = nil,
      Btn_Check = {
        self = nil,
        Txt_Check = {self = nil, Img_ = nil}
      }
    },
    Btn_Confirm = {
      self = nil,
      Img_Icon = nil,
      Txt_Confirm = nil
    },
    Btn_Cancel = {
      self = nil,
      Img_Icon = nil,
      Txt_Cancel = nil
    }
  },
  Group_Buff = {
    self = nil,
    Btn_Close = nil,
    Img_BG1 = nil,
    Img_BG = nil,
    Txt_1 = nil,
    Group_1 = {
      self = nil,
      Txt_Dec = nil,
      Txt_Time = nil
    },
    Group_Huifu = {
      self = nil,
      Txt_Pilao = nil,
      Txt_Man = nil
    }
  },
  Group_LocalStore = {
    self = nil,
    Group_StoreList = {
      self = nil,
      Img_ = nil,
      Img_BG = nil,
      Img_ = nil,
      Img_Icon = nil,
      Txt_ = nil,
      ScrollGrid_Commodity = {
        self = nil,
        grid = {
          self = nil,
          Group_Item = {
            self = nil,
            Btn_Item = {
              self = nil,
              Txt_ItemName = nil,
              Img_ItemRole = {self = nil, Img_Item = nil},
              Img_ItemBG = {
                self = nil,
                Img_Item = nil,
                Group_EType = {
                  self = nil,
                  Img_IconBg = nil,
                  Img_Icon = nil
                },
                Img_Residue = nil,
                Img_ResidueNum = {self = nil, Txt_ResidueNum = nil},
                Txt_Num = nil,
                Img_ = nil
              },
              Group_Money = {
                self = nil,
                Img_Money = nil,
                Txt_MoneyNum = nil
              },
              Img_Mask = nil,
              Img_special = nil,
              Group_Discount = {
                self = nil,
                Img_ = nil,
                Txt_Discount = nil
              },
              Img_Sold = {
                self = nil,
                Img_ = nil,
                Txt_ = nil,
                Txt_ = nil
              },
              Img_Limit = {
                self = nil,
                Img_ = nil,
                Group_1 = {
                  self = nil,
                  Txt_Rep = nil,
                  Txt_Grade = nil
                }
              },
              Group_Time = {
                self = nil,
                Img_ = nil,
                Txt_Time = nil
              },
              Img_RedPoint = nil
            }
          },
          Group_Select = {
            self = nil,
            Img_ = nil,
            Img_ = nil,
            Txt_ = nil
          }
        }
      },
      Btn_PL = {
        self = nil,
        Group_On = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Group_Off = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Group_Tab = {
        self = nil,
        Img_ = nil,
        Group_Headquarters = {
          self = nil,
          Group_Off = {
            self = nil,
            Img_Select = nil,
            Txt_Name = nil
          },
          Group_On = {
            self = nil,
            Img_1 = {
              self = nil,
              Txt_Name = nil,
              Img_Select = nil
            }
          },
          Img_RedPoint = nil,
          Btn_ = nil
        },
        Group_Local = {
          self = nil,
          Group_Off = {
            self = nil,
            Img_Select = nil,
            Txt_Name = nil
          },
          Group_On = {
            self = nil,
            Img_1 = {
              self = nil,
              Img_Select = nil,
              Txt_Name = nil
            }
          },
          Btn_ = nil
        }
      },
      Group_Time = {
        self = nil,
        Img_BG = nil,
        Txt_Time = nil,
        Img_ = nil
      },
      Group_PL = {
        self = nil,
        Img_ = nil,
        Txt_ = nil,
        Group_Money = {
          self = nil,
          Img_ = nil,
          Txt_Num = nil
        },
        Group_SelectAll = {
          self = nil,
          Group_Off = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Group_On = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Btn_ = nil
        },
        Btn_Buy = {self = nil, Txt_ = nil}
      },
      Btn_ShuaXin = {self = nil, Txt_ = nil}
    },
    Group_Ding = {
      self = nil,
      StaticGrid_Coin = {
        self = nil,
        grid = {
          self = nil,
          Img_BG = nil,
          Btn_GoldCoin = nil,
          Img_Icon = nil,
          Group_Num = {
            self = nil,
            Txt_Num = nil,
            Btn_Add = nil
          }
        }
      }
    },
    Group_NpcInfo = {
      self = nil,
      Group_Dingwei = {
        self = nil,
        Img_ = nil,
        Txt_Station = nil
      },
      Img_ = nil,
      Txt_ = nil,
      Img_1 = nil
    },
    Group_Reputation = {
      self = nil,
      Btn_Reputation = {self = nil, Img_Click = nil},
      Txt_Grade = nil,
      Txt_Num = nil,
      Img_PBBG = nil,
      Img_PB = nil,
      Img_RedPoint = nil
    }
  },
  Img_IpadTop = nil,
  Img_IpadBtm = nil,
  Video_Drink = nil,
  Group_Skip = {
    self = nil,
    Btn_BG = nil,
    Img_Mask = {
      self = nil,
      Img_PromptBG2 = nil,
      Img_PromptBG = nil
    },
    Btn_Confirm = {
      self = nil,
      Img_Icon = nil,
      Txt_Confirm = nil
    },
    Btn_Cancel = {
      self = nil,
      Img_Icon = nil,
      Txt_Cancel = nil
    },
    Txt_Prompt = nil,
    Group_Tip = {
      self = nil,
      Btn_Tip = {
        self = nil,
        Group_Off = {self = nil, Img_ = nil},
        Group_On = {self = nil, Img_ = nil}
      },
      Txt_Tip = nil
    }
  },
  Btn_Skip = {
    self = nil,
    Img_ = nil,
    Txt = nil
  }
}
return BarStore
