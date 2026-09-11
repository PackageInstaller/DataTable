return {
	Play116032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 116032001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play116032002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I05f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I05f")
				var_4_0.name = "I05f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I05f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I05f

				arg_1_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I05f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 1.999999999999

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_10 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_10 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_10

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_10
						arg_1_1.bgmTxt2_.text = var_4_10
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

			local var_4_11 = 1.999999999999
			local var_4_12 = 0.825

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_13 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_13:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_14 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(116032001).content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)

				if (33 <= 0 and var_4_12 or var_4_12 * (utf8.len(var_4_14) / 33)) > 0 and var_4_12 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_11 = var_4_11 + 0.3

					if var_4_16 + var_4_11 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_11
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_17 = var_4_11 + 0.3
			local var_4_18 = math.max(var_4_12, arg_1_1.talkMaxDuration)

			if var_4_11 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_17 + var_4_18 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_17) / var_4_18

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_17 + var_4_18 and arg_1_1.time_ < var_4_17 + var_4_18 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play116032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 116032002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play116032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			local var_11_0 = 0.125

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_1 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(116032002).content)

				arg_8_1.text_.text = var_11_1

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_3 = 5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 5)

				if (5 <= 0 and var_11_0 or var_11_0 * (utf8.len(var_11_1) / 5)) > 0 and var_11_0 < var_11_3 then
					arg_8_1.talkMaxDuration = var_11_3

					if var_11_3 + 0 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_3 + 0
					end
				end

				arg_8_1.text_.text = var_11_1
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_4 = math.max(var_11_0, arg_8_1.talkMaxDuration)

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - 0) / var_11_4

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play116032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 116032003
		arg_12_1.duration_ = 2

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play116032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1029ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1029ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1029ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1029ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1029ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1029ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1029ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1029ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1029ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1029ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -1.09, -6.2)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_15_5 = arg_12_1.actors_["1029ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1029ui_story == nil then
				arg_12_1.var_.characterEffect1029ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1029ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1029ui_story then
				arg_12_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_15_8 = 0
			local var_15_9 = 0.075

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_8 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_10 = arg_12_1:GetWordFromCfg(116032003)
				local var_15_11 = arg_12_1:FormatText(var_15_10.content)

				arg_12_1.text_.text = var_15_11

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_13 = 3 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 3)

				if (3 <= 0 and var_15_9 or var_15_9 * (utf8.len(var_15_11) / 3)) > 0 and var_15_9 < var_15_13 then
					arg_12_1.talkMaxDuration = var_15_13

					if var_15_13 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_13 + var_15_8
					end
				end

				arg_12_1.text_.text = var_15_11
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032003", "story_v_out_116032.awb") ~= 0 then
					local var_15_14 = manager.audio:GetVoiceLength("story_v_out_116032", "116032003", "story_v_out_116032.awb") / 1000

					if var_15_14 + var_15_8 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_14 + var_15_8
					end

					if var_15_10.prefab_name ~= "" and arg_12_1.actors_[var_15_10.prefab_name] ~= nil then
						local var_15_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_10.prefab_name].transform, "story_v_out_116032", "116032003", "story_v_out_116032.awb")

						arg_12_1:RecordAudio("116032003", var_15_15)
						arg_12_1:RecordAudio("116032003", var_15_15)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_116032", "116032003", "story_v_out_116032.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_116032", "116032003", "story_v_out_116032.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_16 = math.max(var_15_9, arg_12_1.talkMaxDuration)

			if var_15_8 <= arg_12_1.time_ and arg_12_1.time_ < var_15_8 + var_15_16 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_8) / var_15_16

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_8 + var_15_16 and arg_12_1.time_ < var_15_8 + var_15_16 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
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
	Play116032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 116032004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play116032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1029ui_story = arg_16_1.actors_["1029ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1029ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1029ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1029ui_story"].transform.position).z)
				arg_16_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1029ui_story"].transform.localEulerAngles = arg_16_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1029ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1029ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1029ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1029ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1029ui_story"].transform.position).z)
				arg_16_1.actors_["1029ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1029ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1029ui_story"].transform.localEulerAngles = arg_16_1.actors_["1029ui_story"].transform.localEulerAngles
			end

			local var_19_1 = 0
			local var_19_2 = 1.075

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(116032004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 43 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 43)

				if (43 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 43)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play116032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 116032005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play116032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 1.625

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(116032005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 65 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 65)

				if (65 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 65)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play116032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 116032006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play116032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 1.15

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(116032006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 46 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 46)

				if (46 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 46)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play116032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 116032007
		arg_28_1.duration_ = 13.13

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play116032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.bgs_.SK0102 == nil then
				local var_31_0 = Object.Instantiate(arg_28_1.paintGo_)

				var_31_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SK0102")
				var_31_0.name = "SK0102"
				var_31_0.transform.parent = arg_28_1.stage_.transform
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.bgs_.SK0102 = var_31_0
			end

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= 2 + arg_31_0 then
				local var_31_1 = arg_28_1.bgs_.SK0102

				arg_28_1.bgs_.SK0102.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_31_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_31_2 = var_31_1:GetComponent("SpriteRenderer")

				if var_31_2 and var_31_2.sprite then
					local var_31_3 = 2 * (var_31_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_31_1.transform.localScale = Vector3.New(var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, var_31_3 / var_31_2.sprite.bounds.size.y < var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x and var_31_3 * manager.ui.mainCameraCom_.aspect / var_31_2.sprite.bounds.size.x or var_31_3 / var_31_2.sprite.bounds.size.y, 0)
				end

				for iter_31_0, iter_31_1 in pairs(arg_28_1.bgs_) do
					if iter_31_0 ~= "SK0102" then
						iter_31_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_31_4 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_5 = 2

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_5 then
				local var_31_6 = Color.New(0, 0, 0)

				var_31_6.a = Mathf.Lerp(0, 1, (arg_28_1.time_ - var_31_4) / var_31_5)
				arg_28_1.mask_.color = var_31_6
			end

			if arg_28_1.time_ >= var_31_4 + var_31_5 and arg_28_1.time_ < var_31_4 + var_31_5 + arg_31_0 then
				local var_31_7 = Color.New(0, 0, 0)

				var_31_7.a = 1
				arg_28_1.mask_.color = var_31_7
			end

			local var_31_8 = 2

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.mask_.enabled = true
				arg_28_1.mask_.raycastTarget = true

				arg_28_1:SetGaussion(false)
			end

			local var_31_9 = 2

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_9 then
				local var_31_10 = Color.New(0, 0, 0)

				var_31_10.a = Mathf.Lerp(1, 0, (arg_28_1.time_ - var_31_8) / var_31_9)
				arg_28_1.mask_.color = var_31_10
			end

			if arg_28_1.time_ >= var_31_8 + var_31_9 and arg_28_1.time_ < var_31_8 + var_31_9 + arg_31_0 then
				local var_31_11 = Color.New(0, 0, 0)

				arg_28_1.mask_.enabled = false
				var_31_11.a = 0
				arg_28_1.mask_.color = var_31_11
			end

			local var_31_12 = arg_28_1.bgs_.SK0102.transform

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= 2 + arg_31_0 then
				arg_28_1.var_.moveOldPosSK0102 = var_31_12.localPosition
			end

			local var_31_13 = 0.001

			if 2 <= arg_28_1.time_ and arg_28_1.time_ < 2 + var_31_13 then
				var_31_12.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPosSK0102, Vector3.New(-0.5, 1.5, 5), (arg_28_1.time_ - 2) / var_31_13)
			end

			if arg_28_1.time_ >= 2 + var_31_13 and arg_28_1.time_ < 2 + var_31_13 + arg_31_0 then
				var_31_12.localPosition = Vector3.New(-0.5, 1.5, 5)
			end

			local var_31_14 = arg_28_1.bgs_.SK0102.transform

			if 2.034 < arg_28_1.time_ and arg_28_1.time_ <= 2.034 + arg_31_0 then
				arg_28_1.var_.moveOldPosSK0102 = var_31_14.localPosition
			end

			local var_31_15 = 6

			if 2.034 <= arg_28_1.time_ and arg_28_1.time_ < 2.034 + var_31_15 then
				var_31_14.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPosSK0102, Vector3.New(-0.5, 1, 5), (arg_28_1.time_ - 2.034) / var_31_15)
			end

			if arg_28_1.time_ >= 2.034 + var_31_15 and arg_28_1.time_ < 2.034 + var_31_15 + arg_31_0 then
				var_31_14.localPosition = Vector3.New(-0.5, 1, 5)
			end

			local var_31_16 = 4

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_16 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_16 + 4.034 and arg_28_1.time_ < var_31_16 + 4.034 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_31_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_19 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_19

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_19
						arg_28_1.bgmTxt2_.text = var_31_19
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_28_1.time_ and arg_28_1.time_ <= 2 + arg_31_0 then
				arg_28_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_31_22 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_28_1.bgmTxt_.text ~= var_31_22 and arg_28_1.bgmTxt_.text ~= "" then
						if arg_28_1.bgmTxt2_.text ~= "" then
							arg_28_1.bgmTxt_.text = arg_28_1.bgmTxt2_.text
						end

						arg_28_1.bgmTxt2_.text = var_31_22

						arg_28_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_28_1.bgmTxt_.text = var_31_22
						arg_28_1.bgmTxt2_.text = var_31_22
					end

					if arg_28_1.bgmTimer then
						arg_28_1.bgmTimer:Stop()

						arg_28_1.bgmTimer = nil
					end

					if arg_28_1.settingData.show_music_name == 1 then
						arg_28_1.musicController:SetSelectedState("show")
						arg_28_1.musicAnimator_:Play("open", 0, 0)

						if arg_28_1.settingData.music_time ~= 0 then
							arg_28_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_28_1.settingData.music_time), function()
								if arg_28_1 == nil or isNil(arg_28_1.bgmTxt_) then
									return
								end

								arg_28_1.musicController:SetSelectedState("hide")
								arg_28_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_23 = 4
			local var_31_24 = 0.5

			if 4 < arg_28_1.time_ and arg_28_1.time_ <= var_31_23 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_25 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_25:setOnUpdate(LuaHelper.FloatAction(function(arg_34_0)
					arg_28_1.dialogCg_.alpha = arg_34_0
				end))
				var_31_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_26 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(116032007).content)

				arg_28_1.text_.text = var_31_26

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_28 = 20 <= 0 and var_31_24 or var_31_24 * (utf8.len(var_31_26) / 20)

				if (20 <= 0 and var_31_24 or var_31_24 * (utf8.len(var_31_26) / 20)) > 0 and var_31_24 < var_31_28 then
					arg_28_1.talkMaxDuration = var_31_28
					var_31_23 = var_31_23 + 0.3

					if var_31_28 + var_31_23 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_28 + var_31_23
					end
				end

				arg_28_1.text_.text = var_31_26
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_29 = var_31_23 + 0.3
			local var_31_30 = math.max(var_31_24, arg_28_1.talkMaxDuration)

			if var_31_23 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_29 + var_31_30 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_29) / var_31_30

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_29 + var_31_30 and arg_28_1.time_ < var_31_29 + var_31_30 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SK0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 6,
				className = "StoryMoveNode",
				startTime = 2.034,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play116032008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 116032008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play116032009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.9

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(116032008).content)

				arg_36_1.text_.text = var_39_1

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_3 = 36 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 36)

				if (36 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_1) / 36)) > 0 and var_39_0 < var_39_3 then
					arg_36_1.talkMaxDuration = var_39_3

					if var_39_3 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_3 + 0
					end
				end

				arg_36_1.text_.text = var_39_1
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_4 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_4

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play116032009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 116032009
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play116032010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.375

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(116032009).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 15 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 15)

				if (15 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 15)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play116032010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 116032010
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play116032011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.45

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(116032010).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 58 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 58)

				if (58 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 58)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play116032011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 116032011
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play116032012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(116032011).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 15 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 15)

				if (15 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 15)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play116032012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 116032012
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play116032013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.475

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(116032012).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 19 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 19)

				if (19 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 19)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play116032013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 116032013
		arg_56_1.duration_ = 12.87

		local var_56_0 = {
			zh = 12.3,
			ja = 12.866
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play116032014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_0 = 2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				local var_59_1 = Color.New(0, 0, 0)

				var_59_1.a = Mathf.Lerp(0, 1, (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.mask_.color = var_59_1
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				local var_59_2 = Color.New(0, 0, 0)

				var_59_2.a = 1
				arg_56_1.mask_.color = var_59_2
			end

			local var_59_3 = 2

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_4 = 2

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_4 then
				local var_59_5 = Color.New(0, 0, 0)

				var_59_5.a = Mathf.Lerp(1, 0, (arg_56_1.time_ - var_59_3) / var_59_4)
				arg_56_1.mask_.color = var_59_5
			end

			if arg_56_1.time_ >= var_59_3 + var_59_4 and arg_56_1.time_ < var_59_3 + var_59_4 + arg_59_0 then
				local var_59_6 = Color.New(0, 0, 0)

				arg_56_1.mask_.enabled = false
				var_59_6.a = 0
				arg_56_1.mask_.color = var_59_6
			end

			local var_59_7 = arg_56_1.bgs_.SK0102.transform

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= 2 + arg_59_0 then
				arg_56_1.var_.moveOldPosSK0102 = var_59_7.localPosition
			end

			local var_59_8 = 0.001

			if 2 <= arg_56_1.time_ and arg_56_1.time_ < 2 + var_59_8 then
				var_59_7.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosSK0102, Vector3.New(0, 1, 10), (arg_56_1.time_ - 2) / var_59_8)
			end

			if arg_56_1.time_ >= 2 + var_59_8 and arg_56_1.time_ < 2 + var_59_8 + arg_59_0 then
				var_59_7.localPosition = Vector3.New(0, 1, 10)
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_9 = 4
			local var_59_10 = 0.625

			if 4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_9 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_11 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_11:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_12 = arg_56_1:GetWordFromCfg(116032013)
				local var_59_13 = arg_56_1:FormatText(var_59_12.content)

				arg_56_1.text_.text = var_59_13

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_15 = 25 <= 0 and var_59_10 or var_59_10 * (utf8.len(var_59_13) / 25)

				if (25 <= 0 and var_59_10 or var_59_10 * (utf8.len(var_59_13) / 25)) > 0 and var_59_10 < var_59_15 then
					arg_56_1.talkMaxDuration = var_59_15
					var_59_9 = var_59_9 + 0.3

					if var_59_15 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_15 + var_59_9
					end
				end

				arg_56_1.text_.text = var_59_13
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032013", "story_v_out_116032.awb") ~= 0 then
					local var_59_16 = manager.audio:GetVoiceLength("story_v_out_116032", "116032013", "story_v_out_116032.awb") / 1000

					if var_59_16 + var_59_9 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_16 + var_59_9
					end

					if var_59_12.prefab_name ~= "" and arg_56_1.actors_[var_59_12.prefab_name] ~= nil then
						local var_59_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_12.prefab_name].transform, "story_v_out_116032", "116032013", "story_v_out_116032.awb")

						arg_56_1:RecordAudio("116032013", var_59_17)
						arg_56_1:RecordAudio("116032013", var_59_17)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_116032", "116032013", "story_v_out_116032.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_116032", "116032013", "story_v_out_116032.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_18 = var_59_9 + 0.3
			local var_59_19 = math.max(var_59_10, arg_56_1.talkMaxDuration)

			if var_59_9 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_18 + var_59_19 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_18) / var_59_19

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_18 + var_59_19 and arg_56_1.time_ < var_59_18 + var_59_19 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SK0102",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play116032014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 116032014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play116032015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.2

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(116032014).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 8 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 8)

				if (8 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 8)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play116032015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 116032015
		arg_66_1.duration_ = 7.33

		local var_66_0 = {
			zh = 3.866,
			ja = 7.333
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play116032016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.325

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(116032015)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 13 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 13)

				if (13 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 13)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032015", "story_v_out_116032.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_116032", "116032015", "story_v_out_116032.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_116032", "116032015", "story_v_out_116032.awb")

						arg_66_1:RecordAudio("116032015", var_69_6)
						arg_66_1:RecordAudio("116032015", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_116032", "116032015", "story_v_out_116032.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_116032", "116032015", "story_v_out_116032.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_7 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_7 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_7

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_7 and arg_66_1.time_ < 0 + var_69_7 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play116032016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 116032016
		arg_70_1.duration_ = 5.23

		local var_70_0 = {
			zh = 5.233,
			ja = 3.266
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play116032017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.5

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_70_1.callingController_:SetSelectedState("normal")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:GetWordFromCfg(116032016)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 20 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 20)

				if (20 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 20)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032016", "story_v_out_116032.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_116032", "116032016", "story_v_out_116032.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_116032", "116032016", "story_v_out_116032.awb")

						arg_70_1:RecordAudio("116032016", var_73_6)
						arg_70_1:RecordAudio("116032016", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_116032", "116032016", "story_v_out_116032.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_116032", "116032016", "story_v_out_116032.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play116032017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 116032017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play116032018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.225

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(116032017).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 9 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 9)

				if (9 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 9)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play116032018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 116032018
		arg_78_1.duration_ = 4.47

		local var_78_0 = {
			zh = 4.466,
			ja = 3.5
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play116032019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.35

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1029")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_1 = arg_78_1:GetWordFromCfg(116032018)
				local var_81_2 = arg_78_1:FormatText(var_81_1.content)

				arg_78_1.text_.text = var_81_2

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_4 = 14 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 14)

				if (14 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_2) / 14)) > 0 and var_81_0 < var_81_4 then
					arg_78_1.talkMaxDuration = var_81_4

					if var_81_4 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_4 + 0
					end
				end

				arg_78_1.text_.text = var_81_2
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032018", "story_v_out_116032.awb") ~= 0 then
					local var_81_5 = manager.audio:GetVoiceLength("story_v_out_116032", "116032018", "story_v_out_116032.awb") / 1000

					if var_81_5 + 0 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_5 + 0
					end

					if var_81_1.prefab_name ~= "" and arg_78_1.actors_[var_81_1.prefab_name] ~= nil then
						local var_81_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_1.prefab_name].transform, "story_v_out_116032", "116032018", "story_v_out_116032.awb")

						arg_78_1:RecordAudio("116032018", var_81_6)
						arg_78_1:RecordAudio("116032018", var_81_6)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_116032", "116032018", "story_v_out_116032.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_116032", "116032018", "story_v_out_116032.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_7 = math.max(var_81_0, arg_78_1.talkMaxDuration)

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - 0) / var_81_7

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play116032019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 116032019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play116032020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.4

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_82_1.callingController_:SetSelectedState("normal")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(116032019).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 16 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 16)

				if (16 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 16)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play116032020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 116032020
		arg_86_1.duration_ = 7.53

		local var_86_0 = {
			zh = 7.533,
			ja = 5.6
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play116032021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.475

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_1 = arg_86_1:GetWordFromCfg(116032020)
				local var_89_2 = arg_86_1:FormatText(var_89_1.content)

				arg_86_1.text_.text = var_89_2

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_4 = 19 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 19)

				if (19 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_2) / 19)) > 0 and var_89_0 < var_89_4 then
					arg_86_1.talkMaxDuration = var_89_4

					if var_89_4 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_4 + 0
					end
				end

				arg_86_1.text_.text = var_89_2
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032020", "story_v_out_116032.awb") ~= 0 then
					local var_89_5 = manager.audio:GetVoiceLength("story_v_out_116032", "116032020", "story_v_out_116032.awb") / 1000

					if var_89_5 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + 0
					end

					if var_89_1.prefab_name ~= "" and arg_86_1.actors_[var_89_1.prefab_name] ~= nil then
						local var_89_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_1.prefab_name].transform, "story_v_out_116032", "116032020", "story_v_out_116032.awb")

						arg_86_1:RecordAudio("116032020", var_89_6)
						arg_86_1:RecordAudio("116032020", var_89_6)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_116032", "116032020", "story_v_out_116032.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_116032", "116032020", "story_v_out_116032.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_7 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_7

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play116032021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 116032021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play116032022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 0.575

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(116032021).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 23 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 23)

				if (23 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 23)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play116032022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 116032022
		arg_94_1.duration_ = 10.37

		local var_94_0 = {
			zh = 10.366,
			ja = 9
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play116032023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 2 < arg_94_1.time_ and arg_94_1.time_ <= 2 + arg_97_0 then
				if arg_94_0.sceneSettingEffect_ then
					arg_94_1.sceneSettingEffect_.enabled = false
				end

				arg_94_1.sceneSettingGo_:SetActive(true)

				local var_97_0 = arg_94_1.bgs_.I05f

				arg_94_1.bgs_.I05f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_1 = var_97_0:GetComponent("SpriteRenderer")

				if var_97_1 and var_97_1.sprite then
					local var_97_2 = 2 * (var_97_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_0.transform.localScale = Vector3.New(var_97_2 / var_97_1.sprite.bounds.size.y < var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x and var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x or var_97_2 / var_97_1.sprite.bounds.size.y, var_97_2 / var_97_1.sprite.bounds.size.y < var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x and var_97_2 * manager.ui.mainCameraCom_.aspect / var_97_1.sprite.bounds.size.x or var_97_2 / var_97_1.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "I05f" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_3 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_3 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_4 = 2

			if var_97_3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_3 + var_97_4 then
				local var_97_5 = Color.New(0, 0, 0)

				var_97_5.a = Mathf.Lerp(0, 1, (arg_94_1.time_ - var_97_3) / var_97_4)
				arg_94_1.mask_.color = var_97_5
			end

			if arg_94_1.time_ >= var_97_3 + var_97_4 and arg_94_1.time_ < var_97_3 + var_97_4 + arg_97_0 then
				local var_97_6 = Color.New(0, 0, 0)

				var_97_6.a = 1
				arg_94_1.mask_.color = var_97_6
			end

			local var_97_7 = 2

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_7 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_8 = 2

			if var_97_7 <= arg_94_1.time_ and arg_94_1.time_ < var_97_7 + var_97_8 then
				local var_97_9 = Color.New(0, 0, 0)

				var_97_9.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_7) / var_97_8)
				arg_94_1.mask_.color = var_97_9
			end

			if arg_94_1.time_ >= var_97_7 + var_97_8 and arg_94_1.time_ < var_97_7 + var_97_8 + arg_97_0 then
				local var_97_10 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_10.a = 0
				arg_94_1.mask_.color = var_97_10
			end

			local var_97_11 = arg_94_1.actors_["1029ui_story"].transform

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= 4 + arg_97_0 then
				arg_94_1.var_.moveOldPos1029ui_story = var_97_11.localPosition
			end

			local var_97_12 = 0.001

			if 4 <= arg_94_1.time_ and arg_94_1.time_ < 4 + var_97_12 then
				var_97_11.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1029ui_story, Vector3.New(0, -1.09, -6.2), (arg_94_1.time_ - 4) / var_97_12)
				var_97_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_11.position).x, (manager.ui.mainCamera.transform.position - var_97_11.position).y, (manager.ui.mainCamera.transform.position - var_97_11.position).z)
				var_97_11.localEulerAngles.z = 0
				var_97_11.localEulerAngles.x = 0
				var_97_11.localEulerAngles = var_97_11.localEulerAngles
			end

			if arg_94_1.time_ >= 4 + var_97_12 and arg_94_1.time_ < 4 + var_97_12 + arg_97_0 then
				var_97_11.localPosition = Vector3.New(0, -1.09, -6.2)
				var_97_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_11.position).x, (manager.ui.mainCamera.transform.position - var_97_11.position).y, (manager.ui.mainCamera.transform.position - var_97_11.position).z)
				var_97_11.localEulerAngles.z = 0
				var_97_11.localEulerAngles.x = 0
				var_97_11.localEulerAngles = var_97_11.localEulerAngles
			end

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= 4 + arg_97_0 then
				arg_94_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= 4 + arg_97_0 then
				arg_94_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_97_13 = arg_94_1.actors_["1029ui_story"]

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= 4 + arg_97_0 and not isNil(var_97_13) and arg_94_1.var_.characterEffect1029ui_story == nil then
				arg_94_1.var_.characterEffect1029ui_story = var_97_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_14 = 0.2

			if 4 <= arg_94_1.time_ and arg_94_1.time_ < 4 + var_97_14 and not isNil(var_97_13) then
				if arg_94_1.var_.characterEffect1029ui_story and not isNil(var_97_13) then
					arg_94_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 4 + var_97_14 and arg_94_1.time_ < 4 + var_97_14 + arg_97_0 and not isNil(var_97_13) and arg_94_1.var_.characterEffect1029ui_story then
				arg_94_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_16 = 4
			local var_97_17 = 0.575

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_16 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_18 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_18:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_19 = arg_94_1:GetWordFromCfg(116032022)
				local var_97_20 = arg_94_1:FormatText(var_97_19.content)

				arg_94_1.text_.text = var_97_20

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_22 = 23 <= 0 and var_97_17 or var_97_17 * (utf8.len(var_97_20) / 23)

				if (23 <= 0 and var_97_17 or var_97_17 * (utf8.len(var_97_20) / 23)) > 0 and var_97_17 < var_97_22 then
					arg_94_1.talkMaxDuration = var_97_22
					var_97_16 = var_97_16 + 0.3

					if var_97_22 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_22 + var_97_16
					end
				end

				arg_94_1.text_.text = var_97_20
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032022", "story_v_out_116032.awb") ~= 0 then
					local var_97_23 = manager.audio:GetVoiceLength("story_v_out_116032", "116032022", "story_v_out_116032.awb") / 1000

					if var_97_23 + var_97_16 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_23 + var_97_16
					end

					if var_97_19.prefab_name ~= "" and arg_94_1.actors_[var_97_19.prefab_name] ~= nil then
						local var_97_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_19.prefab_name].transform, "story_v_out_116032", "116032022", "story_v_out_116032.awb")

						arg_94_1:RecordAudio("116032022", var_97_24)
						arg_94_1:RecordAudio("116032022", var_97_24)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_116032", "116032022", "story_v_out_116032.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_116032", "116032022", "story_v_out_116032.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_25 = var_97_16 + 0.3
			local var_97_26 = math.max(var_97_17, arg_94_1.talkMaxDuration)

			if var_97_16 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_25 + var_97_26 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_25) / var_97_26

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_25 + var_97_26 and arg_94_1.time_ < var_97_25 + var_97_26 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play116032023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 116032023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play116032024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1029ui_story"]) and arg_100_1.var_.characterEffect1029ui_story == nil then
				arg_100_1.var_.characterEffect1029ui_story = arg_100_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1029ui_story"]) then
				if arg_100_1.var_.characterEffect1029ui_story and not isNil(arg_100_1.actors_["1029ui_story"]) then
					arg_100_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_100_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1029ui_story"]) and arg_100_1.var_.characterEffect1029ui_story then
				arg_100_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_100_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.25

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(116032023).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 10 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 10)

				if (10 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 10)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play116032024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 116032024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play116032025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(116032024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 40 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 40)

				if (40 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 40)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play116032025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 116032025
		arg_108_1.duration_ = 2

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play116032026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action1_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_111_0 = arg_108_1.actors_["1029ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1029ui_story == nil then
				arg_108_1.var_.characterEffect1029ui_story = var_111_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_1 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 and not isNil(var_111_0) then
				if arg_108_1.var_.characterEffect1029ui_story and not isNil(var_111_0) then
					arg_108_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 and not isNil(var_111_0) and arg_108_1.var_.characterEffect1029ui_story then
				arg_108_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_111_3 = arg_108_1.actors_["1029ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1029ui_story = var_111_3.localPosition

				arg_108_1:ShowWeapon(arg_108_1.var_["1029ui_story" .. "Animator"].transform, true)
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_108_1.time_ - 0) / var_111_4)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			local var_111_5 = "1028ui_story"

			if arg_108_1.actors_["1028ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1028ui_story"))) then
				local var_111_6 = Object.Instantiate(Asset.Load("Char/" .. "1028ui_story"), arg_108_1.stage_.transform)

				var_111_6.name = var_111_5
				var_111_6.transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_[var_111_5] = var_111_6

				local var_111_7 = var_111_6:GetComponentInChildren(typeof(CharacterEffect))

				var_111_7.enabled = true

				local var_111_8 = GameObjectTools.GetOrAddComponent(var_111_6, typeof(DynamicBoneHelper))

				if var_111_8 then
					var_111_8:EnableDynamicBone(false)
				end

				arg_108_1:ShowWeapon(var_111_7.transform, false)

				arg_108_1.var_[var_111_5 .. "Animator"] = var_111_7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_108_1.var_[var_111_5 .. "Animator"].applyRootMotion = true
				arg_108_1.var_[var_111_5 .. "LipSync"] = var_111_7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_111_9 = arg_108_1.actors_["1028ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1028ui_story = var_111_9.localPosition

				arg_108_1:ShowWeapon(arg_108_1.var_["1028ui_story" .. "Animator"].transform, true)
			end

			local var_111_10 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_10 then
				var_111_9.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_108_1.time_ - 0) / var_111_10)
				var_111_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_9.position).x, (manager.ui.mainCamera.transform.position - var_111_9.position).y, (manager.ui.mainCamera.transform.position - var_111_9.position).z)
				var_111_9.localEulerAngles.z = 0
				var_111_9.localEulerAngles.x = 0
				var_111_9.localEulerAngles = var_111_9.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_10 and arg_108_1.time_ < 0 + var_111_10 + arg_111_0 then
				var_111_9.localPosition = Vector3.New(0.7, -0.9, -5.9)
				var_111_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_9.position).x, (manager.ui.mainCamera.transform.position - var_111_9.position).y, (manager.ui.mainCamera.transform.position - var_111_9.position).z)
				var_111_9.localEulerAngles.z = 0
				var_111_9.localEulerAngles.x = 0
				var_111_9.localEulerAngles = var_111_9.localEulerAngles
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action1_1")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_111_11 = 0
			local var_111_12 = 0.1

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_11 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_13 = arg_108_1:GetWordFromCfg(116032025)
				local var_111_14 = arg_108_1:FormatText(var_111_13.content)

				arg_108_1.text_.text = var_111_14

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_16 = 4 <= 0 and var_111_12 or var_111_12 * (utf8.len(var_111_14) / 4)

				if (4 <= 0 and var_111_12 or var_111_12 * (utf8.len(var_111_14) / 4)) > 0 and var_111_12 < var_111_16 then
					arg_108_1.talkMaxDuration = var_111_16

					if var_111_16 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_11
					end
				end

				arg_108_1.text_.text = var_111_14
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032025", "story_v_out_116032.awb") ~= 0 then
					local var_111_17 = manager.audio:GetVoiceLength("story_v_out_116032", "116032025", "story_v_out_116032.awb") / 1000

					if var_111_17 + var_111_11 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_17 + var_111_11
					end

					if var_111_13.prefab_name ~= "" and arg_108_1.actors_[var_111_13.prefab_name] ~= nil then
						local var_111_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_13.prefab_name].transform, "story_v_out_116032", "116032025", "story_v_out_116032.awb")

						arg_108_1:RecordAudio("116032025", var_111_18)
						arg_108_1:RecordAudio("116032025", var_111_18)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_116032", "116032025", "story_v_out_116032.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_116032", "116032025", "story_v_out_116032.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_19 = math.max(var_111_12, arg_108_1.talkMaxDuration)

			if var_111_11 <= arg_108_1.time_ and arg_108_1.time_ < var_111_11 + var_111_19 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_11) / var_111_19

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_11 + var_111_19 and arg_108_1.time_ < var_111_11 + var_111_19 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play116032026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 116032026
		arg_112_1.duration_ = 4.47

		local var_112_0 = {
			zh = 2.733,
			ja = 4.466
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play116032027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1029ui_story"]) and arg_112_1.var_.characterEffect1029ui_story == nil then
				arg_112_1.var_.characterEffect1029ui_story = arg_112_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1029ui_story"]) then
				if arg_112_1.var_.characterEffect1029ui_story and not isNil(arg_112_1.actors_["1029ui_story"]) then
					arg_112_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_0)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1029ui_story"]) and arg_112_1.var_.characterEffect1029ui_story then
				arg_112_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_115_1 = arg_112_1.actors_["1028ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1028ui_story = var_115_1.localPosition

				arg_112_1:ShowWeapon(arg_112_1.var_["1028ui_story" .. "Animator"].transform, true)
			end

			local var_115_2 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 then
				var_115_1.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1028ui_story, Vector3.New(0.7, -0.9, -5.9), (arg_112_1.time_ - 0) / var_115_2)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 then
				var_115_1.localPosition = Vector3.New(0.7, -0.9, -5.9)
				var_115_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_1.position).x, (manager.ui.mainCamera.transform.position - var_115_1.position).y, (manager.ui.mainCamera.transform.position - var_115_1.position).z)
				var_115_1.localEulerAngles.z = 0
				var_115_1.localEulerAngles.x = 0
				var_115_1.localEulerAngles = var_115_1.localEulerAngles
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/story1028/story1028action/1028action2_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_115_3 = arg_112_1.actors_["1029ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1029ui_story == nil then
				arg_112_1.var_.characterEffect1029ui_story = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.2

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect1029ui_story and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_4)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect1029ui_story then
				arg_112_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			local var_115_5 = arg_112_1.actors_["1029ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1029ui_story = var_115_5.localPosition

				arg_112_1:ShowWeapon(arg_112_1.var_["1029ui_story" .. "Animator"].transform, true)
			end

			local var_115_6 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_6 then
				var_115_5.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1029ui_story, Vector3.New(-0.7, -1.09, -6.2), (arg_112_1.time_ - 0) / var_115_6)
				var_115_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_5.position).x, (manager.ui.mainCamera.transform.position - var_115_5.position).y, (manager.ui.mainCamera.transform.position - var_115_5.position).z)
				var_115_5.localEulerAngles.z = 0
				var_115_5.localEulerAngles.x = 0
				var_115_5.localEulerAngles = var_115_5.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_6 and arg_112_1.time_ < 0 + var_115_6 + arg_115_0 then
				var_115_5.localPosition = Vector3.New(-0.7, -1.09, -6.2)
				var_115_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_5.position).x, (manager.ui.mainCamera.transform.position - var_115_5.position).y, (manager.ui.mainCamera.transform.position - var_115_5.position).z)
				var_115_5.localEulerAngles.z = 0
				var_115_5.localEulerAngles.x = 0
				var_115_5.localEulerAngles = var_115_5.localEulerAngles
			end

			local var_115_7 = 0
			local var_115_8 = 0.25

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_7 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_9 = arg_112_1:GetWordFromCfg(116032026)
				local var_115_10 = arg_112_1:FormatText(var_115_9.content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_12 = 10 <= 0 and var_115_8 or var_115_8 * (utf8.len(var_115_10) / 10)

				if (10 <= 0 and var_115_8 or var_115_8 * (utf8.len(var_115_10) / 10)) > 0 and var_115_8 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_7 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_7
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032026", "story_v_out_116032.awb") ~= 0 then
					local var_115_13 = manager.audio:GetVoiceLength("story_v_out_116032", "116032026", "story_v_out_116032.awb") / 1000

					if var_115_13 + var_115_7 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_13 + var_115_7
					end

					if var_115_9.prefab_name ~= "" and arg_112_1.actors_[var_115_9.prefab_name] ~= nil then
						local var_115_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_9.prefab_name].transform, "story_v_out_116032", "116032026", "story_v_out_116032.awb")

						arg_112_1:RecordAudio("116032026", var_115_14)
						arg_112_1:RecordAudio("116032026", var_115_14)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_116032", "116032026", "story_v_out_116032.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_116032", "116032026", "story_v_out_116032.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_15 = math.max(var_115_8, arg_112_1.talkMaxDuration)

			if var_115_7 <= arg_112_1.time_ and arg_112_1.time_ < var_115_7 + var_115_15 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_7) / var_115_15

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_7 + var_115_15 and arg_112_1.time_ < var_115_7 + var_115_15 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1029ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play116032027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 116032027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play116032028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1028ui_story"]) and arg_116_1.var_.characterEffect1028ui_story == nil then
				arg_116_1.var_.characterEffect1028ui_story = arg_116_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.2

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1028ui_story"]) then
				if arg_116_1.var_.characterEffect1028ui_story and not isNil(arg_116_1.actors_["1028ui_story"]) then
					arg_116_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1028ui_story"]) and arg_116_1.var_.characterEffect1028ui_story then
				arg_116_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_119_1 = 0
			local var_119_2 = 0.45

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_1 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, true)
				arg_116_1.iconController_:SetSelectedState("hero")

				arg_116_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_116_1.callingController_:SetSelectedState("normal")

				arg_116_1.keyicon_.color = Color.New(1, 1, 1)
				arg_116_1.icon_.color = Color.New(1, 1, 1)

				local var_119_3 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(116032027).content)

				arg_116_1.text_.text = var_119_3

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_5 = 18 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 18)

				if (18 <= 0 and var_119_2 or var_119_2 * (utf8.len(var_119_3) / 18)) > 0 and var_119_2 < var_119_5 then
					arg_116_1.talkMaxDuration = var_119_5

					if var_119_5 + var_119_1 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + var_119_1
					end
				end

				arg_116_1.text_.text = var_119_3
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_6 = math.max(var_119_2, arg_116_1.talkMaxDuration)

			if var_119_1 <= arg_116_1.time_ and arg_116_1.time_ < var_119_1 + var_119_6 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_1) / var_119_6

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_1 + var_119_6 and arg_116_1.time_ < var_119_1 + var_119_6 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play116032028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 116032028
		arg_120_1.duration_ = 3.83

		local var_120_0 = {
			zh = 3.133,
			ja = 3.833
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play116032029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_123_0 = arg_120_1.actors_["1028ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1028ui_story == nil then
				arg_120_1.var_.characterEffect1028ui_story = var_123_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_1 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 and not isNil(var_123_0) then
				if arg_120_1.var_.characterEffect1028ui_story and not isNil(var_123_0) then
					arg_120_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 and not isNil(var_123_0) and arg_120_1.var_.characterEffect1028ui_story then
				arg_120_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_123_3 = 0
			local var_123_4 = 0.225

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_3 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_5 = arg_120_1:GetWordFromCfg(116032028)
				local var_123_6 = arg_120_1:FormatText(var_123_5.content)

				arg_120_1.text_.text = var_123_6

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_8 = 9 <= 0 and var_123_4 or var_123_4 * (utf8.len(var_123_6) / 9)

				if (9 <= 0 and var_123_4 or var_123_4 * (utf8.len(var_123_6) / 9)) > 0 and var_123_4 < var_123_8 then
					arg_120_1.talkMaxDuration = var_123_8

					if var_123_8 + var_123_3 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_3
					end
				end

				arg_120_1.text_.text = var_123_6
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032028", "story_v_out_116032.awb") ~= 0 then
					local var_123_9 = manager.audio:GetVoiceLength("story_v_out_116032", "116032028", "story_v_out_116032.awb") / 1000

					if var_123_9 + var_123_3 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_3
					end

					if var_123_5.prefab_name ~= "" and arg_120_1.actors_[var_123_5.prefab_name] ~= nil then
						local var_123_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_5.prefab_name].transform, "story_v_out_116032", "116032028", "story_v_out_116032.awb")

						arg_120_1:RecordAudio("116032028", var_123_10)
						arg_120_1:RecordAudio("116032028", var_123_10)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_116032", "116032028", "story_v_out_116032.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_116032", "116032028", "story_v_out_116032.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_11 = math.max(var_123_4, arg_120_1.talkMaxDuration)

			if var_123_3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_3 + var_123_11 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_3) / var_123_11

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_3 + var_123_11 and arg_120_1.time_ < var_123_3 + var_123_11 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play116032029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 116032029
		arg_124_1.duration_ = 2.47

		local var_124_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play116032030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/story1029/story1029action/1029action6_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_127_0 = arg_124_1.actors_["1029ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1029ui_story == nil then
				arg_124_1.var_.characterEffect1029ui_story = var_127_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_1 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_1 and not isNil(var_127_0) then
				if arg_124_1.var_.characterEffect1029ui_story and not isNil(var_127_0) then
					arg_124_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_1 and arg_124_1.time_ < 0 + var_127_1 + arg_127_0 and not isNil(var_127_0) and arg_124_1.var_.characterEffect1029ui_story then
				arg_124_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_127_3 = arg_124_1.actors_["1028ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1028ui_story == nil then
				arg_124_1.var_.characterEffect1028ui_story = var_127_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_4 = 0.2

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 and not isNil(var_127_3) then
				if arg_124_1.var_.characterEffect1028ui_story and not isNil(var_127_3) then
					arg_124_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_4)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 and not isNil(var_127_3) and arg_124_1.var_.characterEffect1028ui_story then
				arg_124_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_127_5 = 0
			local var_127_6 = 0.075

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_7 = arg_124_1:GetWordFromCfg(116032029)
				local var_127_8 = arg_124_1:FormatText(var_127_7.content)

				arg_124_1.text_.text = var_127_8

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 3 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 3)

				if (3 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 3)) > 0 and var_127_6 < var_127_10 then
					arg_124_1.talkMaxDuration = var_127_10

					if var_127_10 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_5
					end
				end

				arg_124_1.text_.text = var_127_8
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032029", "story_v_out_116032.awb") ~= 0 then
					local var_127_11 = manager.audio:GetVoiceLength("story_v_out_116032", "116032029", "story_v_out_116032.awb") / 1000

					if var_127_11 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_5
					end

					if var_127_7.prefab_name ~= "" and arg_124_1.actors_[var_127_7.prefab_name] ~= nil then
						local var_127_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_7.prefab_name].transform, "story_v_out_116032", "116032029", "story_v_out_116032.awb")

						arg_124_1:RecordAudio("116032029", var_127_12)
						arg_124_1:RecordAudio("116032029", var_127_12)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_116032", "116032029", "story_v_out_116032.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_116032", "116032029", "story_v_out_116032.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_13 = math.max(var_127_6, arg_124_1.talkMaxDuration)

			if var_127_5 <= arg_124_1.time_ and arg_124_1.time_ < var_127_5 + var_127_13 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_5) / var_127_13

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_5 + var_127_13 and arg_124_1.time_ < var_127_5 + var_127_13 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play116032030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 116032030
		arg_128_1.duration_ = 2.57

		local var_128_0 = {
			zh = 1.999999999999,
			ja = 2.566
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play116032031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1029ui_story"]) and arg_128_1.var_.characterEffect1029ui_story == nil then
				arg_128_1.var_.characterEffect1029ui_story = arg_128_1.actors_["1029ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1029ui_story"]) then
				if arg_128_1.var_.characterEffect1029ui_story and not isNil(arg_128_1.actors_["1029ui_story"]) then
					arg_128_1.var_.characterEffect1029ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1029ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_0)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1029ui_story"]) and arg_128_1.var_.characterEffect1029ui_story then
				arg_128_1.var_.characterEffect1029ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1029ui_story.fillRatio = 0.5
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1028ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_131_1 = arg_128_1.actors_["1028ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1028ui_story == nil then
				arg_128_1.var_.characterEffect1028ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1028ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1028ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1028ui_story then
				arg_128_1.var_.characterEffect1028ui_story.fillFlat = false
			end

			local var_131_4 = 0
			local var_131_5 = 0.15

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(116032030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 6 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 6)

				if (6 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 6)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032030", "story_v_out_116032.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_116032", "116032030", "story_v_out_116032.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_116032", "116032030", "story_v_out_116032.awb")

						arg_128_1:RecordAudio("116032030", var_131_11)
						arg_128_1:RecordAudio("116032030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_116032", "116032030", "story_v_out_116032.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_116032", "116032030", "story_v_out_116032.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play116032031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 116032031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play116032032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1028ui_story"]) and arg_132_1.var_.characterEffect1028ui_story == nil then
				arg_132_1.var_.characterEffect1028ui_story = arg_132_1.actors_["1028ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.2

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1028ui_story"]) then
				if arg_132_1.var_.characterEffect1028ui_story and not isNil(arg_132_1.actors_["1028ui_story"]) then
					arg_132_1.var_.characterEffect1028ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1028ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1028ui_story"]) and arg_132_1.var_.characterEffect1028ui_story then
				arg_132_1.var_.characterEffect1028ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1028ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.95

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_3 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(116032031).content)

				arg_132_1.text_.text = var_135_3

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_5 = 38 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 38)

				if (38 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_3) / 38)) > 0 and var_135_2 < var_135_5 then
					arg_132_1.talkMaxDuration = var_135_5

					if var_135_5 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_3
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_6 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_6 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_6

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_6 and arg_132_1.time_ < var_135_1 + var_135_6 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play116032032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 116032032
		arg_136_1.duration_ = 5.43

		local var_136_0 = {
			zh = 5.433,
			ja = 3
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
			arg_136_1.auto_ = false
		end

		function arg_136_1.playNext_(arg_138_0)
			arg_136_1.onStoryFinished_()
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1029ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_139_0 = arg_136_1.actors_["1029ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1029ui_story == nil then
				arg_136_1.var_.characterEffect1029ui_story = var_139_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_1 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 and not isNil(var_139_0) then
				if arg_136_1.var_.characterEffect1029ui_story and not isNil(var_139_0) then
					arg_136_1.var_.characterEffect1029ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 and not isNil(var_139_0) and arg_136_1.var_.characterEffect1029ui_story then
				arg_136_1.var_.characterEffect1029ui_story.fillFlat = false
			end

			local var_139_3 = 0
			local var_139_4 = 0.15

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_3 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[319].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_5 = arg_136_1:GetWordFromCfg(116032032)
				local var_139_6 = arg_136_1:FormatText(var_139_5.content)

				arg_136_1.text_.text = var_139_6

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_8 = 6 <= 0 and var_139_4 or var_139_4 * (utf8.len(var_139_6) / 6)

				if (6 <= 0 and var_139_4 or var_139_4 * (utf8.len(var_139_6) / 6)) > 0 and var_139_4 < var_139_8 then
					arg_136_1.talkMaxDuration = var_139_8

					if var_139_8 + var_139_3 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_3
					end
				end

				arg_136_1.text_.text = var_139_6
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116032", "116032032", "story_v_out_116032.awb") ~= 0 then
					local var_139_9 = manager.audio:GetVoiceLength("story_v_out_116032", "116032032", "story_v_out_116032.awb") / 1000

					if var_139_9 + var_139_3 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_3
					end

					if var_139_5.prefab_name ~= "" and arg_136_1.actors_[var_139_5.prefab_name] ~= nil then
						local var_139_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_5.prefab_name].transform, "story_v_out_116032", "116032032", "story_v_out_116032.awb")

						arg_136_1:RecordAudio("116032032", var_139_10)
						arg_136_1:RecordAudio("116032032", var_139_10)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_116032", "116032032", "story_v_out_116032.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_116032", "116032032", "story_v_out_116032.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_11 = math.max(var_139_4, arg_136_1.talkMaxDuration)

			if var_139_3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_3 + var_139_11 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_3) / var_139_11

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_3 + var_139_11 and arg_136_1.time_ < var_139_3 + var_139_11 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I05f",
		"TextureConfig/Background/SK0102"
	},
	voices = {
		"story_v_out_116032.awb"
	}
}
