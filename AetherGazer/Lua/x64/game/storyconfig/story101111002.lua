return {
	Play111102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 111102001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play111102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "D06b"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.D06b

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "D06b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = arg_1_1.bgs_.D06b
			local var_4_17 = 0

			if var_4_17 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				local var_4_18 = var_4_16:GetComponent("SpriteRenderer")

				if var_4_18 then
					arg_1_1.var_.alphaOldValueD06b = var_4_18.color.a
					arg_1_1.var_.alphaMatValueD06b = var_4_18
				end

				arg_1_1.var_.alphaOldValueD06b = 0
			end

			local var_4_19 = 1.5

			if var_4_17 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_19 then
				local var_4_20 = (arg_1_1.time_ - var_4_17) / var_4_19
				local var_4_21 = Mathf.Lerp(arg_1_1.var_.alphaOldValueD06b, 1, var_4_20)

				if arg_1_1.var_.alphaMatValueD06b then
					local var_4_22 = arg_1_1.var_.alphaMatValueD06b.color

					var_4_22.a = var_4_21
					arg_1_1.var_.alphaMatValueD06b.color = var_4_22
				end
			end

			if arg_1_1.time_ >= var_4_17 + var_4_19 and arg_1_1.time_ < var_4_17 + var_4_19 + arg_4_0 and arg_1_1.var_.alphaMatValueD06b then
				local var_4_23 = arg_1_1.var_.alphaMatValueD06b
				local var_4_24 = var_4_23.color

				var_4_24.a = 1
				var_4_23.color = var_4_24
			end

			local var_4_25 = 0

			if var_4_25 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			local var_4_26 = 1.3

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_27 = manager.ui.mainCamera.transform
			local var_4_28 = 0.666666666666667

			if var_4_28 < arg_1_1.time_ and arg_1_1.time_ <= var_4_28 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_27.localPosition
			end

			local var_4_29 = 1.33333333333333

			if var_4_28 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				local var_4_30 = (arg_1_1.time_ - var_4_28) / 0.066
				local var_4_31, var_4_32 = math.modf(var_4_30)

				var_4_27.localPosition = Vector3.New(var_4_32 * 0.13, var_4_32 * 0.13, var_4_32 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				var_4_27.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_33 = 0.666666666666667

			if var_4_33 < arg_1_1.time_ and arg_1_1.time_ <= var_4_33 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_34 = 0.3

			if var_4_33 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				local var_4_35 = (arg_1_1.time_ - var_4_33) / var_4_34
				local var_4_36 = Color.New(1, 1, 1)

				var_4_36.a = Mathf.Lerp(1, 0, var_4_35)
				arg_1_1.mask_.color = var_4_36
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				local var_4_37 = Color.New(1, 1, 1)
				local var_4_38 = 0

				arg_1_1.mask_.enabled = false
				var_4_37.a = var_4_38
				arg_1_1.mask_.color = var_4_37
			end

			local var_4_39 = 1.63333333333333

			if var_4_39 < arg_1_1.time_ and arg_1_1.time_ <= var_4_39 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_40 = 0.2

			if var_4_39 <= arg_1_1.time_ and arg_1_1.time_ < var_4_39 + var_4_40 then
				local var_4_41 = (arg_1_1.time_ - var_4_39) / var_4_40
				local var_4_42 = Color.New(1, 1, 1)

				var_4_42.a = Mathf.Lerp(1, 0, var_4_41)
				arg_1_1.mask_.color = var_4_42
			end

			if arg_1_1.time_ >= var_4_39 + var_4_40 and arg_1_1.time_ < var_4_39 + var_4_40 + arg_4_0 then
				local var_4_43 = Color.New(1, 1, 1)
				local var_4_44 = 0

				arg_1_1.mask_.enabled = false
				var_4_43.a = var_4_44
				arg_1_1.mask_.color = var_4_43
			end

			local var_4_45 = "1094ui_story"

			if arg_1_1.actors_[var_4_45] == nil then
				local var_4_46 = Asset.Load("Char/" .. "1094ui_story")

				if not isNil(var_4_46) then
					local var_4_47 = Object.Instantiate(Asset.Load("Char/" .. "1094ui_story"), arg_1_1.stage_.transform)

					var_4_47.name = var_4_45
					var_4_47.transform.localPosition = Vector3.New(0, 100, 0)
					arg_1_1.actors_[var_4_45] = var_4_47

					local var_4_48 = var_4_47:GetComponentInChildren(typeof(CharacterEffect))

					var_4_48.enabled = true

					local var_4_49 = GameObjectTools.GetOrAddComponent(var_4_47, typeof(DynamicBoneHelper))

					if var_4_49 then
						var_4_49:EnableDynamicBone(false)
					end

					arg_1_1:ShowWeapon(var_4_48.transform, false)

					arg_1_1.var_[var_4_45 .. "Animator"] = var_4_48.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_1_1.var_[var_4_45 .. "Animator"].applyRootMotion = true
					arg_1_1.var_[var_4_45 .. "LipSync"] = var_4_48.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_4_50 = 2

			if var_4_50 < arg_1_1.time_ and arg_1_1.time_ <= var_4_50 + arg_4_0 then
				arg_1_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action6_2")
			end

			local var_4_51 = 2

			if var_4_51 < arg_1_1.time_ and arg_1_1.time_ <= var_4_51 + arg_4_0 then
				arg_1_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_4_52 = arg_1_1.actors_["1094ui_story"].transform
			local var_4_53 = 2

			if var_4_53 < arg_1_1.time_ and arg_1_1.time_ <= var_4_53 + arg_4_0 then
				arg_1_1.var_.moveOldPos1094ui_story = var_4_52.localPosition
			end

			local var_4_54 = 0.001

			if var_4_53 <= arg_1_1.time_ and arg_1_1.time_ < var_4_53 + var_4_54 then
				local var_4_55 = (arg_1_1.time_ - var_4_53) / var_4_54
				local var_4_56 = Vector3.New(0, -0.84, -6.1)

				var_4_52.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1094ui_story, var_4_56, var_4_55)

				local var_4_57 = manager.ui.mainCamera.transform.position - var_4_52.position

				var_4_52.forward = Vector3.New(var_4_57.x, var_4_57.y, var_4_57.z)

				local var_4_58 = var_4_52.localEulerAngles

				var_4_58.z = 0
				var_4_58.x = 0
				var_4_52.localEulerAngles = var_4_58
			end

			if arg_1_1.time_ >= var_4_53 + var_4_54 and arg_1_1.time_ < var_4_53 + var_4_54 + arg_4_0 then
				var_4_52.localPosition = Vector3.New(0, -0.84, -6.1)

				local var_4_59 = manager.ui.mainCamera.transform.position - var_4_52.position

				var_4_52.forward = Vector3.New(var_4_59.x, var_4_59.y, var_4_59.z)

				local var_4_60 = var_4_52.localEulerAngles

				var_4_60.z = 0
				var_4_60.x = 0
				var_4_52.localEulerAngles = var_4_60
			end

			local var_4_61 = arg_1_1.actors_["1094ui_story"]
			local var_4_62 = 2

			if var_4_62 < arg_1_1.time_ and arg_1_1.time_ <= var_4_62 + arg_4_0 and not isNil(var_4_61) and arg_1_1.var_.characterEffect1094ui_story == nil then
				arg_1_1.var_.characterEffect1094ui_story = var_4_61:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_63 = 0.2

			if var_4_62 <= arg_1_1.time_ and arg_1_1.time_ < var_4_62 + var_4_63 and not isNil(var_4_61) then
				local var_4_64 = (arg_1_1.time_ - var_4_62) / var_4_63

				if arg_1_1.var_.characterEffect1094ui_story and not isNil(var_4_61) then
					local var_4_65 = Mathf.Lerp(0, 0.5, var_4_64)

					arg_1_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_1_1.var_.characterEffect1094ui_story.fillRatio = var_4_65
				end
			end

			if arg_1_1.time_ >= var_4_62 + var_4_63 and arg_1_1.time_ < var_4_62 + var_4_63 + arg_4_0 and not isNil(var_4_61) and arg_1_1.var_.characterEffect1094ui_story then
				local var_4_66 = 0.5

				arg_1_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_1_1.var_.characterEffect1094ui_story.fillRatio = var_4_66
			end

			local var_4_67 = 1.5
			local var_4_68 = 1

			if var_4_67 < arg_1_1.time_ and arg_1_1.time_ <= var_4_67 + arg_4_0 then
				local var_4_69 = "play"
				local var_4_70 = "music"

				arg_1_1:AudioAction(var_4_69, var_4_70, "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1.awb")

				local var_4_71 = ""
				local var_4_72 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				if var_4_72 ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_72 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_72

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_72
						arg_1_1.bgmTxt2_.text = var_4_72
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_73 = 2
			local var_4_74 = 0.85

			if var_4_73 < arg_1_1.time_ and arg_1_1.time_ <= var_4_73 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_75 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_75:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_75:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_75:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_76 = arg_1_1:GetWordFromCfg(111102001)
				local var_4_77 = arg_1_1:FormatText(var_4_76.content)

				arg_1_1.text_.text = var_4_77

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_78 = 34
				local var_4_79 = utf8.len(var_4_77)
				local var_4_80 = var_4_78 <= 0 and var_4_74 or var_4_74 * (var_4_79 / var_4_78)

				if var_4_80 > 0 and var_4_74 < var_4_80 then
					arg_1_1.talkMaxDuration = var_4_80
					var_4_73 = var_4_73 + 0.3

					if var_4_80 + var_4_73 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_80 + var_4_73
					end
				end

				arg_1_1.text_.text = var_4_77
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_81 = var_4_73 + 0.3
			local var_4_82 = math.max(var_4_74, arg_1_1.talkMaxDuration)

			if var_4_81 <= arg_1_1.time_ and arg_1_1.time_ < var_4_81 + var_4_82 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_81) / var_4_82

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_81 + var_4_82 and arg_1_1.time_ < var_4_81 + var_4_82 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play111102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 111102002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play111102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0
			local var_11_1 = 1.15

			if var_11_0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_2 = arg_8_1:GetWordFromCfg(111102002)
				local var_11_3 = arg_8_1:FormatText(var_11_2.content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_4 = 46
				local var_11_5 = utf8.len(var_11_3)
				local var_11_6 = var_11_4 <= 0 and var_11_1 or var_11_1 * (var_11_5 / var_11_4)

				if var_11_6 > 0 and var_11_1 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_0
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_7 = math.max(var_11_1, arg_8_1.talkMaxDuration)

			if var_11_0 <= arg_8_1.time_ and arg_8_1.time_ < var_11_0 + var_11_7 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_0) / var_11_7

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_0 + var_11_7 and arg_8_1.time_ < var_11_0 + var_11_7 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play111102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 111102003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play111102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = manager.ui.mainCamera.transform
			local var_15_1 = 0.15

			if var_15_1 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				local var_15_2 = arg_12_1.var_.effect123
				local var_15_3
				local var_15_4 = var_15_0

				if not var_15_2 then
					var_15_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), var_15_4)
					var_15_2.name = "123"
					arg_12_1.var_.effect123 = var_15_2
				else
					var_15_2.transform:SetParent(var_15_4)
				end

				var_15_2.transform.localPosition = Vector3.New(0, 0, 0.15)
				var_15_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_15_5 = manager.ui.mainCamera.transform
			local var_15_6 = 0.15

			if var_15_6 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.var_.shakeOldPos = var_15_5.localPosition
			end

			local var_15_7 = 0.8

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_7 then
				local var_15_8 = (arg_12_1.time_ - var_15_6) / 0.066
				local var_15_9, var_15_10 = math.modf(var_15_8)

				var_15_5.localPosition = Vector3.New(var_15_10 * 0.13, var_15_10 * 0.13, var_15_10 * 0.13) + arg_12_1.var_.shakeOldPos
			end

			if arg_12_1.time_ >= var_15_6 + var_15_7 and arg_12_1.time_ < var_15_6 + var_15_7 + arg_15_0 then
				var_15_5.localPosition = arg_12_1.var_.shakeOldPos
			end

			local var_15_11 = 0

			if var_15_11 < arg_12_1.time_ and arg_12_1.time_ <= var_15_11 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			local var_15_12 = 2.65

			if arg_12_1.time_ >= var_15_11 + var_15_12 and arg_12_1.time_ < var_15_11 + var_15_12 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_13 = arg_12_1.actors_["1094ui_story"].transform
			local var_15_14 = 0

			if var_15_14 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.var_.moveOldPos1094ui_story = var_15_13.localPosition
			end

			local var_15_15 = 0.001

			if var_15_14 <= arg_12_1.time_ and arg_12_1.time_ < var_15_14 + var_15_15 then
				local var_15_16 = (arg_12_1.time_ - var_15_14) / var_15_15
				local var_15_17 = Vector3.New(0, 100, 0)

				var_15_13.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1094ui_story, var_15_17, var_15_16)

				local var_15_18 = manager.ui.mainCamera.transform.position - var_15_13.position

				var_15_13.forward = Vector3.New(var_15_18.x, var_15_18.y, var_15_18.z)

				local var_15_19 = var_15_13.localEulerAngles

				var_15_19.z = 0
				var_15_19.x = 0
				var_15_13.localEulerAngles = var_15_19
			end

			if arg_12_1.time_ >= var_15_14 + var_15_15 and arg_12_1.time_ < var_15_14 + var_15_15 + arg_15_0 then
				var_15_13.localPosition = Vector3.New(0, 100, 0)

				local var_15_20 = manager.ui.mainCamera.transform.position - var_15_13.position

				var_15_13.forward = Vector3.New(var_15_20.x, var_15_20.y, var_15_20.z)

				local var_15_21 = var_15_13.localEulerAngles

				var_15_21.z = 0
				var_15_21.x = 0
				var_15_13.localEulerAngles = var_15_21
			end

			local var_15_22 = 0
			local var_15_23 = 0.15

			if var_15_22 < arg_12_1.time_ and arg_12_1.time_ <= var_15_22 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				local var_15_24 = arg_12_1:FormatText(StoryNameCfg[7].name)

				arg_12_1.leftNameTxt_.text = var_15_24

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_25 = arg_12_1:GetWordFromCfg(111102003)
				local var_15_26 = arg_12_1:FormatText(var_15_25.content)

				arg_12_1.text_.text = var_15_26

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_27 = 6
				local var_15_28 = utf8.len(var_15_26)
				local var_15_29 = var_15_27 <= 0 and var_15_23 or var_15_23 * (var_15_28 / var_15_27)

				if var_15_29 > 0 and var_15_23 < var_15_29 then
					arg_12_1.talkMaxDuration = var_15_29

					if var_15_29 + var_15_22 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_29 + var_15_22
					end
				end

				arg_12_1.text_.text = var_15_26
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_30 = math.max(var_15_23, arg_12_1.talkMaxDuration)

			if var_15_22 <= arg_12_1.time_ and arg_12_1.time_ < var_15_22 + var_15_30 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_22) / var_15_30

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_22 + var_15_30 and arg_12_1.time_ < var_15_22 + var_15_30 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play111102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 111102004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			ja = 2.799999999999,
			ko = 4.6,
			zh = 3.7,
			en = 3
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play111102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = "1084ui_story"

			if arg_16_1.actors_[var_19_0] == nil then
				local var_19_1 = Asset.Load("Char/" .. "1084ui_story")

				if not isNil(var_19_1) then
					local var_19_2 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

					var_19_2.name = var_19_0
					var_19_2.transform.localPosition = Vector3.New(0, 100, 0)
					arg_16_1.actors_[var_19_0] = var_19_2

					local var_19_3 = var_19_2:GetComponentInChildren(typeof(CharacterEffect))

					var_19_3.enabled = true

					local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_2, typeof(DynamicBoneHelper))

					if var_19_4 then
						var_19_4:EnableDynamicBone(false)
					end

					arg_16_1:ShowWeapon(var_19_3.transform, false)

					arg_16_1.var_[var_19_0 .. "Animator"] = var_19_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
					arg_16_1.var_[var_19_0 .. "Animator"].applyRootMotion = true
					arg_16_1.var_[var_19_0 .. "LipSync"] = var_19_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
				end
			end

			local var_19_5 = arg_16_1.actors_["1084ui_story"].transform
			local var_19_6 = 0.8

			if var_19_6 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_5.localPosition

				local var_19_7 = "1084ui_story"

				arg_16_1:ShowWeapon(arg_16_1.var_[var_19_7 .. "Animator"].transform, true)
			end

			local var_19_8 = 0.001

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_8 then
				local var_19_9 = (arg_16_1.time_ - var_19_6) / var_19_8
				local var_19_10 = Vector3.New(-0.7, -0.97, -6)

				var_19_5.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, var_19_10, var_19_9)

				local var_19_11 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_11.x, var_19_11.y, var_19_11.z)

				local var_19_12 = var_19_5.localEulerAngles

				var_19_12.z = 0
				var_19_12.x = 0
				var_19_5.localEulerAngles = var_19_12
			end

			if arg_16_1.time_ >= var_19_6 + var_19_8 and arg_16_1.time_ < var_19_6 + var_19_8 + arg_19_0 then
				var_19_5.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_19_13 = manager.ui.mainCamera.transform.position - var_19_5.position

				var_19_5.forward = Vector3.New(var_19_13.x, var_19_13.y, var_19_13.z)

				local var_19_14 = var_19_5.localEulerAngles

				var_19_14.z = 0
				var_19_14.x = 0
				var_19_5.localEulerAngles = var_19_14
			end

			local var_19_15 = 0.8

			if var_19_15 < arg_16_1.time_ and arg_16_1.time_ <= var_19_15 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_19_16 = 0.8

			if var_19_16 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_19_17 = arg_16_1.actors_["1084ui_story"]
			local var_19_18 = 0.8

			if var_19_18 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 and not isNil(var_19_17) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_19 = 0.2

			if var_19_18 <= arg_16_1.time_ and arg_16_1.time_ < var_19_18 + var_19_19 and not isNil(var_19_17) then
				local var_19_20 = (arg_16_1.time_ - var_19_18) / var_19_19

				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_17) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= var_19_18 + var_19_19 and arg_16_1.time_ < var_19_18 + var_19_19 + arg_19_0 and not isNil(var_19_17) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_21 = manager.ui.mainCamera.transform
			local var_19_22 = 0

			if var_19_22 < arg_16_1.time_ and arg_16_1.time_ <= var_19_22 + arg_19_0 then
				local var_19_23 = arg_16_1.var_.effect123

				if var_19_23 then
					Object.Destroy(var_19_23)

					arg_16_1.var_.effect123 = nil
				end
			end

			local var_19_24 = 0

			if var_19_24 < arg_16_1.time_ and arg_16_1.time_ <= var_19_24 + arg_19_0 then
				arg_16_1.allBtn_.enabled = false
			end

			local var_19_25 = 2.65

			if arg_16_1.time_ >= var_19_24 + var_19_25 and arg_16_1.time_ < var_19_24 + var_19_25 + arg_19_0 then
				arg_16_1.allBtn_.enabled = true
			end

			local var_19_26 = manager.ui.mainCamera.transform
			local var_19_27 = 0

			if var_19_27 < arg_16_1.time_ and arg_16_1.time_ <= var_19_27 + arg_19_0 then
				arg_16_1.var_.shakeOldPos = var_19_26.localPosition
			end

			local var_19_28 = 0.8

			if var_19_27 <= arg_16_1.time_ and arg_16_1.time_ < var_19_27 + var_19_28 then
				local var_19_29 = (arg_16_1.time_ - var_19_27) / 0.066
				local var_19_30, var_19_31 = math.modf(var_19_29)

				var_19_26.localPosition = Vector3.New(var_19_31 * 0.13, var_19_31 * 0.13, var_19_31 * 0.13) + arg_16_1.var_.shakeOldPos
			end

			if arg_16_1.time_ >= var_19_27 + var_19_28 and arg_16_1.time_ < var_19_27 + var_19_28 + arg_19_0 then
				var_19_26.localPosition = arg_16_1.var_.shakeOldPos
			end

			local var_19_32 = manager.ui.mainCamera.transform
			local var_19_33 = 0

			if var_19_33 < arg_16_1.time_ and arg_16_1.time_ <= var_19_33 + arg_19_0 then
				local var_19_34 = arg_16_1.var_.effect111
				local var_19_35
				local var_19_36 = var_19_32

				if not var_19_34 then
					var_19_34 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_02"), var_19_36)
					var_19_34.name = "111"
					arg_16_1.var_.effect111 = var_19_34
				else
					var_19_34.transform:SetParent(var_19_36)
				end

				var_19_34.transform.localPosition = Vector3.New(0, 0, 0.15)
				var_19_34.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_16_1.frameCnt_ <= 1 then
				arg_16_1.dialog_:SetActive(false)
			end

			local var_19_37 = 0.8
			local var_19_38 = 0.275

			if var_19_37 < arg_16_1.time_ and arg_16_1.time_ <= var_19_37 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0

				arg_16_1.dialog_:SetActive(true)

				arg_16_1.dialogCg_.alpha = 0

				local var_19_39 = LeanTween.value(arg_16_1.dialog_, 0, 1, 0.3)

				var_19_39:setOnUpdate(LuaHelper.FloatAction(function(arg_20_0)
					arg_16_1.dialogCg_.alpha = arg_20_0
				end))
				var_19_39:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_16_1.dialog_)
					var_19_39:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_16_1.duration_ = arg_16_1.duration_ + 0.3

				SetActive(arg_16_1.leftNameGo_, true)

				local var_19_40 = arg_16_1:FormatText(StoryNameCfg[6].name)

				arg_16_1.leftNameTxt_.text = var_19_40

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_41 = arg_16_1:GetWordFromCfg(111102004)
				local var_19_42 = arg_16_1:FormatText(var_19_41.content)

				arg_16_1.text_.text = var_19_42

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_43 = 11
				local var_19_44 = utf8.len(var_19_42)
				local var_19_45 = var_19_43 <= 0 and var_19_38 or var_19_38 * (var_19_44 / var_19_43)

				if var_19_45 > 0 and var_19_38 < var_19_45 then
					arg_16_1.talkMaxDuration = var_19_45
					var_19_37 = var_19_37 + 0.3

					if var_19_45 + var_19_37 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_45 + var_19_37
					end
				end

				arg_16_1.text_.text = var_19_42
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102004", "story_v_out_111102.awb") ~= 0 then
					local var_19_46 = manager.audio:GetVoiceLength("story_v_out_111102", "111102004", "story_v_out_111102.awb") / 1000

					if var_19_46 + var_19_37 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_46 + var_19_37
					end

					if var_19_41.prefab_name ~= "" and arg_16_1.actors_[var_19_41.prefab_name] ~= nil then
						local var_19_47 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_41.prefab_name].transform, "story_v_out_111102", "111102004", "story_v_out_111102.awb")

						arg_16_1:RecordAudio("111102004", var_19_47)
						arg_16_1:RecordAudio("111102004", var_19_47)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_111102", "111102004", "story_v_out_111102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_111102", "111102004", "story_v_out_111102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_48 = var_19_37 + 0.3
			local var_19_49 = math.max(var_19_38, arg_16_1.talkMaxDuration)

			if var_19_48 <= arg_16_1.time_ and arg_16_1.time_ < var_19_48 + var_19_49 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_48) / var_19_49

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_48 + var_19_49 and arg_16_1.time_ < var_19_48 + var_19_49 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play111102005 = function(arg_22_0, arg_22_1)
		arg_22_1.time_ = 0
		arg_22_1.frameCnt_ = 0
		arg_22_1.state_ = "playing"
		arg_22_1.curTalkId_ = 111102005
		arg_22_1.duration_ = 9

		local var_22_0 = {
			ja = 7.733,
			ko = 8.533,
			zh = 7.766,
			en = 9
		}
		local var_22_1 = manager.audio:GetLocalizationFlag()

		if var_22_0[var_22_1] ~= nil then
			arg_22_1.duration_ = var_22_0[var_22_1]
		end

		SetActive(arg_22_1.tipsGo_, false)

		function arg_22_1.onSingleLineFinish_()
			arg_22_1.onSingleLineUpdate_ = nil
			arg_22_1.onSingleLineFinish_ = nil
			arg_22_1.state_ = "waiting"
		end

		function arg_22_1.playNext_(arg_24_0)
			if arg_24_0 == 1 then
				arg_22_0:Play111102006(arg_22_1)
			end
		end

		function arg_22_1.onSingleLineUpdate_(arg_25_0)
			local var_25_0 = 0

			if var_25_0 < arg_22_1.time_ and arg_22_1.time_ <= var_25_0 + arg_25_0 then
				arg_22_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_25_1 = manager.ui.mainCamera.transform
			local var_25_2 = 0

			if var_25_2 < arg_22_1.time_ and arg_22_1.time_ <= var_25_2 + arg_25_0 then
				local var_25_3 = arg_22_1.var_.effect111

				if var_25_3 then
					Object.Destroy(var_25_3)

					arg_22_1.var_.effect111 = nil
				end
			end

			local var_25_4 = 0
			local var_25_5 = 1.025

			if var_25_4 < arg_22_1.time_ and arg_22_1.time_ <= var_25_4 + arg_25_0 then
				arg_22_1.talkMaxDuration = 0
				arg_22_1.dialogCg_.alpha = 1

				arg_22_1.dialog_:SetActive(true)
				SetActive(arg_22_1.leftNameGo_, true)

				local var_25_6 = arg_22_1:FormatText(StoryNameCfg[6].name)

				arg_22_1.leftNameTxt_.text = var_25_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_22_1.leftNameTxt_.transform)

				arg_22_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_22_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_22_1:RecordName(arg_22_1.leftNameTxt_.text)
				SetActive(arg_22_1.iconTrs_.gameObject, false)
				arg_22_1.callingController_:SetSelectedState("normal")

				local var_25_7 = arg_22_1:GetWordFromCfg(111102005)
				local var_25_8 = arg_22_1:FormatText(var_25_7.content)

				arg_22_1.text_.text = var_25_8

				LuaForUtil.ClearLinePrefixSymbol(arg_22_1.text_)

				local var_25_9 = 41
				local var_25_10 = utf8.len(var_25_8)
				local var_25_11 = var_25_9 <= 0 and var_25_5 or var_25_5 * (var_25_10 / var_25_9)

				if var_25_11 > 0 and var_25_5 < var_25_11 then
					arg_22_1.talkMaxDuration = var_25_11

					if var_25_11 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_11 + var_25_4
					end
				end

				arg_22_1.text_.text = var_25_8
				arg_22_1.typewritter.percent = 0

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102005", "story_v_out_111102.awb") ~= 0 then
					local var_25_12 = manager.audio:GetVoiceLength("story_v_out_111102", "111102005", "story_v_out_111102.awb") / 1000

					if var_25_12 + var_25_4 > arg_22_1.duration_ then
						arg_22_1.duration_ = var_25_12 + var_25_4
					end

					if var_25_7.prefab_name ~= "" and arg_22_1.actors_[var_25_7.prefab_name] ~= nil then
						local var_25_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_22_1.actors_[var_25_7.prefab_name].transform, "story_v_out_111102", "111102005", "story_v_out_111102.awb")

						arg_22_1:RecordAudio("111102005", var_25_13)
						arg_22_1:RecordAudio("111102005", var_25_13)
					else
						arg_22_1:AudioAction("play", "voice", "story_v_out_111102", "111102005", "story_v_out_111102.awb")
					end

					arg_22_1:RecordHistoryTalkVoice("story_v_out_111102", "111102005", "story_v_out_111102.awb")
				end

				arg_22_1:RecordContent(arg_22_1.text_.text)
			end

			local var_25_14 = math.max(var_25_5, arg_22_1.talkMaxDuration)

			if var_25_4 <= arg_22_1.time_ and arg_22_1.time_ < var_25_4 + var_25_14 then
				arg_22_1.typewritter.percent = (arg_22_1.time_ - var_25_4) / var_25_14

				arg_22_1.typewritter:SetDirty()
			end

			if arg_22_1.time_ >= var_25_4 + var_25_14 and arg_22_1.time_ < var_25_4 + var_25_14 + arg_25_0 then
				arg_22_1.typewritter.percent = 1

				arg_22_1.typewritter:SetDirty()
				arg_22_1:ShowNextGo(true)
			end
		end

		arg_22_1.nodeConfigList_ = {}

		arg_22_1:InitPlayNodeList()
	end,
	Play111102006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 111102006
		arg_26_1.duration_ = 5

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play111102007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = arg_26_1.actors_["1084ui_story"]
			local var_29_1 = 0

			if var_29_1 < arg_26_1.time_ and arg_26_1.time_ <= var_29_1 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1084ui_story == nil then
				arg_26_1.var_.characterEffect1084ui_story = var_29_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_2 = 0.2

			if var_29_1 <= arg_26_1.time_ and arg_26_1.time_ < var_29_1 + var_29_2 and not isNil(var_29_0) then
				local var_29_3 = (arg_26_1.time_ - var_29_1) / var_29_2

				if arg_26_1.var_.characterEffect1084ui_story and not isNil(var_29_0) then
					local var_29_4 = Mathf.Lerp(0, 0.5, var_29_3)

					arg_26_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1084ui_story.fillRatio = var_29_4
				end
			end

			if arg_26_1.time_ >= var_29_1 + var_29_2 and arg_26_1.time_ < var_29_1 + var_29_2 + arg_29_0 and not isNil(var_29_0) and arg_26_1.var_.characterEffect1084ui_story then
				local var_29_5 = 0.5

				arg_26_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1084ui_story.fillRatio = var_29_5
			end

			local var_29_6 = 0
			local var_29_7 = 0.45

			if var_29_6 < arg_26_1.time_ and arg_26_1.time_ <= var_29_6 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				local var_29_8 = arg_26_1:FormatText(StoryNameCfg[7].name)

				arg_26_1.leftNameTxt_.text = var_29_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, true)
				arg_26_1.iconController_:SetSelectedState("hero")

				arg_26_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_26_1.callingController_:SetSelectedState("normal")

				arg_26_1.keyicon_.color = Color.New(1, 1, 1)
				arg_26_1.icon_.color = Color.New(1, 1, 1)

				local var_29_9 = arg_26_1:GetWordFromCfg(111102006)
				local var_29_10 = arg_26_1:FormatText(var_29_9.content)

				arg_26_1.text_.text = var_29_10

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_11 = 18
				local var_29_12 = utf8.len(var_29_10)
				local var_29_13 = var_29_11 <= 0 and var_29_7 or var_29_7 * (var_29_12 / var_29_11)

				if var_29_13 > 0 and var_29_7 < var_29_13 then
					arg_26_1.talkMaxDuration = var_29_13

					if var_29_13 + var_29_6 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_13 + var_29_6
					end
				end

				arg_26_1.text_.text = var_29_10
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)
				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_14 = math.max(var_29_7, arg_26_1.talkMaxDuration)

			if var_29_6 <= arg_26_1.time_ and arg_26_1.time_ < var_29_6 + var_29_14 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_6) / var_29_14

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_6 + var_29_14 and arg_26_1.time_ < var_29_6 + var_29_14 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play111102007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 111102007
		arg_30_1.duration_ = 2

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play111102008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			local var_33_0 = arg_30_1.actors_["1094ui_story"].transform
			local var_33_1 = 0

			if var_33_1 < arg_30_1.time_ and arg_30_1.time_ <= var_33_1 + arg_33_0 then
				arg_30_1.var_.moveOldPos1094ui_story = var_33_0.localPosition
			end

			local var_33_2 = 0.001

			if var_33_1 <= arg_30_1.time_ and arg_30_1.time_ < var_33_1 + var_33_2 then
				local var_33_3 = (arg_30_1.time_ - var_33_1) / var_33_2
				local var_33_4 = Vector3.New(0.7, -0.84, -6.1)

				var_33_0.localPosition = Vector3.Lerp(arg_30_1.var_.moveOldPos1094ui_story, var_33_4, var_33_3)

				local var_33_5 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_5.x, var_33_5.y, var_33_5.z)

				local var_33_6 = var_33_0.localEulerAngles

				var_33_6.z = 0
				var_33_6.x = 0
				var_33_0.localEulerAngles = var_33_6
			end

			if arg_30_1.time_ >= var_33_1 + var_33_2 and arg_30_1.time_ < var_33_1 + var_33_2 + arg_33_0 then
				var_33_0.localPosition = Vector3.New(0.7, -0.84, -6.1)

				local var_33_7 = manager.ui.mainCamera.transform.position - var_33_0.position

				var_33_0.forward = Vector3.New(var_33_7.x, var_33_7.y, var_33_7.z)

				local var_33_8 = var_33_0.localEulerAngles

				var_33_8.z = 0
				var_33_8.x = 0
				var_33_0.localEulerAngles = var_33_8
			end

			local var_33_9 = 0

			if var_33_9 < arg_30_1.time_ and arg_30_1.time_ <= var_33_9 + arg_33_0 then
				arg_30_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_1")
			end

			local var_33_10 = 0

			if var_33_10 < arg_30_1.time_ and arg_30_1.time_ <= var_33_10 + arg_33_0 then
				arg_30_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action1_1")
			end

			local var_33_11 = arg_30_1.actors_["1094ui_story"]
			local var_33_12 = 0

			if var_33_12 < arg_30_1.time_ and arg_30_1.time_ <= var_33_12 + arg_33_0 and not isNil(var_33_11) and arg_30_1.var_.characterEffect1094ui_story == nil then
				arg_30_1.var_.characterEffect1094ui_story = var_33_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_13 = 0.2

			if var_33_12 <= arg_30_1.time_ and arg_30_1.time_ < var_33_12 + var_33_13 and not isNil(var_33_11) then
				local var_33_14 = (arg_30_1.time_ - var_33_12) / var_33_13

				if arg_30_1.var_.characterEffect1094ui_story and not isNil(var_33_11) then
					arg_30_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= var_33_12 + var_33_13 and arg_30_1.time_ < var_33_12 + var_33_13 + arg_33_0 and not isNil(var_33_11) and arg_30_1.var_.characterEffect1094ui_story then
				arg_30_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_33_15 = 0
			local var_33_16 = 0.125

			if var_33_15 < arg_30_1.time_ and arg_30_1.time_ <= var_33_15 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				local var_33_17 = arg_30_1:FormatText(StoryNameCfg[181].name)

				arg_30_1.leftNameTxt_.text = var_33_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_18 = arg_30_1:GetWordFromCfg(111102007)
				local var_33_19 = arg_30_1:FormatText(var_33_18.content)

				arg_30_1.text_.text = var_33_19

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_20 = 5
				local var_33_21 = utf8.len(var_33_19)
				local var_33_22 = var_33_20 <= 0 and var_33_16 or var_33_16 * (var_33_21 / var_33_20)

				if var_33_22 > 0 and var_33_16 < var_33_22 then
					arg_30_1.talkMaxDuration = var_33_22

					if var_33_22 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_22 + var_33_15
					end
				end

				arg_30_1.text_.text = var_33_19
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102007", "story_v_out_111102.awb") ~= 0 then
					local var_33_23 = manager.audio:GetVoiceLength("story_v_out_111102", "111102007", "story_v_out_111102.awb") / 1000

					if var_33_23 + var_33_15 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_23 + var_33_15
					end

					if var_33_18.prefab_name ~= "" and arg_30_1.actors_[var_33_18.prefab_name] ~= nil then
						local var_33_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_18.prefab_name].transform, "story_v_out_111102", "111102007", "story_v_out_111102.awb")

						arg_30_1:RecordAudio("111102007", var_33_24)
						arg_30_1:RecordAudio("111102007", var_33_24)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_111102", "111102007", "story_v_out_111102.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_111102", "111102007", "story_v_out_111102.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_25 = math.max(var_33_16, arg_30_1.talkMaxDuration)

			if var_33_15 <= arg_30_1.time_ and arg_30_1.time_ < var_33_15 + var_33_25 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_15) / var_33_25

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_15 + var_33_25 and arg_30_1.time_ < var_33_15 + var_33_25 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1094ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_30_1:InitPlayNodeList()
	end,
	Play111102008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 111102008
		arg_34_1.duration_ = 5

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play111102009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			local var_37_0 = arg_34_1.actors_["1094ui_story"]
			local var_37_1 = 0

			if var_37_1 < arg_34_1.time_ and arg_34_1.time_ <= var_37_1 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1094ui_story == nil then
				arg_34_1.var_.characterEffect1094ui_story = var_37_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_2 = 0.2

			if var_37_1 <= arg_34_1.time_ and arg_34_1.time_ < var_37_1 + var_37_2 and not isNil(var_37_0) then
				local var_37_3 = (arg_34_1.time_ - var_37_1) / var_37_2

				if arg_34_1.var_.characterEffect1094ui_story and not isNil(var_37_0) then
					local var_37_4 = Mathf.Lerp(0, 0.5, var_37_3)

					arg_34_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1094ui_story.fillRatio = var_37_4
				end
			end

			if arg_34_1.time_ >= var_37_1 + var_37_2 and arg_34_1.time_ < var_37_1 + var_37_2 + arg_37_0 and not isNil(var_37_0) and arg_34_1.var_.characterEffect1094ui_story then
				local var_37_5 = 0.5

				arg_34_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1094ui_story.fillRatio = var_37_5
			end

			local var_37_6 = 0
			local var_37_7 = 0.7

			if var_37_6 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				local var_37_8 = arg_34_1:FormatText(StoryNameCfg[7].name)

				arg_34_1.leftNameTxt_.text = var_37_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_9 = arg_34_1:GetWordFromCfg(111102008)
				local var_37_10 = arg_34_1:FormatText(var_37_9.content)

				arg_34_1.text_.text = var_37_10

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 28
				local var_37_12 = utf8.len(var_37_10)
				local var_37_13 = var_37_11 <= 0 and var_37_7 or var_37_7 * (var_37_12 / var_37_11)

				if var_37_13 > 0 and var_37_7 < var_37_13 then
					arg_34_1.talkMaxDuration = var_37_13

					if var_37_13 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_13 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_10
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)
				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_14 = math.max(var_37_7, arg_34_1.talkMaxDuration)

			if var_37_6 <= arg_34_1.time_ and arg_34_1.time_ < var_37_6 + var_37_14 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_6) / var_37_14

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_6 + var_37_14 and arg_34_1.time_ < var_37_6 + var_37_14 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play111102009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 111102009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play111102010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = arg_38_1.actors_["1094ui_story"]
			local var_41_1 = 0

			if var_41_1 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1094ui_story == nil then
				arg_38_1.var_.characterEffect1094ui_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_2 = 0.2

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_2 and not isNil(var_41_0) then
				local var_41_3 = (arg_38_1.time_ - var_41_1) / var_41_2

				if arg_38_1.var_.characterEffect1094ui_story and not isNil(var_41_0) then
					local var_41_4 = Mathf.Lerp(0, 0.5, var_41_3)

					arg_38_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1094ui_story.fillRatio = var_41_4
				end
			end

			if arg_38_1.time_ >= var_41_1 + var_41_2 and arg_38_1.time_ < var_41_1 + var_41_2 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect1094ui_story then
				local var_41_5 = 0.5

				arg_38_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1094ui_story.fillRatio = var_41_5
			end

			local var_41_6 = 0
			local var_41_7 = 0.75

			if var_41_6 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				local var_41_8 = arg_38_1:FormatText(StoryNameCfg[7].name)

				arg_38_1.leftNameTxt_.text = var_41_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, true)
				arg_38_1.iconController_:SetSelectedState("hero")

				arg_38_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_38_1.callingController_:SetSelectedState("normal")

				arg_38_1.keyicon_.color = Color.New(1, 1, 1)
				arg_38_1.icon_.color = Color.New(1, 1, 1)

				local var_41_9 = arg_38_1:GetWordFromCfg(111102009)
				local var_41_10 = arg_38_1:FormatText(var_41_9.content)

				arg_38_1.text_.text = var_41_10

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 30
				local var_41_12 = utf8.len(var_41_10)
				local var_41_13 = var_41_11 <= 0 and var_41_7 or var_41_7 * (var_41_12 / var_41_11)

				if var_41_13 > 0 and var_41_7 < var_41_13 then
					arg_38_1.talkMaxDuration = var_41_13

					if var_41_13 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_13 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_10
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play111102010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 111102010
		arg_42_1.duration_ = 5

		local var_42_0 = {
			ja = 3.5,
			ko = 5,
			zh = 4,
			en = 4.566
		}
		local var_42_1 = manager.audio:GetLocalizationFlag()

		if var_42_0[var_42_1] ~= nil then
			arg_42_1.duration_ = var_42_0[var_42_1]
		end

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play111102011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			local var_45_0 = 0

			if var_45_0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_0 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_45_1 = 0

			if var_45_1 < arg_42_1.time_ and arg_42_1.time_ <= var_45_1 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_45_2 = arg_42_1.actors_["1084ui_story"]
			local var_45_3 = 0

			if var_45_3 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect1084ui_story == nil then
				arg_42_1.var_.characterEffect1084ui_story = var_45_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.2

			if var_45_3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_3 + var_45_4 and not isNil(var_45_2) then
				local var_45_5 = (arg_42_1.time_ - var_45_3) / var_45_4

				if arg_42_1.var_.characterEffect1084ui_story and not isNil(var_45_2) then
					arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= var_45_3 + var_45_4 and arg_42_1.time_ < var_45_3 + var_45_4 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect1084ui_story then
				arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_45_6 = arg_42_1.actors_["1084ui_story"].transform
			local var_45_7 = 0

			if var_45_7 < arg_42_1.time_ and arg_42_1.time_ <= var_45_7 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = var_45_6.localPosition

				local var_45_8 = "1084ui_story"

				arg_42_1:ShowWeapon(arg_42_1.var_[var_45_8 .. "Animator"].transform, false)
			end

			local var_45_9 = 0.001

			if var_45_7 <= arg_42_1.time_ and arg_42_1.time_ < var_45_7 + var_45_9 then
				local var_45_10 = (arg_42_1.time_ - var_45_7) / var_45_9
				local var_45_11 = Vector3.New(-0.7, -0.97, -6)

				var_45_6.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, var_45_11, var_45_10)

				local var_45_12 = manager.ui.mainCamera.transform.position - var_45_6.position

				var_45_6.forward = Vector3.New(var_45_12.x, var_45_12.y, var_45_12.z)

				local var_45_13 = var_45_6.localEulerAngles

				var_45_13.z = 0
				var_45_13.x = 0
				var_45_6.localEulerAngles = var_45_13
			end

			if arg_42_1.time_ >= var_45_7 + var_45_9 and arg_42_1.time_ < var_45_7 + var_45_9 + arg_45_0 then
				var_45_6.localPosition = Vector3.New(-0.7, -0.97, -6)

				local var_45_14 = manager.ui.mainCamera.transform.position - var_45_6.position

				var_45_6.forward = Vector3.New(var_45_14.x, var_45_14.y, var_45_14.z)

				local var_45_15 = var_45_6.localEulerAngles

				var_45_15.z = 0
				var_45_15.x = 0
				var_45_6.localEulerAngles = var_45_15
			end

			local var_45_16 = 0
			local var_45_17 = 0.6

			if var_45_16 < arg_42_1.time_ and arg_42_1.time_ <= var_45_16 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				local var_45_18 = arg_42_1:FormatText(StoryNameCfg[6].name)

				arg_42_1.leftNameTxt_.text = var_45_18

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_19 = arg_42_1:GetWordFromCfg(111102010)
				local var_45_20 = arg_42_1:FormatText(var_45_19.content)

				arg_42_1.text_.text = var_45_20

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_21 = 25
				local var_45_22 = utf8.len(var_45_20)
				local var_45_23 = var_45_21 <= 0 and var_45_17 or var_45_17 * (var_45_22 / var_45_21)

				if var_45_23 > 0 and var_45_17 < var_45_23 then
					arg_42_1.talkMaxDuration = var_45_23

					if var_45_23 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_23 + var_45_16
					end
				end

				arg_42_1.text_.text = var_45_20
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102010", "story_v_out_111102.awb") ~= 0 then
					local var_45_24 = manager.audio:GetVoiceLength("story_v_out_111102", "111102010", "story_v_out_111102.awb") / 1000

					if var_45_24 + var_45_16 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_24 + var_45_16
					end

					if var_45_19.prefab_name ~= "" and arg_42_1.actors_[var_45_19.prefab_name] ~= nil then
						local var_45_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_19.prefab_name].transform, "story_v_out_111102", "111102010", "story_v_out_111102.awb")

						arg_42_1:RecordAudio("111102010", var_45_25)
						arg_42_1:RecordAudio("111102010", var_45_25)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_111102", "111102010", "story_v_out_111102.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_111102", "111102010", "story_v_out_111102.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_26 = math.max(var_45_17, arg_42_1.talkMaxDuration)

			if var_45_16 <= arg_42_1.time_ and arg_42_1.time_ < var_45_16 + var_45_26 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_16) / var_45_26

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_16 + var_45_26 and arg_42_1.time_ < var_45_16 + var_45_26 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_42_1:InitPlayNodeList()
	end,
	Play111102011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 111102011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play111102012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			local var_49_0 = arg_46_1.actors_["1084ui_story"]
			local var_49_1 = 0

			if var_49_1 < arg_46_1.time_ and arg_46_1.time_ <= var_49_1 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1084ui_story == nil then
				arg_46_1.var_.characterEffect1084ui_story = var_49_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_2 = 0.2

			if var_49_1 <= arg_46_1.time_ and arg_46_1.time_ < var_49_1 + var_49_2 and not isNil(var_49_0) then
				local var_49_3 = (arg_46_1.time_ - var_49_1) / var_49_2

				if arg_46_1.var_.characterEffect1084ui_story and not isNil(var_49_0) then
					local var_49_4 = Mathf.Lerp(0, 0.5, var_49_3)

					arg_46_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1084ui_story.fillRatio = var_49_4
				end
			end

			if arg_46_1.time_ >= var_49_1 + var_49_2 and arg_46_1.time_ < var_49_1 + var_49_2 + arg_49_0 and not isNil(var_49_0) and arg_46_1.var_.characterEffect1084ui_story then
				local var_49_5 = 0.5

				arg_46_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1084ui_story.fillRatio = var_49_5
			end

			local var_49_6 = 0
			local var_49_7 = 0.525

			if var_49_6 < arg_46_1.time_ and arg_46_1.time_ <= var_49_6 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_8 = arg_46_1:GetWordFromCfg(111102011)
				local var_49_9 = arg_46_1:FormatText(var_49_8.content)

				arg_46_1.text_.text = var_49_9

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_10 = 21
				local var_49_11 = utf8.len(var_49_9)
				local var_49_12 = var_49_10 <= 0 and var_49_7 or var_49_7 * (var_49_11 / var_49_10)

				if var_49_12 > 0 and var_49_7 < var_49_12 then
					arg_46_1.talkMaxDuration = var_49_12

					if var_49_12 + var_49_6 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_12 + var_49_6
					end
				end

				arg_46_1.text_.text = var_49_9
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_13 = math.max(var_49_7, arg_46_1.talkMaxDuration)

			if var_49_6 <= arg_46_1.time_ and arg_46_1.time_ < var_49_6 + var_49_13 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_6) / var_49_13

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_6 + var_49_13 and arg_46_1.time_ < var_49_6 + var_49_13 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play111102012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 111102012
		arg_50_1.duration_ = 4

		local var_50_0 = {
			ja = 4,
			ko = 2.1,
			zh = 2.5,
			en = 2.266
		}
		local var_50_1 = manager.audio:GetLocalizationFlag()

		if var_50_0[var_50_1] ~= nil then
			arg_50_1.duration_ = var_50_0[var_50_1]
		end

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play111102013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_0 = 0

			if var_53_0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_0 + arg_53_0 then
				arg_50_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/story1094/story1094action/1094action2_2")
			end

			local var_53_1 = 0

			if var_53_1 < arg_50_1.time_ and arg_50_1.time_ <= var_53_1 + arg_53_0 then
				arg_50_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_53_2 = arg_50_1.actors_["1094ui_story"]
			local var_53_3 = 0

			if var_53_3 < arg_50_1.time_ and arg_50_1.time_ <= var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1094ui_story == nil then
				arg_50_1.var_.characterEffect1094ui_story = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_4 = 0.2

			if var_53_3 <= arg_50_1.time_ and arg_50_1.time_ < var_53_3 + var_53_4 and not isNil(var_53_2) then
				local var_53_5 = (arg_50_1.time_ - var_53_3) / var_53_4

				if arg_50_1.var_.characterEffect1094ui_story and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= var_53_3 + var_53_4 and arg_50_1.time_ < var_53_3 + var_53_4 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1094ui_story then
				arg_50_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_53_6 = 0
			local var_53_7 = 0.25

			if var_53_6 < arg_50_1.time_ and arg_50_1.time_ <= var_53_6 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				local var_53_8 = arg_50_1:FormatText(StoryNameCfg[181].name)

				arg_50_1.leftNameTxt_.text = var_53_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:GetWordFromCfg(111102012)
				local var_53_10 = arg_50_1:FormatText(var_53_9.content)

				arg_50_1.text_.text = var_53_10

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 10
				local var_53_12 = utf8.len(var_53_10)
				local var_53_13 = var_53_11 <= 0 and var_53_7 or var_53_7 * (var_53_12 / var_53_11)

				if var_53_13 > 0 and var_53_7 < var_53_13 then
					arg_50_1.talkMaxDuration = var_53_13

					if var_53_13 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_13 + var_53_6
					end
				end

				arg_50_1.text_.text = var_53_10
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102012", "story_v_out_111102.awb") ~= 0 then
					local var_53_14 = manager.audio:GetVoiceLength("story_v_out_111102", "111102012", "story_v_out_111102.awb") / 1000

					if var_53_14 + var_53_6 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_14 + var_53_6
					end

					if var_53_9.prefab_name ~= "" and arg_50_1.actors_[var_53_9.prefab_name] ~= nil then
						local var_53_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_9.prefab_name].transform, "story_v_out_111102", "111102012", "story_v_out_111102.awb")

						arg_50_1:RecordAudio("111102012", var_53_15)
						arg_50_1:RecordAudio("111102012", var_53_15)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_111102", "111102012", "story_v_out_111102.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_111102", "111102012", "story_v_out_111102.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_16 = math.max(var_53_7, arg_50_1.talkMaxDuration)

			if var_53_6 <= arg_50_1.time_ and arg_50_1.time_ < var_53_6 + var_53_16 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_6) / var_53_16

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_6 + var_53_16 and arg_50_1.time_ < var_53_6 + var_53_16 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play111102013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 111102013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play111102014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = arg_54_1.actors_["1094ui_story"]
			local var_57_1 = 0

			if var_57_1 < arg_54_1.time_ and arg_54_1.time_ <= var_57_1 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1094ui_story == nil then
				arg_54_1.var_.characterEffect1094ui_story = var_57_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.2

			if var_57_1 <= arg_54_1.time_ and arg_54_1.time_ < var_57_1 + var_57_2 and not isNil(var_57_0) then
				local var_57_3 = (arg_54_1.time_ - var_57_1) / var_57_2

				if arg_54_1.var_.characterEffect1094ui_story and not isNil(var_57_0) then
					local var_57_4 = Mathf.Lerp(0, 0.5, var_57_3)

					arg_54_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1094ui_story.fillRatio = var_57_4
				end
			end

			if arg_54_1.time_ >= var_57_1 + var_57_2 and arg_54_1.time_ < var_57_1 + var_57_2 + arg_57_0 and not isNil(var_57_0) and arg_54_1.var_.characterEffect1094ui_story then
				local var_57_5 = 0.5

				arg_54_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1094ui_story.fillRatio = var_57_5
			end

			local var_57_6 = 0
			local var_57_7 = 0.825

			if var_57_6 < arg_54_1.time_ and arg_54_1.time_ <= var_57_6 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				local var_57_8 = arg_54_1:FormatText(StoryNameCfg[7].name)

				arg_54_1.leftNameTxt_.text = var_57_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_9 = arg_54_1:GetWordFromCfg(111102013)
				local var_57_10 = arg_54_1:FormatText(var_57_9.content)

				arg_54_1.text_.text = var_57_10

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_11 = 33
				local var_57_12 = utf8.len(var_57_10)
				local var_57_13 = var_57_11 <= 0 and var_57_7 or var_57_7 * (var_57_12 / var_57_11)

				if var_57_13 > 0 and var_57_7 < var_57_13 then
					arg_54_1.talkMaxDuration = var_57_13

					if var_57_13 + var_57_6 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_13 + var_57_6
					end
				end

				arg_54_1.text_.text = var_57_10
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_14 = math.max(var_57_7, arg_54_1.talkMaxDuration)

			if var_57_6 <= arg_54_1.time_ and arg_54_1.time_ < var_57_6 + var_57_14 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_6) / var_57_14

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_6 + var_57_14 and arg_54_1.time_ < var_57_6 + var_57_14 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play111102014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 111102014
		arg_58_1.duration_ = 2.73

		local var_58_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.733,
			en = 2.2
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play111102015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0

			if var_61_0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_0 + arg_61_0 then
				arg_58_1:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_61_1 = arg_58_1.actors_["1094ui_story"]
			local var_61_2 = 0

			if var_61_2 < arg_58_1.time_ and arg_58_1.time_ <= var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1094ui_story == nil then
				arg_58_1.var_.characterEffect1094ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.2

			if var_61_2 <= arg_58_1.time_ and arg_58_1.time_ < var_61_2 + var_61_3 and not isNil(var_61_1) then
				local var_61_4 = (arg_58_1.time_ - var_61_2) / var_61_3

				if arg_58_1.var_.characterEffect1094ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= var_61_2 + var_61_3 and arg_58_1.time_ < var_61_2 + var_61_3 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1094ui_story then
				arg_58_1.var_.characterEffect1094ui_story.fillFlat = false
			end

			local var_61_5 = 0
			local var_61_6 = 0.2

			if var_61_5 < arg_58_1.time_ and arg_58_1.time_ <= var_61_5 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				local var_61_7 = arg_58_1:FormatText(StoryNameCfg[181].name)

				arg_58_1.leftNameTxt_.text = var_61_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_8 = arg_58_1:GetWordFromCfg(111102014)
				local var_61_9 = arg_58_1:FormatText(var_61_8.content)

				arg_58_1.text_.text = var_61_9

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_10 = 8
				local var_61_11 = utf8.len(var_61_9)
				local var_61_12 = var_61_10 <= 0 and var_61_6 or var_61_6 * (var_61_11 / var_61_10)

				if var_61_12 > 0 and var_61_6 < var_61_12 then
					arg_58_1.talkMaxDuration = var_61_12

					if var_61_12 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_12 + var_61_5
					end
				end

				arg_58_1.text_.text = var_61_9
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111102", "111102014", "story_v_out_111102.awb") ~= 0 then
					local var_61_13 = manager.audio:GetVoiceLength("story_v_out_111102", "111102014", "story_v_out_111102.awb") / 1000

					if var_61_13 + var_61_5 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_13 + var_61_5
					end

					if var_61_8.prefab_name ~= "" and arg_58_1.actors_[var_61_8.prefab_name] ~= nil then
						local var_61_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_8.prefab_name].transform, "story_v_out_111102", "111102014", "story_v_out_111102.awb")

						arg_58_1:RecordAudio("111102014", var_61_14)
						arg_58_1:RecordAudio("111102014", var_61_14)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_111102", "111102014", "story_v_out_111102.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_111102", "111102014", "story_v_out_111102.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_15 = math.max(var_61_6, arg_58_1.talkMaxDuration)

			if var_61_5 <= arg_58_1.time_ and arg_58_1.time_ < var_61_5 + var_61_15 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_5) / var_61_15

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_5 + var_61_15 and arg_58_1.time_ < var_61_5 + var_61_15 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play111102015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 111102015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
			arg_62_1.auto_ = false
		end

		function arg_62_1.playNext_(arg_64_0)
			arg_62_1.onStoryFinished_()
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = arg_62_1.actors_["1094ui_story"]
			local var_65_1 = 0

			if var_65_1 < arg_62_1.time_ and arg_62_1.time_ <= var_65_1 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1094ui_story == nil then
				arg_62_1.var_.characterEffect1094ui_story = var_65_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.2

			if var_65_1 <= arg_62_1.time_ and arg_62_1.time_ < var_65_1 + var_65_2 and not isNil(var_65_0) then
				local var_65_3 = (arg_62_1.time_ - var_65_1) / var_65_2

				if arg_62_1.var_.characterEffect1094ui_story and not isNil(var_65_0) then
					local var_65_4 = Mathf.Lerp(0, 0.5, var_65_3)

					arg_62_1.var_.characterEffect1094ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1094ui_story.fillRatio = var_65_4
				end
			end

			if arg_62_1.time_ >= var_65_1 + var_65_2 and arg_62_1.time_ < var_65_1 + var_65_2 + arg_65_0 and not isNil(var_65_0) and arg_62_1.var_.characterEffect1094ui_story then
				local var_65_5 = 0.5

				arg_62_1.var_.characterEffect1094ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1094ui_story.fillRatio = var_65_5
			end

			local var_65_6 = 0
			local var_65_7 = 0.9

			if var_65_6 < arg_62_1.time_ and arg_62_1.time_ <= var_65_6 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_8 = arg_62_1:GetWordFromCfg(111102015)
				local var_65_9 = arg_62_1:FormatText(var_65_8.content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_10 = 36
				local var_65_11 = utf8.len(var_65_9)
				local var_65_12 = var_65_10 <= 0 and var_65_7 or var_65_7 * (var_65_11 / var_65_10)

				if var_65_12 > 0 and var_65_7 < var_65_12 then
					arg_62_1.talkMaxDuration = var_65_12

					if var_65_12 + var_65_6 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_12 + var_65_6
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_13 = math.max(var_65_7, arg_62_1.talkMaxDuration)

			if var_65_6 <= arg_62_1.time_ and arg_62_1.time_ < var_65_6 + var_65_13 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_6) / var_65_13

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_6 + var_65_13 and arg_62_1.time_ < var_65_6 + var_65_13 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/D06b"
	},
	voices = {
		"story_v_out_111102.awb"
	}
}
