local EndlessBattle = {
  self = nil,
  Img_Bg = nil,
  Img_Mask = nil,
  Group_BossInfo = {
    self = nil,
    Group_Hp = {
      self = nil,
      Img_Bg = nil,
      Img_Bar = nil,
      Txt_Num = nil
    },
    Img_D = {self = nil, Txt_ = nil},
    Txt_D = nil,
    Spine_Role = nil,
    Group_Name = {
      self = nil,
      Txt_Name = nil,
      Btn_Detail = nil
    }
  },
  Group_Preview = {
    self = nil,
    Img_Bg = nil,
    Img_Icon = nil,
    Txt_T = nil,
    ScrollGrid_Reward = {
      self = nil,
      grid = {
        self = nil,
        Group_Item = {
          self = nil,
          Btn_Item = nil,
          Img_Bottom = nil,
          Img_Item = nil,
          Img_Mask = nil,
          Group_Break = {
            self = nil,
            Img_Mask = {self = nil, Img_Face = nil},
            Img_F = nil
          },
          Txt_Num = nil,
          Img_Type01 = nil,
          Img_Type02 = nil,
          Img_Time = {self = nil, Txt_ = nil},
          Group_EType = {
            self = nil,
            Img_IconBg = nil,
            Img_Icon = nil
          },
          Img_TimeLeft = {
            self = nil,
            Img_ = nil,
            Txt_ = nil
          },
          Group_Extra = {
            self = nil,
            Img_bg = {self = nil, Txt_txt = nil}
          },
          Group_Effect = nil
        }
      }
    }
  },
  Group_TeamGroup = {
    self = nil,
    Group_Team = {
      self = nil,
      Img_Bg = nil,
      Txt_Team = nil,
      Txt_Index = nil,
      StaticGrid_Role = {
        self = nil,
        grid = {
          self = nil,
          Img_Bg = nil,
          Img_Head = nil,
          Txt_Lv = nil,
          Btn_Click = nil,
          Img_Mask = nil,
          Img_Captain = {self = nil, Img_Icon = nil}
        }
      },
      Btn_Auto = {
        self = nil,
        Img_Icon = nil,
        Txt_ = nil
      },
      Btn_Edit = {
        self = nil,
        Img_Icon = nil,
        Txt_T = nil
      },
      Group_Lose = {
        self = nil,
        Img_Mask = nil,
        Img_Icon = nil,
        Txt_T = nil,
        Txt_E = nil
      },
      Group_Selected = {
        self = nil,
        Txt_T = nil,
        Img_Bg = nil,
        Group_Effect = {
          self = nil,
          UI_EndlessBattle_teamEdit_01 = {self = nil, bian = nil},
          UI_EndlessBattle_teamEdit_02 = {
            self = nil,
            jiantou1_1 = nil,
            jiantou1_2 = nil,
            jiantou1_3 = nil,
            jiantou2_1 = nil,
            jiantou2_2 = nil,
            jiantou2_3 = nil
          }
        }
      },
      Group_Role = {
        self = nil,
        Img_Bg = nil,
        Img_Head = nil,
        Txt_Lv = nil,
        Btn_Click = nil,
        Img_Mask = nil,
        Img_Captain = {self = nil, Img_Icon = nil}
      }
    },
    StaticGrid_Team = {
      self = nil,
      grid = {
        self = nil,
        Img_Bg = nil,
        Txt_Team = nil,
        Txt_Index = nil,
        StaticGrid_Role = {
          self = nil,
          grid = {
            self = nil,
            Img_Bg = nil,
            Img_Head = nil,
            Txt_Lv = nil,
            Btn_Click = nil,
            Img_Mask = nil,
            Img_Captain = {self = nil, Img_Icon = nil}
          }
        },
        Btn_Auto = {
          self = nil,
          Img_Icon = nil,
          Txt_ = nil
        },
        Btn_Edit = {
          self = nil,
          Img_Icon = nil,
          Txt_T = nil
        },
        Group_Lose = {
          self = nil,
          Img_Mask = nil,
          Img_Icon = nil,
          Txt_T = nil,
          Txt_E = nil
        },
        Group_Selected = {
          self = nil,
          Txt_T = nil,
          Img_Bg = nil,
          Group_Effect = {
            self = nil,
            UI_EndlessBattle_teamEdit_01 = {self = nil, bian = nil},
            UI_EndlessBattle_teamEdit_02 = {
              self = nil,
              jiantou1_1 = nil,
              jiantou1_2 = nil,
              jiantou1_3 = nil,
              jiantou2_1 = nil,
              jiantou2_2 = nil,
              jiantou2_3 = nil
            }
          }
        },
        Group_Role = {
          self = nil,
          Img_Bg = nil,
          Img_Head = nil,
          Txt_Lv = nil,
          Btn_Click = nil,
          Img_Mask = nil,
          Img_Captain = {self = nil, Img_Icon = nil}
        }
      }
    }
  },
  Group_Select = {
    self = nil,
    Img_Bg = {
      self = nil,
      Img_Icon = nil,
      Img_Icon2 = nil,
      Txt_T = nil
    },
    Group_Check = {
      self = nil,
      Img_Bg = nil,
      Btn_Role = {
        self = nil,
        Group_On = {
          self = nil,
          Img_Bg = nil,
          Txt_T = nil
        },
        Group_Off = {self = nil, Txt_T = nil}
      },
      Btn_Team = {
        self = nil,
        Group_On = {
          self = nil,
          Img_Bg = nil,
          Txt_T = nil
        },
        Group_Off = {self = nil, Txt_T = nil}
      }
    },
    Group_RoleList = {
      self = nil,
      ScrollGrid_RoleList = {
        self = nil,
        grid = {
          self = nil,
          Group_Bg = {
            self = nil,
            Img_0 = nil,
            Img_1 = nil,
            Img_2 = nil
          },
          Img_Head = nil,
          Img_Mask = nil,
          Img_Lv = nil,
          Txt_Lv = nil,
          Group_InTeam = {
            self = nil,
            Img_Team = nil,
            Txt_Team = nil
          },
          Btn_Click = nil,
          Txt_Name = nil,
          Img_Defeat = nil
        }
      },
      Img_BtnBg = nil,
      Btn_Level = {
        self = nil,
        Img_DeP = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_DeN = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_AP = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_AN = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Btn_Rarity = {
        self = nil,
        Img_DeP = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_DeN = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_AP = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_AN = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Btn_Time = {
        self = nil,
        Img_DeP = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_DeN = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_AP = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_AN = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      },
      Btn_Screen = {
        self = nil,
        Img_N = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        },
        Img_P = {
          self = nil,
          Img_ = nil,
          Txt_ = nil
        }
      }
    },
    Group_TeamList = {
      self = nil,
      ScrollGrid_TeamList = {
        self = nil,
        grid = {
          self = nil,
          Img_Bg = nil,
          Txt_Name = nil,
          StaticGrid_Role = {
            self = nil,
            grid = {
              self = nil,
              Img_Mask = {self = nil, Img_Head = nil},
              Img_Circle = nil,
              Group_InTeam = {self = nil, Txt_Team = nil},
              Txt_Lv = nil,
              Img_Defeat = nil
            }
          },
          Btn_Click = {
            self = nil,
            Img_Bg = nil,
            Txt_ = nil
          },
          Group_Item = {
            self = nil,
            Img_Mask = {self = nil, Img_Head = nil},
            Img_Circle = nil,
            Group_InTeam = {self = nil, Txt_Team = nil},
            Txt_Lv = nil,
            Img_Defeat = nil
          }
        }
      }
    },
    Group_Team = {
      self = nil,
      Img_Bg = nil,
      Txt_Name = nil,
      StaticGrid_Role = {
        self = nil,
        grid = {
          self = nil,
          Img_Mask = {self = nil, Img_Head = nil},
          Img_Circle = nil,
          Group_InTeam = {self = nil, Txt_Team = nil},
          Txt_Lv = nil,
          Img_Defeat = nil
        }
      },
      Btn_Click = {
        self = nil,
        Img_Bg = nil,
        Txt_ = nil
      },
      Group_Item = {
        self = nil,
        Img_Mask = {self = nil, Img_Head = nil},
        Img_Circle = nil,
        Group_InTeam = {self = nil, Txt_Team = nil},
        Txt_Lv = nil,
        Img_Defeat = nil
      }
    },
    Group_Item = {
      self = nil,
      Group_Bg = {
        self = nil,
        Img_0 = nil,
        Img_1 = nil,
        Img_2 = nil
      },
      Img_Head = nil,
      Img_Mask = nil,
      Img_Lv = nil,
      Txt_Lv = nil,
      Group_InTeam = {
        self = nil,
        Img_Team = nil,
        Txt_Team = nil
      },
      Btn_Click = nil,
      Txt_Name = nil,
      Img_Defeat = nil
    },
    Btn_Back = nil
  },
  Group_PowerRole = {
    self = nil,
    Group_Item = {
      self = nil,
      Img_Mask = {self = nil, Img_Head = nil},
      Img_Circle = nil,
      Img_Un = {self = nil, Txt_ = nil},
      Btn_Role = nil
    },
    StaticGrid_RoleList = {
      self = nil,
      grid = {
        self = nil,
        Img_Mask = {self = nil, Img_Head = nil},
        Img_Circle = nil,
        Img_Un = {self = nil, Txt_ = nil},
        Btn_Role = nil
      }
    },
    Txt_T = nil,
    Btn_Help = nil,
    Group_Help = {
      self = nil,
      Img_B = nil,
      Txt_D = nil
    }
  },
  Btn_Start = {
    self = nil,
    Img_Bg = nil,
    Txt_ = nil,
    Group_Effect = {
      self = nil,
      UI_EndlessBattle_btnBattle = {
        self = nil,
        lizi1 = nil,
        lizi2 = nil,
        zhandou_jian = nil,
        huo2 = nil,
        zhandou_zi = nil
      }
    }
  },
  Btn_Revive = {
    self = nil,
    Img_Bg = nil,
    Txt_T = nil,
    Txt_Num = nil,
    Group_Effect = {
      self = nil,
      UI_EndlessBattle_btnRevive = {
        self = nil,
        lizi1 = nil,
        lizi2 = nil,
        zhandou_chongzhi = nil,
        huo2 = nil,
        zhandou_zi = nil
      }
    }
  },
  Group_Revive = {
    self = nil,
    Btn_BG = {self = nil, Img_ = nil},
    Img_Btm = {self = nil, Img_B = nil},
    Group_Middle = {
      self = nil,
      Img_bg = nil,
      Img_Icon = nil,
      Txt_Des = nil,
      Txt_T = nil,
      Txt_Count = nil
    },
    Btn_Confirm = {
      self = nil,
      Group_ = {
        self = nil,
        Img_Icon = nil,
        Txt_Confirm = nil
      }
    },
    Btn_Cancel = {
      self = nil,
      Group_ = {
        self = nil,
        Img_Icon = nil,
        Txt_Cancel = nil
      }
    },
    Group_Text = {
      self = nil,
      Txt_Des = nil,
      Img_PriceIcon = nil,
      Txt_Price = nil,
      Txt_Des2 = nil,
      Img_ItemIcon = nil,
      Txt_ItemNum = nil,
      Txt_Des3 = nil
    },
    Group_Tips = {
      self = nil,
      Img_Tips = nil,
      Txt_Tips = nil
    }
  },
  Group_Finish = {
    self = nil,
    Img_Mask = nil,
    Img_Bg = nil,
    Img_Icon = nil,
    Img_Line1 = nil,
    Img_Text = nil,
    Spine_Role = nil,
    Txt_Name = nil,
    Txt_D = nil
  },
  Group_Upgrade = {
    self = nil,
    Img_B = nil,
    Spine_Upgrade = nil,
    Txt_LevelPre = nil,
    Txt_Level = nil,
    Txt_L = nil,
    Txt_Title = nil,
    UI_EndlessBattleUpgrade = {
      self = nil,
      Particle_Add_2 = nil,
      Particle_Add_3 = nil,
      Glow_Add = nil,
      Glow_Add2 = nil,
      Glow_Alp = nil,
      Line_Add = nil,
      Flare = nil,
      Star_Bus = nil,
      Particle_Add_2 = nil
    }
  },
  Group_CommonTopLeft = {
    self = nil,
    Btn_Return = {self = nil, Img_Bg = nil},
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
  Screen_Chapter = {
    self = nil,
    Img_Mask = {self = nil, Img_B = nil},
    Btn_BG = {self = nil, Img_ = nil},
    Group_Career = {
      self = nil,
      Txt_ = nil,
      Btn_All = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C01 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C02 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C03 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C04 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C05 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C06 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C07 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C08 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_C09 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      }
    },
    Group_Group = {
      self = nil,
      Txt_ = nil,
      Btn_All = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G01 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G02 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G03 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G04 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G05 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G06 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G07 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G08 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_G09 = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      }
    },
    Group_Rarity = {
      self = nil,
      Txt_ = nil,
      Btn_All = {
        self = nil,
        Txt_ = nil,
        Img_Select = nil
      },
      Btn_R01 = {
        self = nil,
        Txt_ = nil,
        Img_ = nil,
        Img_Select = nil
      },
      Btn_R02 = {
        self = nil,
        Txt_ = nil,
        Img_ = nil,
        Img_Select = nil
      },
      Btn_R03 = {
        self = nil,
        Txt_ = nil,
        Img_ = nil,
        Img_Select = nil
      },
      Btn_R04 = {
        self = nil,
        Txt_ = nil,
        Img_ = nil,
        Img_Select = nil
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
    },
    Group_Tips = {
      self = nil,
      Img_Tips = nil,
      Txt_Tips = nil
    }
  },
  Group_DupesEquip = {
    self = nil,
    Img_Glass_Full = nil,
    Btn_Blose = nil,
    Img_Glass = nil,
    Img_Bg = nil,
    Group_Main = {
      self = nil,
      Group_Equipt = {
        self = nil,
        Group_Equipment = {
          self = nil,
          Img_UR = nil,
          Img_Item = nil,
          Img_HeadBack = {self = nil, Img_Head = nil},
          Group_Name = {
            self = nil,
            Txt_Name = nil,
            Txt_Lv = nil,
            Txt_LvNum = nil
          },
          Group_Attr = {
            self = nil,
            Img_AttrPic = nil,
            Txt_Attt = nil
          }
        },
        ScrollView_Content = {
          self = nil,
          Viewport = {
            self = nil,
            Content = {
              self = nil,
              Group_Entry_1 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              },
              Group_Entry_2 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              },
              Group_Entry_3 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              },
              Group_Entry_4 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              },
              Group_Entry_5 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              },
              Group_Entry_6 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              },
              Group_Entry_7 = {
                self = nil,
                Group_Diamond = {self = nil, Img_Diamond = nil},
                Txt_Entry_1 = nil
              }
            }
          }
        },
        Btn_Change = {self = nil, Txt_Change = nil}
      },
      Group_Slots = {
        self = nil,
        Group_Slots_01 = {
          self = nil,
          Btn_Slots = {self = nil, Img_Slots = nil},
          Group_Active = {self = nil, Img_Slots = nil}
        },
        Group_Slots_02 = {
          self = nil,
          Btn_Slots = {self = nil, Img_Slots = nil},
          Group_Active = {self = nil, Img_Slots = nil}
        },
        Group_Slots_03 = {
          self = nil,
          Btn_Slots = {self = nil, Img_Slots = nil},
          Group_Active = {self = nil, Img_Slots = nil}
        }
      },
      Group_Characters = {
        self = nil,
        Group_Character_001 = {
          self = nil,
          Group_Disable = {
            self = nil,
            Img_Disable = nil,
            Txt_Disable = nil
          },
          Btn_Enable_001 = {
            self = nil,
            Img_Active = nil,
            Txt_Active = nil
          },
          Img_Face = nil,
          Img_Empty = nil
        },
        Group_Character_002 = {
          self = nil,
          Group_Disable = {
            self = nil,
            Img_Disable = nil,
            Txt_Disable = nil
          },
          Btn_Enable_001 = {
            self = nil,
            Img_Active = nil,
            Txt_Active = nil
          },
          Img_Face = nil,
          Img_Empty = nil
        },
        Group_Character_003 = {
          self = nil,
          Group_Disable = {
            self = nil,
            Img_Disable = nil,
            Txt_Disable = nil
          },
          Btn_Enable_001 = {
            self = nil,
            Img_Active = nil,
            Txt_Active = nil
          },
          Img_Face = nil,
          Img_Empty = nil
        },
        Group_Character_004 = {
          self = nil,
          Group_Disable = {
            self = nil,
            Img_Disable = nil,
            Txt_Disable = nil
          },
          Btn_Enable_001 = {
            self = nil,
            Img_Active = nil,
            Txt_Active = nil
          },
          Img_Face = nil,
          Img_Empty = nil
        },
        Group_Character_005 = {
          self = nil,
          Group_Disable = {
            self = nil,
            Img_Disable = nil,
            Txt_Disable = nil
          },
          Btn_Enable_001 = {
            self = nil,
            Img_Active = nil,
            Txt_Active = nil
          },
          Img_Face = nil,
          Img_Empty = nil
        }
      },
      Group_Tips = {
        self = nil,
        Img_TipsIcon = nil,
        Txt_Tips = nil
      }
    }
  }
}
return EndlessBattle
