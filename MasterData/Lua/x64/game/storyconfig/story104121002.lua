return {
	Play412102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 412102001
		arg_1_1.duration_ = 6

		local var_1_0 = {
			zh = 4.50000000298023,
			ja = 6.00000000298023
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play412102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST85b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST85b")
				var_4_0.name = "ST85b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST85b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST85b

				arg_1_1.bgs_.ST85b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST85b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.00000000298023

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1097ui_story"

			if arg_1_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1097ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1097ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.54, -6.3)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1097ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1097ui_story == nil then
				arg_1_1.var_.characterEffect1097ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1097ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1097ui_story then
				arg_1_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			local var_4_21 = 2.00000000298023
			local var_4_22 = 0.2

			if 2.00000000298023 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(412102001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 8 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 8)

				if (8 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 8)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102001", "story_v_out_412102.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_412102", "412102001", "story_v_out_412102.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_412102", "412102001", "story_v_out_412102.awb")

						arg_1_1:RecordAudio("412102001", var_4_29)
						arg_1_1:RecordAudio("412102001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_412102", "412102001", "story_v_out_412102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_412102", "412102001", "story_v_out_412102.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play412102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 412102002
		arg_8_1.duration_ = 2.13

		local var_8_0 = {
			zh = 2.133,
			ja = 2
		}
		local var_8_1 = manager.audio:GetLocalizationFlag()

		if var_8_0[var_8_1] ~= nil then
			arg_8_1.duration_ = var_8_0[var_8_1]
		end

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play412102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1097ui_story"]) and arg_8_1.var_.characterEffect1097ui_story == nil then
				arg_8_1.var_.characterEffect1097ui_story = arg_8_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1097ui_story"]) then
				if arg_8_1.var_.characterEffect1097ui_story and not isNil(arg_8_1.actors_["1097ui_story"]) then
					arg_8_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1097ui_story"]) and arg_8_1.var_.characterEffect1097ui_story then
				arg_8_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 0.2

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[913].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097_sheep")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(412102002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 8 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 8)

				if (8 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 8)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102002", "story_v_out_412102.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_412102", "412102002", "story_v_out_412102.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_412102", "412102002", "story_v_out_412102.awb")

						arg_8_1:RecordAudio("412102002", var_11_8)
						arg_8_1:RecordAudio("412102002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_412102", "412102002", "story_v_out_412102.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_412102", "412102002", "story_v_out_412102.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_9 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_9 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_9

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_9 and arg_8_1.time_ < var_11_1 + var_11_9 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play412102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 412102003
		arg_12_1.duration_ = 8.5

		local var_12_0 = {
			zh = 8.5,
			ja = 7.3
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play412102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1097ui_story"]) and arg_12_1.var_.characterEffect1097ui_story == nil then
				arg_12_1.var_.characterEffect1097ui_story = arg_12_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1097ui_story"]) then
				if arg_12_1.var_.characterEffect1097ui_story and not isNil(arg_12_1.actors_["1097ui_story"]) then
					arg_12_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1097ui_story"]) and arg_12_1.var_.characterEffect1097ui_story then
				arg_12_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_15_2 = 0
			local var_15_3 = 0.625

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_2 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_4 = arg_12_1:GetWordFromCfg(412102003)
				local var_15_5 = arg_12_1:FormatText(var_15_4.content)

				arg_12_1.text_.text = var_15_5

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_7 = 25 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 25)

				if (25 <= 0 and var_15_3 or var_15_3 * (utf8.len(var_15_5) / 25)) > 0 and var_15_3 < var_15_7 then
					arg_12_1.talkMaxDuration = var_15_7

					if var_15_7 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_7 + var_15_2
					end
				end

				arg_12_1.text_.text = var_15_5
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102003", "story_v_out_412102.awb") ~= 0 then
					local var_15_8 = manager.audio:GetVoiceLength("story_v_out_412102", "412102003", "story_v_out_412102.awb") / 1000

					if var_15_8 + var_15_2 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_8 + var_15_2
					end

					if var_15_4.prefab_name ~= "" and arg_12_1.actors_[var_15_4.prefab_name] ~= nil then
						local var_15_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_4.prefab_name].transform, "story_v_out_412102", "412102003", "story_v_out_412102.awb")

						arg_12_1:RecordAudio("412102003", var_15_9)
						arg_12_1:RecordAudio("412102003", var_15_9)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_412102", "412102003", "story_v_out_412102.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_412102", "412102003", "story_v_out_412102.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_10 = math.max(var_15_3, arg_12_1.talkMaxDuration)

			if var_15_2 <= arg_12_1.time_ and arg_12_1.time_ < var_15_2 + var_15_10 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_2) / var_15_10

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_2 + var_15_10 and arg_12_1.time_ < var_15_2 + var_15_10 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play412102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 412102004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play412102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1097ui_story = arg_16_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_19_0 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 then
				arg_16_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_0)
				arg_16_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1097ui_story"].transform.position).z)
				arg_16_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1097ui_story"].transform.localEulerAngles = arg_16_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 then
				arg_16_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["1097ui_story"].transform.position).z)
				arg_16_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["1097ui_story"].transform.localEulerAngles = arg_16_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_19_1 = arg_16_1.actors_["1097ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1097ui_story == nil then
				arg_16_1.var_.characterEffect1097ui_story = var_19_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_2 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 and not isNil(var_19_1) then
				if arg_16_1.var_.characterEffect1097ui_story and not isNil(var_19_1) then
					arg_16_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_2)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 and not isNil(var_19_1) and arg_16_1.var_.characterEffect1097ui_story then
				arg_16_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_19_3 = 0
			local var_19_4 = 0.2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(412102004).content)

				arg_16_1.text_.text = var_19_5

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_7 = 8 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 8)

				if (8 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_5) / 8)) > 0 and var_19_4 < var_19_7 then
					arg_16_1.talkMaxDuration = var_19_7

					if var_19_7 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_7 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_5
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_8 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_8 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_8

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_8 and arg_16_1.time_ < var_19_3 + var_19_8 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play412102005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 412102005
		arg_20_1.duration_ = 3.8

		local var_20_0 = {
			zh = 3.8,
			ja = 3.799999999999
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play412102006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.bgs_.ST30a == nil then
				local var_23_0 = Object.Instantiate(arg_20_1.paintGo_)

				var_23_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST30a")
				var_23_0.name = "ST30a"
				var_23_0.transform.parent = arg_20_1.stage_.transform
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.bgs_.ST30a = var_23_0
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				local var_23_1 = arg_20_1.bgs_.ST30a

				arg_20_1.bgs_.ST30a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_23_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_23_2 = var_23_1:GetComponent("SpriteRenderer")

				if var_23_2 and var_23_2.sprite then
					local var_23_3 = 2 * (var_23_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_23_1.transform.localScale = Vector3.New(var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, var_23_3 / var_23_2.sprite.bounds.size.y < var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x and var_23_3 * manager.ui.mainCameraCom_.aspect / var_23_2.sprite.bounds.size.x or var_23_3 / var_23_2.sprite.bounds.size.y, 0)
				end

				for iter_23_0, iter_23_1 in pairs(arg_20_1.bgs_) do
					if iter_23_0 ~= "ST30a" then
						iter_23_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_23_4 = 2

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_4 + 0.3 and arg_20_1.time_ < var_23_4 + 0.3 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			local var_23_5 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_5 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_6 = 2

			if var_23_5 <= arg_20_1.time_ and arg_20_1.time_ < var_23_5 + var_23_6 then
				local var_23_7 = Color.New(1, 1, 1)

				var_23_7.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - var_23_5) / var_23_6)
				arg_20_1.mask_.color = var_23_7
			end

			if arg_20_1.time_ >= var_23_5 + var_23_6 and arg_20_1.time_ < var_23_5 + var_23_6 + arg_23_0 then
				local var_23_8 = Color.New(1, 1, 1)

				arg_20_1.mask_.enabled = false
				var_23_8.a = 0
				arg_20_1.mask_.color = var_23_8
			end

			local var_23_9 = arg_20_1.actors_["1097ui_story"].transform

			if 1.8 < arg_20_1.time_ and arg_20_1.time_ <= 1.8 + arg_23_0 then
				arg_20_1.var_.moveOldPos1097ui_story = var_23_9.localPosition
			end

			local var_23_10 = 0.001

			if 1.8 <= arg_20_1.time_ and arg_20_1.time_ < 1.8 + var_23_10 then
				var_23_9.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_20_1.time_ - 1.8) / var_23_10)
				var_23_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_9.position).x, (manager.ui.mainCamera.transform.position - var_23_9.position).y, (manager.ui.mainCamera.transform.position - var_23_9.position).z)
				var_23_9.localEulerAngles.z = 0
				var_23_9.localEulerAngles.x = 0
				var_23_9.localEulerAngles = var_23_9.localEulerAngles
			end

			if arg_20_1.time_ >= 1.8 + var_23_10 and arg_20_1.time_ < 1.8 + var_23_10 + arg_23_0 then
				var_23_9.localPosition = Vector3.New(0, -0.54, -6.3)
				var_23_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_9.position).x, (manager.ui.mainCamera.transform.position - var_23_9.position).y, (manager.ui.mainCamera.transform.position - var_23_9.position).z)
				var_23_9.localEulerAngles.z = 0
				var_23_9.localEulerAngles.x = 0
				var_23_9.localEulerAngles = var_23_9.localEulerAngles
			end

			local var_23_11 = arg_20_1.actors_["1097ui_story"]

			if 1.8 < arg_20_1.time_ and arg_20_1.time_ <= 1.8 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1097ui_story == nil then
				arg_20_1.var_.characterEffect1097ui_story = var_23_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_12 = 0.200000002980232

			if 1.8 <= arg_20_1.time_ and arg_20_1.time_ < 1.8 + var_23_12 and not isNil(var_23_11) then
				if arg_20_1.var_.characterEffect1097ui_story and not isNil(var_23_11) then
					arg_20_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 1.8 + var_23_12 and arg_20_1.time_ < 1.8 + var_23_12 + arg_23_0 and not isNil(var_23_11) and arg_20_1.var_.characterEffect1097ui_story then
				arg_20_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 1.8 < arg_20_1.time_ and arg_20_1.time_ <= 1.8 + arg_23_0 then
				arg_20_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 1.8 < arg_20_1.time_ and arg_20_1.time_ <= 1.8 + arg_23_0 then
				arg_20_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_23_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_16 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_16

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_16
						arg_20_1.bgmTxt2_.text = var_23_16
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_20_1.time_ and arg_20_1.time_ <= 0.266666666666667 + arg_23_0 then
				arg_20_1:AudioAction("play", "music", "bgm_activity_3_2_story_house_nightmare", "bgm_activity_3_2_story_house_nightmare", "bgm_activity_3_2_story_house_nightmare.awb")

				local var_23_19 = manager.audio:GetAudioName("bgm_activity_3_2_story_house_nightmare", "bgm_activity_3_2_story_house_nightmare")

				if "" ~= "" then
					if arg_20_1.bgmTxt_.text ~= var_23_19 and arg_20_1.bgmTxt_.text ~= "" then
						if arg_20_1.bgmTxt2_.text ~= "" then
							arg_20_1.bgmTxt_.text = arg_20_1.bgmTxt2_.text
						end

						arg_20_1.bgmTxt2_.text = var_23_19

						arg_20_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_20_1.bgmTxt_.text = var_23_19
						arg_20_1.bgmTxt2_.text = var_23_19
					end

					if arg_20_1.bgmTimer then
						arg_20_1.bgmTimer:Stop()

						arg_20_1.bgmTimer = nil
					end

					if arg_20_1.settingData.show_music_name == 1 then
						arg_20_1.musicController:SetSelectedState("show")
						arg_20_1.musicAnimator_:Play("open", 0, 0)

						if arg_20_1.settingData.music_time ~= 0 then
							arg_20_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_20_1.settingData.music_time), function()
								if arg_20_1 == nil or isNil(arg_20_1.bgmTxt_) then
									return
								end

								arg_20_1.musicController:SetSelectedState("hide")
								arg_20_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_20 = 2
			local var_23_21 = 0.125

			if 2 < arg_20_1.time_ and arg_20_1.time_ <= var_23_20 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_22 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_22:setOnUpdate(LuaHelper.FloatAction(function(arg_26_0)
					arg_20_1.dialogCg_.alpha = arg_26_0
				end))
				var_23_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_23 = arg_20_1:GetWordFromCfg(412102005)
				local var_23_24 = arg_20_1:FormatText(var_23_23.content)

				arg_20_1.text_.text = var_23_24

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_26 = 5 <= 0 and var_23_21 or var_23_21 * (utf8.len(var_23_24) / 5)

				if (5 <= 0 and var_23_21 or var_23_21 * (utf8.len(var_23_24) / 5)) > 0 and var_23_21 < var_23_26 then
					arg_20_1.talkMaxDuration = var_23_26
					var_23_20 = var_23_20 + 0.3

					if var_23_26 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_26 + var_23_20
					end
				end

				arg_20_1.text_.text = var_23_24
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102005", "story_v_out_412102.awb") ~= 0 then
					local var_23_27 = manager.audio:GetVoiceLength("story_v_out_412102", "412102005", "story_v_out_412102.awb") / 1000

					if var_23_27 + var_23_20 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_27 + var_23_20
					end

					if var_23_23.prefab_name ~= "" and arg_20_1.actors_[var_23_23.prefab_name] ~= nil then
						local var_23_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_23.prefab_name].transform, "story_v_out_412102", "412102005", "story_v_out_412102.awb")

						arg_20_1:RecordAudio("412102005", var_23_28)
						arg_20_1:RecordAudio("412102005", var_23_28)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_412102", "412102005", "story_v_out_412102.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_412102", "412102005", "story_v_out_412102.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_29 = var_23_20 + 0.3
			local var_23_30 = math.max(var_23_21, arg_20_1.talkMaxDuration)

			if var_23_20 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_29 + var_23_30 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_29) / var_23_30

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_29 + var_23_30 and arg_20_1.time_ < var_23_29 + var_23_30 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play412102006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 412102006
		arg_28_1.duration_ = 3.13

		local var_28_0 = {
			zh = 1.9,
			ja = 3.133
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play412102007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1097ui_story = arg_28_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1097ui_story"].transform.position).z)
				arg_28_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1097ui_story"].transform.localEulerAngles = arg_28_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1097ui_story"].transform.position).z)
				arg_28_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1097ui_story"].transform.localEulerAngles = arg_28_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1097ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1097ui_story == nil then
				arg_28_1.var_.characterEffect1097ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1097ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_2)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1097ui_story then
				arg_28_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_31_3 = 0
			local var_31_4 = 0.175

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:GetWordFromCfg(412102006)
				local var_31_6 = arg_28_1:FormatText(var_31_5.content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 7 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 7)

				if (7 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 7)) > 0 and var_31_4 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8

					if var_31_8 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102006", "story_v_out_412102.awb") ~= 0 then
					local var_31_9 = manager.audio:GetVoiceLength("story_v_out_412102", "412102006", "story_v_out_412102.awb") / 1000

					if var_31_9 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_3
					end

					if var_31_5.prefab_name ~= "" and arg_28_1.actors_[var_31_5.prefab_name] ~= nil then
						local var_31_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_5.prefab_name].transform, "story_v_out_412102", "412102006", "story_v_out_412102.awb")

						arg_28_1:RecordAudio("412102006", var_31_10)
						arg_28_1:RecordAudio("412102006", var_31_10)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_412102", "412102006", "story_v_out_412102.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_412102", "412102006", "story_v_out_412102.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_11 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_11 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_11

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_11 and arg_28_1.time_ < var_31_3 + var_31_11 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play412102007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 412102007
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play412102008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 1.15

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(412102007).content)

				arg_32_1.text_.text = var_35_1

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_3 = 46 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 46)

				if (46 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_1) / 46)) > 0 and var_35_0 < var_35_3 then
					arg_32_1.talkMaxDuration = var_35_3

					if var_35_3 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_3 + 0
					end
				end

				arg_32_1.text_.text = var_35_1
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_4 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_4

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play412102008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 412102008
		arg_36_1.duration_ = 3.57

		local var_36_0 = {
			zh = 2.466,
			ja = 3.566
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play412102009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1097ui_story = arg_36_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_39_0 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 then
				arg_36_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_36_1.time_ - 0) / var_39_0)
				arg_36_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1097ui_story"].transform.position).z)
				arg_36_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1097ui_story"].transform.localEulerAngles = arg_36_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 then
				arg_36_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_36_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_36_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_36_1.actors_["1097ui_story"].transform.position).z)
				arg_36_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_36_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_36_1.actors_["1097ui_story"].transform.localEulerAngles = arg_36_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_39_1 = arg_36_1.actors_["1097ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1097ui_story == nil then
				arg_36_1.var_.characterEffect1097ui_story = var_39_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_2 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_2 and not isNil(var_39_1) then
				if arg_36_1.var_.characterEffect1097ui_story and not isNil(var_39_1) then
					arg_36_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_2 and arg_36_1.time_ < 0 + var_39_2 + arg_39_0 and not isNil(var_39_1) and arg_36_1.var_.characterEffect1097ui_story then
				arg_36_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_39_4 = 0
			local var_39_5 = 0.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_4 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_6 = arg_36_1:GetWordFromCfg(412102008)
				local var_39_7 = arg_36_1:FormatText(var_39_6.content)

				arg_36_1.text_.text = var_39_7

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_9 = 6 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 6)

				if (6 <= 0 and var_39_5 or var_39_5 * (utf8.len(var_39_7) / 6)) > 0 and var_39_5 < var_39_9 then
					arg_36_1.talkMaxDuration = var_39_9

					if var_39_9 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_9 + var_39_4
					end
				end

				arg_36_1.text_.text = var_39_7
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102008", "story_v_out_412102.awb") ~= 0 then
					local var_39_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102008", "story_v_out_412102.awb") / 1000

					if var_39_10 + var_39_4 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_10 + var_39_4
					end

					if var_39_6.prefab_name ~= "" and arg_36_1.actors_[var_39_6.prefab_name] ~= nil then
						local var_39_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_6.prefab_name].transform, "story_v_out_412102", "412102008", "story_v_out_412102.awb")

						arg_36_1:RecordAudio("412102008", var_39_11)
						arg_36_1:RecordAudio("412102008", var_39_11)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_412102", "412102008", "story_v_out_412102.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_412102", "412102008", "story_v_out_412102.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_12 = math.max(var_39_5, arg_36_1.talkMaxDuration)

			if var_39_4 <= arg_36_1.time_ and arg_36_1.time_ < var_39_4 + var_39_12 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_4) / var_39_12

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_4 + var_39_12 and arg_36_1.time_ < var_39_4 + var_39_12 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play412102009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 412102009
		arg_40_1.duration_ = 2.3

		local var_40_0 = {
			zh = 2.3,
			ja = 2.166
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play412102010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1097ui_story"]) and arg_40_1.var_.characterEffect1097ui_story == nil then
				arg_40_1.var_.characterEffect1097ui_story = arg_40_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1097ui_story"]) then
				if arg_40_1.var_.characterEffect1097ui_story and not isNil(arg_40_1.actors_["1097ui_story"]) then
					arg_40_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1097ui_story"]) and arg_40_1.var_.characterEffect1097ui_story then
				arg_40_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_43_1 = "1197ui_story"

			if arg_40_1.actors_["1197ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1197ui_story"))) then
				local var_43_2 = Object.Instantiate(Asset.Load("Char/" .. "1197ui_story"), arg_40_1.stage_.transform)

				var_43_2.name = var_43_1
				var_43_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_[var_43_1] = var_43_2

				local var_43_3 = var_43_2:GetComponentInChildren(typeof(CharacterEffect))

				var_43_3.enabled = true

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_2, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_3.transform, false)

				arg_40_1.var_[var_43_1 .. "Animator"] = var_43_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_[var_43_1 .. "Animator"].applyRootMotion = true
				arg_40_1.var_[var_43_1 .. "LipSync"] = var_43_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_5 = arg_40_1.actors_["1197ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1197ui_story = var_43_5.localPosition
			end

			local var_43_6 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_6 then
				var_43_5.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1197ui_story, Vector3.New(0.7, -0.545, -6.3), (arg_40_1.time_ - 0) / var_43_6)
				var_43_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_5.position).x, (manager.ui.mainCamera.transform.position - var_43_5.position).y, (manager.ui.mainCamera.transform.position - var_43_5.position).z)
				var_43_5.localEulerAngles.z = 0
				var_43_5.localEulerAngles.x = 0
				var_43_5.localEulerAngles = var_43_5.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_6 and arg_40_1.time_ < 0 + var_43_6 + arg_43_0 then
				var_43_5.localPosition = Vector3.New(0.7, -0.545, -6.3)
				var_43_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_5.position).x, (manager.ui.mainCamera.transform.position - var_43_5.position).y, (manager.ui.mainCamera.transform.position - var_43_5.position).z)
				var_43_5.localEulerAngles.z = 0
				var_43_5.localEulerAngles.x = 0
				var_43_5.localEulerAngles = var_43_5.localEulerAngles
			end

			local var_43_7 = arg_40_1.actors_["1197ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1197ui_story == nil then
				arg_40_1.var_.characterEffect1197ui_story = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect1197ui_story and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect1197ui_story then
				arg_40_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_43_10 = arg_40_1.actors_["1097ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1097ui_story = var_43_10.localPosition
			end

			local var_43_11 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_11 then
				var_43_10.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_40_1.time_ - 0) / var_43_11)
				var_43_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_10.position).x, (manager.ui.mainCamera.transform.position - var_43_10.position).y, (manager.ui.mainCamera.transform.position - var_43_10.position).z)
				var_43_10.localEulerAngles.z = 0
				var_43_10.localEulerAngles.x = 0
				var_43_10.localEulerAngles = var_43_10.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_11 and arg_40_1.time_ < 0 + var_43_11 + arg_43_0 then
				var_43_10.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_43_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_10.position).x, (manager.ui.mainCamera.transform.position - var_43_10.position).y, (manager.ui.mainCamera.transform.position - var_43_10.position).z)
				var_43_10.localEulerAngles.z = 0
				var_43_10.localEulerAngles.x = 0
				var_43_10.localEulerAngles = var_43_10.localEulerAngles
			end

			local var_43_12 = 0
			local var_43_13 = 0.2

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_12 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_14 = arg_40_1:GetWordFromCfg(412102009)
				local var_43_15 = arg_40_1:FormatText(var_43_14.content)

				arg_40_1.text_.text = var_43_15

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_17 = 8 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 8)

				if (8 <= 0 and var_43_13 or var_43_13 * (utf8.len(var_43_15) / 8)) > 0 and var_43_13 < var_43_17 then
					arg_40_1.talkMaxDuration = var_43_17

					if var_43_17 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_17 + var_43_12
					end
				end

				arg_40_1.text_.text = var_43_15
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102009", "story_v_out_412102.awb") ~= 0 then
					local var_43_18 = manager.audio:GetVoiceLength("story_v_out_412102", "412102009", "story_v_out_412102.awb") / 1000

					if var_43_18 + var_43_12 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_18 + var_43_12
					end

					if var_43_14.prefab_name ~= "" and arg_40_1.actors_[var_43_14.prefab_name] ~= nil then
						local var_43_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_14.prefab_name].transform, "story_v_out_412102", "412102009", "story_v_out_412102.awb")

						arg_40_1:RecordAudio("412102009", var_43_19)
						arg_40_1:RecordAudio("412102009", var_43_19)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_412102", "412102009", "story_v_out_412102.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_412102", "412102009", "story_v_out_412102.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_20 = math.max(var_43_13, arg_40_1.talkMaxDuration)

			if var_43_12 <= arg_40_1.time_ and arg_40_1.time_ < var_43_12 + var_43_20 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_12) / var_43_20

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_12 + var_43_20 and arg_40_1.time_ < var_43_12 + var_43_20 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play412102010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 412102010
		arg_44_1.duration_ = 4.77

		local var_44_0 = {
			zh = 4.766,
			ja = 2.366
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play412102011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1097ui_story = arg_44_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_47_0 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 then
				arg_44_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_44_1.time_ - 0) / var_47_0)
				arg_44_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1097ui_story"].transform.position).z)
				arg_44_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1097ui_story"].transform.localEulerAngles = arg_44_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 then
				arg_44_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_44_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_44_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_44_1.actors_["1097ui_story"].transform.position).z)
				arg_44_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_44_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_44_1.actors_["1097ui_story"].transform.localEulerAngles = arg_44_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_47_1 = arg_44_1.actors_["1097ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1097ui_story == nil then
				arg_44_1.var_.characterEffect1097ui_story = var_47_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_2 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_2 and not isNil(var_47_1) then
				if arg_44_1.var_.characterEffect1097ui_story and not isNil(var_47_1) then
					arg_44_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_2 and arg_44_1.time_ < 0 + var_47_2 + arg_47_0 and not isNil(var_47_1) and arg_44_1.var_.characterEffect1097ui_story then
				arg_44_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action2_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_47_4 = arg_44_1.actors_["1197ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1197ui_story == nil then
				arg_44_1.var_.characterEffect1197ui_story = var_47_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_5 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 and not isNil(var_47_4) then
				if arg_44_1.var_.characterEffect1197ui_story and not isNil(var_47_4) then
					arg_44_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_5)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 and not isNil(var_47_4) and arg_44_1.var_.characterEffect1197ui_story then
				arg_44_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_47_6 = 0
			local var_47_7 = 0.375

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_8 = arg_44_1:GetWordFromCfg(412102010)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 15 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 15)

				if (15 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 15)) > 0 and var_47_7 < var_47_11 then
					arg_44_1.talkMaxDuration = var_47_11

					if var_47_11 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102010", "story_v_out_412102.awb") ~= 0 then
					local var_47_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102010", "story_v_out_412102.awb") / 1000

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_412102", "412102010", "story_v_out_412102.awb")

						arg_44_1:RecordAudio("412102010", var_47_13)
						arg_44_1:RecordAudio("412102010", var_47_13)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_412102", "412102010", "story_v_out_412102.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_412102", "412102010", "story_v_out_412102.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play412102011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 412102011
		arg_48_1.duration_ = 3.4

		local var_48_0 = {
			zh = 1.999999999999,
			ja = 3.4
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play412102012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1097ui_story"]) and arg_48_1.var_.characterEffect1097ui_story == nil then
				arg_48_1.var_.characterEffect1097ui_story = arg_48_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1097ui_story"]) then
				if arg_48_1.var_.characterEffect1097ui_story and not isNil(arg_48_1.actors_["1097ui_story"]) then
					arg_48_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1097ui_story"]) and arg_48_1.var_.characterEffect1097ui_story then
				arg_48_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_51_1 = arg_48_1.actors_["1197ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1197ui_story == nil then
				arg_48_1.var_.characterEffect1197ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect1197ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect1197ui_story then
				arg_48_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_51_4 = 0
			local var_51_5 = 0.175

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(412102011)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 7 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 7)

				if (7 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 7)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102011", "story_v_out_412102.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102011", "story_v_out_412102.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_412102", "412102011", "story_v_out_412102.awb")

						arg_48_1:RecordAudio("412102011", var_51_11)
						arg_48_1:RecordAudio("412102011", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_412102", "412102011", "story_v_out_412102.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_412102", "412102011", "story_v_out_412102.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play412102012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 412102012
		arg_52_1.duration_ = 4.47

		local var_52_0 = {
			zh = 1.999999999999,
			ja = 4.466
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play412102013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1097ui_story"]) and arg_52_1.var_.characterEffect1097ui_story == nil then
				arg_52_1.var_.characterEffect1097ui_story = arg_52_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1097ui_story"]) then
				if arg_52_1.var_.characterEffect1097ui_story and not isNil(arg_52_1.actors_["1097ui_story"]) then
					arg_52_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1097ui_story"]) and arg_52_1.var_.characterEffect1097ui_story then
				arg_52_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_55_2 = arg_52_1.actors_["1197ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1197ui_story == nil then
				arg_52_1.var_.characterEffect1197ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1197ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1197ui_story then
				arg_52_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_55_4 = 0
			local var_55_5 = 0.175

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(412102012)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 7 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 7)

				if (7 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 7)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102012", "story_v_out_412102.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102012", "story_v_out_412102.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_412102", "412102012", "story_v_out_412102.awb")

						arg_52_1:RecordAudio("412102012", var_55_11)
						arg_52_1:RecordAudio("412102012", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_412102", "412102012", "story_v_out_412102.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_412102", "412102012", "story_v_out_412102.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play412102013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 412102013
		arg_56_1.duration_ = 5.43

		local var_56_0 = {
			zh = 5.1,
			ja = 5.433
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
				arg_56_0:Play412102014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1097ui_story"]) and arg_56_1.var_.characterEffect1097ui_story == nil then
				arg_56_1.var_.characterEffect1097ui_story = arg_56_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1097ui_story"]) then
				if arg_56_1.var_.characterEffect1097ui_story and not isNil(arg_56_1.actors_["1097ui_story"]) then
					arg_56_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1097ui_story"]) and arg_56_1.var_.characterEffect1097ui_story then
				arg_56_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_59_1 = arg_56_1.actors_["1197ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1197ui_story == nil then
				arg_56_1.var_.characterEffect1197ui_story = var_59_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_2 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_2 and not isNil(var_59_1) then
				if arg_56_1.var_.characterEffect1197ui_story and not isNil(var_59_1) then
					arg_56_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_2 and arg_56_1.time_ < 0 + var_59_2 + arg_59_0 and not isNil(var_59_1) and arg_56_1.var_.characterEffect1197ui_story then
				arg_56_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_59_4 = 0
			local var_59_5 = 0.4

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(412102013)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 16 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 16)

				if (16 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 16)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102013", "story_v_out_412102.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102013", "story_v_out_412102.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_412102", "412102013", "story_v_out_412102.awb")

						arg_56_1:RecordAudio("412102013", var_59_11)
						arg_56_1:RecordAudio("412102013", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_412102", "412102013", "story_v_out_412102.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_412102", "412102013", "story_v_out_412102.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play412102014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 412102014
		arg_60_1.duration_ = 7.23

		local var_60_0 = {
			zh = 7.233,
			ja = 5.8
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play412102015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1097ui_story"]) and arg_60_1.var_.characterEffect1097ui_story == nil then
				arg_60_1.var_.characterEffect1097ui_story = arg_60_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1097ui_story"]) then
				if arg_60_1.var_.characterEffect1097ui_story and not isNil(arg_60_1.actors_["1097ui_story"]) then
					arg_60_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1097ui_story"]) and arg_60_1.var_.characterEffect1097ui_story then
				arg_60_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1197ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1197ui_story == nil then
				arg_60_1.var_.characterEffect1197ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1197ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1197ui_story then
				arg_60_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_63_4 = 0
			local var_63_5 = 0.625

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(412102014)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 25 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 25)

				if (25 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 25)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102014", "story_v_out_412102.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102014", "story_v_out_412102.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_412102", "412102014", "story_v_out_412102.awb")

						arg_60_1:RecordAudio("412102014", var_63_11)
						arg_60_1:RecordAudio("412102014", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_412102", "412102014", "story_v_out_412102.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_412102", "412102014", "story_v_out_412102.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play412102015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 412102015
		arg_64_1.duration_ = 6.57

		local var_64_0 = {
			zh = 5.066,
			ja = 6.566
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play412102016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1097ui_story"]) and arg_64_1.var_.characterEffect1097ui_story == nil then
				arg_64_1.var_.characterEffect1097ui_story = arg_64_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1097ui_story"]) then
				if arg_64_1.var_.characterEffect1097ui_story and not isNil(arg_64_1.actors_["1097ui_story"]) then
					arg_64_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1097ui_story"]) and arg_64_1.var_.characterEffect1097ui_story then
				arg_64_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_67_1 = arg_64_1.actors_["1197ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1197ui_story == nil then
				arg_64_1.var_.characterEffect1197ui_story = var_67_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_2 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_2 and not isNil(var_67_1) then
				if arg_64_1.var_.characterEffect1197ui_story and not isNil(var_67_1) then
					arg_64_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_2 and arg_64_1.time_ < 0 + var_67_2 + arg_67_0 and not isNil(var_67_1) and arg_64_1.var_.characterEffect1197ui_story then
				arg_64_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_67_4 = 0
			local var_67_5 = 0.475

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_4 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_6 = arg_64_1:GetWordFromCfg(412102015)
				local var_67_7 = arg_64_1:FormatText(var_67_6.content)

				arg_64_1.text_.text = var_67_7

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_9 = 19 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 19)

				if (19 <= 0 and var_67_5 or var_67_5 * (utf8.len(var_67_7) / 19)) > 0 and var_67_5 < var_67_9 then
					arg_64_1.talkMaxDuration = var_67_9

					if var_67_9 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_9 + var_67_4
					end
				end

				arg_64_1.text_.text = var_67_7
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102015", "story_v_out_412102.awb") ~= 0 then
					local var_67_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102015", "story_v_out_412102.awb") / 1000

					if var_67_10 + var_67_4 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_10 + var_67_4
					end

					if var_67_6.prefab_name ~= "" and arg_64_1.actors_[var_67_6.prefab_name] ~= nil then
						local var_67_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_6.prefab_name].transform, "story_v_out_412102", "412102015", "story_v_out_412102.awb")

						arg_64_1:RecordAudio("412102015", var_67_11)
						arg_64_1:RecordAudio("412102015", var_67_11)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_412102", "412102015", "story_v_out_412102.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_412102", "412102015", "story_v_out_412102.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_12 = math.max(var_67_5, arg_64_1.talkMaxDuration)

			if var_67_4 <= arg_64_1.time_ and arg_64_1.time_ < var_67_4 + var_67_12 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_4) / var_67_12

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_4 + var_67_12 and arg_64_1.time_ < var_67_4 + var_67_12 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play412102016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 412102016
		arg_68_1.duration_ = 5.2

		local var_68_0 = {
			zh = 2,
			ja = 5.2
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play412102017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1097ui_story"]) and arg_68_1.var_.characterEffect1097ui_story == nil then
				arg_68_1.var_.characterEffect1097ui_story = arg_68_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1097ui_story"]) then
				if arg_68_1.var_.characterEffect1097ui_story and not isNil(arg_68_1.actors_["1097ui_story"]) then
					arg_68_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1097ui_story"]) and arg_68_1.var_.characterEffect1097ui_story then
				arg_68_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_71_2 = arg_68_1.actors_["1197ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1197ui_story == nil then
				arg_68_1.var_.characterEffect1197ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.200000002980232

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1197ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1197ui_story then
				arg_68_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_71_4 = 0
			local var_71_5 = 0.125

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(412102016)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 5 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 5)

				if (5 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 5)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102016", "story_v_out_412102.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102016", "story_v_out_412102.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_412102", "412102016", "story_v_out_412102.awb")

						arg_68_1:RecordAudio("412102016", var_71_11)
						arg_68_1:RecordAudio("412102016", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_412102", "412102016", "story_v_out_412102.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_412102", "412102016", "story_v_out_412102.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play412102017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 412102017
		arg_72_1.duration_ = 7.23

		local var_72_0 = {
			zh = 7.233,
			ja = 5.833
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play412102018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1097ui_story"]) and arg_72_1.var_.characterEffect1097ui_story == nil then
				arg_72_1.var_.characterEffect1097ui_story = arg_72_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1097ui_story"]) then
				if arg_72_1.var_.characterEffect1097ui_story and not isNil(arg_72_1.actors_["1097ui_story"]) then
					arg_72_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_0)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1097ui_story"]) and arg_72_1.var_.characterEffect1097ui_story then
				arg_72_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_75_1 = arg_72_1.actors_["1197ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1197ui_story == nil then
				arg_72_1.var_.characterEffect1197ui_story = var_75_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_2 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_2 and not isNil(var_75_1) then
				if arg_72_1.var_.characterEffect1197ui_story and not isNil(var_75_1) then
					arg_72_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_2 and arg_72_1.time_ < 0 + var_75_2 + arg_75_0 and not isNil(var_75_1) and arg_72_1.var_.characterEffect1197ui_story then
				arg_72_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_75_4 = 0
			local var_75_5 = 0.675

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_4 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_6 = arg_72_1:GetWordFromCfg(412102017)
				local var_75_7 = arg_72_1:FormatText(var_75_6.content)

				arg_72_1.text_.text = var_75_7

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_9 = 27 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 27)

				if (27 <= 0 and var_75_5 or var_75_5 * (utf8.len(var_75_7) / 27)) > 0 and var_75_5 < var_75_9 then
					arg_72_1.talkMaxDuration = var_75_9

					if var_75_9 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_9 + var_75_4
					end
				end

				arg_72_1.text_.text = var_75_7
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102017", "story_v_out_412102.awb") ~= 0 then
					local var_75_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102017", "story_v_out_412102.awb") / 1000

					if var_75_10 + var_75_4 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_10 + var_75_4
					end

					if var_75_6.prefab_name ~= "" and arg_72_1.actors_[var_75_6.prefab_name] ~= nil then
						local var_75_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_6.prefab_name].transform, "story_v_out_412102", "412102017", "story_v_out_412102.awb")

						arg_72_1:RecordAudio("412102017", var_75_11)
						arg_72_1:RecordAudio("412102017", var_75_11)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_412102", "412102017", "story_v_out_412102.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_412102", "412102017", "story_v_out_412102.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_12 = math.max(var_75_5, arg_72_1.talkMaxDuration)

			if var_75_4 <= arg_72_1.time_ and arg_72_1.time_ < var_75_4 + var_75_12 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_4) / var_75_12

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_4 + var_75_12 and arg_72_1.time_ < var_75_4 + var_75_12 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play412102018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 412102018
		arg_76_1.duration_ = 7.73

		local var_76_0 = {
			zh = 6.666,
			ja = 7.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play412102019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_79_0 = arg_76_1.actors_["1097ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1097ui_story == nil then
				arg_76_1.var_.characterEffect1097ui_story = var_79_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_1 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_1 and not isNil(var_79_0) then
				if arg_76_1.var_.characterEffect1097ui_story and not isNil(var_79_0) then
					arg_76_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_1 and arg_76_1.time_ < 0 + var_79_1 + arg_79_0 and not isNil(var_79_0) and arg_76_1.var_.characterEffect1097ui_story then
				arg_76_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_79_3 = arg_76_1.actors_["1197ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect1197ui_story == nil then
				arg_76_1.var_.characterEffect1197ui_story = var_79_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_4 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 and not isNil(var_79_3) then
				if arg_76_1.var_.characterEffect1197ui_story and not isNil(var_79_3) then
					arg_76_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_4)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 and not isNil(var_79_3) and arg_76_1.var_.characterEffect1197ui_story then
				arg_76_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_79_5 = 0
			local var_79_6 = 0.4

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_5 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0

				arg_76_1.dialog_:SetActive(true)

				arg_76_1.dialogCg_.alpha = 0

				local var_79_7 = LeanTween.value(arg_76_1.dialog_, 0, 1, 0.3)

				var_79_7:setOnUpdate(LuaHelper.FloatAction(function(arg_80_0)
					arg_76_1.dialogCg_.alpha = arg_80_0
				end))
				var_79_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_76_1.dialog_)
					var_79_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_76_1.duration_ = arg_76_1.duration_ + 0.3

				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_8 = arg_76_1:GetWordFromCfg(412102018)
				local var_79_9 = arg_76_1:FormatText(var_79_8.content)

				arg_76_1.text_.text = var_79_9

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_11 = 16 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_9) / 16)

				if (16 <= 0 and var_79_6 or var_79_6 * (utf8.len(var_79_9) / 16)) > 0 and var_79_6 < var_79_11 then
					arg_76_1.talkMaxDuration = var_79_11
					var_79_5 = var_79_5 + 0.3

					if var_79_11 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_11 + var_79_5
					end
				end

				arg_76_1.text_.text = var_79_9
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102018", "story_v_out_412102.awb") ~= 0 then
					local var_79_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102018", "story_v_out_412102.awb") / 1000

					if var_79_12 + var_79_5 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_12 + var_79_5
					end

					if var_79_8.prefab_name ~= "" and arg_76_1.actors_[var_79_8.prefab_name] ~= nil then
						local var_79_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_8.prefab_name].transform, "story_v_out_412102", "412102018", "story_v_out_412102.awb")

						arg_76_1:RecordAudio("412102018", var_79_13)
						arg_76_1:RecordAudio("412102018", var_79_13)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_412102", "412102018", "story_v_out_412102.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_412102", "412102018", "story_v_out_412102.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_14 = var_79_5 + 0.3
			local var_79_15 = math.max(var_79_6, arg_76_1.talkMaxDuration)

			if var_79_5 + 0.3 <= arg_76_1.time_ and arg_76_1.time_ < var_79_14 + var_79_15 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_14) / var_79_15

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_14 + var_79_15 and arg_76_1.time_ < var_79_14 + var_79_15 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play412102019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 412102019
		arg_82_1.duration_ = 9

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play412102020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 2 < arg_82_1.time_ and arg_82_1.time_ <= 2 + arg_85_0 then
				local var_85_0 = arg_82_1.bgs_.ST30a

				arg_82_1.bgs_.ST30a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_85_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_85_1 = var_85_0:GetComponent("SpriteRenderer")

				if var_85_1 and var_85_1.sprite then
					local var_85_2 = 2 * (var_85_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_85_0.transform.localScale = Vector3.New(var_85_2 / var_85_1.sprite.bounds.size.y < var_85_2 * manager.ui.mainCameraCom_.aspect / var_85_1.sprite.bounds.size.x and var_85_2 * manager.ui.mainCameraCom_.aspect / var_85_1.sprite.bounds.size.x or var_85_2 / var_85_1.sprite.bounds.size.y, var_85_2 / var_85_1.sprite.bounds.size.y < var_85_2 * manager.ui.mainCameraCom_.aspect / var_85_1.sprite.bounds.size.x and var_85_2 * manager.ui.mainCameraCom_.aspect / var_85_1.sprite.bounds.size.x or var_85_2 / var_85_1.sprite.bounds.size.y, 0)
				end

				for iter_85_0, iter_85_1 in pairs(arg_82_1.bgs_) do
					if iter_85_0 ~= "ST30a" then
						iter_85_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_85_3 = 3.999999999999

			if 3.999999999999 < arg_82_1.time_ and arg_82_1.time_ <= var_85_3 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_3 + 0.3 and arg_82_1.time_ < var_85_3 + 0.3 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_4 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_5 = 2

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_5 then
				local var_85_6 = Color.New(0, 0, 0)

				var_85_6.a = Mathf.Lerp(0, 1, (arg_82_1.time_ - var_85_4) / var_85_5)
				arg_82_1.mask_.color = var_85_6
			end

			if arg_82_1.time_ >= var_85_4 + var_85_5 and arg_82_1.time_ < var_85_4 + var_85_5 + arg_85_0 then
				local var_85_7 = Color.New(0, 0, 0)

				var_85_7.a = 1
				arg_82_1.mask_.color = var_85_7
			end

			local var_85_8 = 2

			if 2 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.mask_.enabled = true
				arg_82_1.mask_.raycastTarget = true

				arg_82_1:SetGaussion(false)
			end

			local var_85_9 = 2

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_9 then
				local var_85_10 = Color.New(0, 0, 0)

				var_85_10.a = Mathf.Lerp(1, 0, (arg_82_1.time_ - var_85_8) / var_85_9)
				arg_82_1.mask_.color = var_85_10
			end

			if arg_82_1.time_ >= var_85_8 + var_85_9 and arg_82_1.time_ < var_85_8 + var_85_9 + arg_85_0 then
				local var_85_11 = Color.New(0, 0, 0)

				arg_82_1.mask_.enabled = false
				var_85_11.a = 0
				arg_82_1.mask_.color = var_85_11
			end

			local var_85_12 = arg_82_1.actors_["1097ui_story"].transform

			if 1.96599999815226 < arg_82_1.time_ and arg_82_1.time_ <= 1.96599999815226 + arg_85_0 then
				arg_82_1.var_.moveOldPos1097ui_story = var_85_12.localPosition
			end

			local var_85_13 = 0.001

			if 1.96599999815226 <= arg_82_1.time_ and arg_82_1.time_ < 1.96599999815226 + var_85_13 then
				var_85_12.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 1.96599999815226) / var_85_13)
				var_85_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_12.position).x, (manager.ui.mainCamera.transform.position - var_85_12.position).y, (manager.ui.mainCamera.transform.position - var_85_12.position).z)
				var_85_12.localEulerAngles.z = 0
				var_85_12.localEulerAngles.x = 0
				var_85_12.localEulerAngles = var_85_12.localEulerAngles
			end

			if arg_82_1.time_ >= 1.96599999815226 + var_85_13 and arg_82_1.time_ < 1.96599999815226 + var_85_13 + arg_85_0 then
				var_85_12.localPosition = Vector3.New(0, 100, 0)
				var_85_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_12.position).x, (manager.ui.mainCamera.transform.position - var_85_12.position).y, (manager.ui.mainCamera.transform.position - var_85_12.position).z)
				var_85_12.localEulerAngles.z = 0
				var_85_12.localEulerAngles.x = 0
				var_85_12.localEulerAngles = var_85_12.localEulerAngles
			end

			local var_85_14 = arg_82_1.actors_["1197ui_story"].transform

			if 1.96599999815226 < arg_82_1.time_ and arg_82_1.time_ <= 1.96599999815226 + arg_85_0 then
				arg_82_1.var_.moveOldPos1197ui_story = var_85_14.localPosition
			end

			local var_85_15 = 0.001

			if 1.96599999815226 <= arg_82_1.time_ and arg_82_1.time_ < 1.96599999815226 + var_85_15 then
				var_85_14.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 1.96599999815226) / var_85_15)
				var_85_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_14.position).x, (manager.ui.mainCamera.transform.position - var_85_14.position).y, (manager.ui.mainCamera.transform.position - var_85_14.position).z)
				var_85_14.localEulerAngles.z = 0
				var_85_14.localEulerAngles.x = 0
				var_85_14.localEulerAngles = var_85_14.localEulerAngles
			end

			if arg_82_1.time_ >= 1.96599999815226 + var_85_15 and arg_82_1.time_ < 1.96599999815226 + var_85_15 + arg_85_0 then
				var_85_14.localPosition = Vector3.New(0, 100, 0)
				var_85_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_14.position).x, (manager.ui.mainCamera.transform.position - var_85_14.position).y, (manager.ui.mainCamera.transform.position - var_85_14.position).z)
				var_85_14.localEulerAngles.z = 0
				var_85_14.localEulerAngles.x = 0
				var_85_14.localEulerAngles = var_85_14.localEulerAngles
			end

			if arg_82_1.frameCnt_ <= 1 then
				arg_82_1.dialog_:SetActive(false)
			end

			local var_85_16 = 3.999999999999
			local var_85_17 = 1.2

			if 3.999999999999 < arg_82_1.time_ and arg_82_1.time_ <= var_85_16 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0

				arg_82_1.dialog_:SetActive(true)

				arg_82_1.dialogCg_.alpha = 0

				local var_85_18 = LeanTween.value(arg_82_1.dialog_, 0, 1, 0.3)

				var_85_18:setOnUpdate(LuaHelper.FloatAction(function(arg_86_0)
					arg_82_1.dialogCg_.alpha = arg_86_0
				end))
				var_85_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_82_1.dialog_)
					var_85_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_82_1.duration_ = arg_82_1.duration_ + 0.3

				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_19 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(412102019).content)

				arg_82_1.text_.text = var_85_19

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_21 = 48 <= 0 and var_85_17 or var_85_17 * (utf8.len(var_85_19) / 48)

				if (48 <= 0 and var_85_17 or var_85_17 * (utf8.len(var_85_19) / 48)) > 0 and var_85_17 < var_85_21 then
					arg_82_1.talkMaxDuration = var_85_21
					var_85_16 = var_85_16 + 0.3

					if var_85_21 + var_85_16 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_21 + var_85_16
					end
				end

				arg_82_1.text_.text = var_85_19
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_22 = var_85_16 + 0.3
			local var_85_23 = math.max(var_85_17, arg_82_1.talkMaxDuration)

			if var_85_16 + 0.3 <= arg_82_1.time_ and arg_82_1.time_ < var_85_22 + var_85_23 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_22) / var_85_23

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_22 + var_85_23 and arg_82_1.time_ < var_85_22 + var_85_23 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play412102020 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 412102020
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play412102021(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.8

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(412102020).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 32 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 32)

				if (32 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 32)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play412102021 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 412102021
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play412102022(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.5

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, false)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_1 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(412102021).content)

				arg_92_1.text_.text = var_95_1

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_3 = 20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 20)

				if (20 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_1) / 20)) > 0 and var_95_0 < var_95_3 then
					arg_92_1.talkMaxDuration = var_95_3

					if var_95_3 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_3 + 0
					end
				end

				arg_92_1.text_.text = var_95_1
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_4 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_4

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play412102022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 412102022
		arg_96_1.duration_ = 17.93

		local var_96_0 = {
			zh = 14.7,
			ja = 17.933
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play412102023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1197ui_story = arg_96_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_99_0 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 then
				arg_96_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1197ui_story, Vector3.New(0.7, -0.545, -6.3), (arg_96_1.time_ - 0) / var_99_0)
				arg_96_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1197ui_story"].transform.position).z)
				arg_96_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1197ui_story"].transform.localEulerAngles = arg_96_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 then
				arg_96_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0.7, -0.545, -6.3)
				arg_96_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["1197ui_story"].transform.position).z)
				arg_96_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["1197ui_story"].transform.localEulerAngles = arg_96_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_99_1 = arg_96_1.actors_["1197ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1197ui_story == nil then
				arg_96_1.var_.characterEffect1197ui_story = var_99_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_2 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_2 and not isNil(var_99_1) then
				if arg_96_1.var_.characterEffect1197ui_story and not isNil(var_99_1) then
					arg_96_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_2 and arg_96_1.time_ < 0 + var_99_2 + arg_99_0 and not isNil(var_99_1) and arg_96_1.var_.characterEffect1197ui_story then
				arg_96_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_2")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_99_4 = arg_96_1.actors_["1097ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1097ui_story = var_99_4.localPosition
			end

			local var_99_5 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_5 then
				var_99_4.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_96_1.time_ - 0) / var_99_5)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_5 and arg_96_1.time_ < 0 + var_99_5 + arg_99_0 then
				var_99_4.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_99_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_4.position).x, (manager.ui.mainCamera.transform.position - var_99_4.position).y, (manager.ui.mainCamera.transform.position - var_99_4.position).z)
				var_99_4.localEulerAngles.z = 0
				var_99_4.localEulerAngles.x = 0
				var_99_4.localEulerAngles = var_99_4.localEulerAngles
			end

			local var_99_6 = arg_96_1.actors_["1097ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1097ui_story == nil then
				arg_96_1.var_.characterEffect1097ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_7 = 0.034000001847744

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 and not isNil(var_99_6) then
				if arg_96_1.var_.characterEffect1097ui_story and not isNil(var_99_6) then
					arg_96_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_7)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1097ui_story then
				arg_96_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_99_8 = 0
			local var_99_9 = 1.2

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:GetWordFromCfg(412102022)
				local var_99_11 = arg_96_1:FormatText(var_99_10.content)

				arg_96_1.text_.text = var_99_11

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_13 = 48 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_11) / 48)

				if (48 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_11) / 48)) > 0 and var_99_9 < var_99_13 then
					arg_96_1.talkMaxDuration = var_99_13

					if var_99_13 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_13 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_11
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102022", "story_v_out_412102.awb") ~= 0 then
					local var_99_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102022", "story_v_out_412102.awb") / 1000

					if var_99_14 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_14 + var_99_8
					end

					if var_99_10.prefab_name ~= "" and arg_96_1.actors_[var_99_10.prefab_name] ~= nil then
						local var_99_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_10.prefab_name].transform, "story_v_out_412102", "412102022", "story_v_out_412102.awb")

						arg_96_1:RecordAudio("412102022", var_99_15)
						arg_96_1:RecordAudio("412102022", var_99_15)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_412102", "412102022", "story_v_out_412102.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_412102", "412102022", "story_v_out_412102.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_16 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_16 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_16

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_16 and arg_96_1.time_ < var_99_8 + var_99_16 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play412102023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 412102023
		arg_100_1.duration_ = 7.2

		local var_100_0 = {
			zh = 7.2,
			ja = 6.533
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play412102024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.725

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:GetWordFromCfg(412102023)
				local var_103_2 = arg_100_1:FormatText(var_103_1.content)

				arg_100_1.text_.text = var_103_2

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_4 = 29 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 29)

				if (29 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_2) / 29)) > 0 and var_103_0 < var_103_4 then
					arg_100_1.talkMaxDuration = var_103_4

					if var_103_4 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_4 + 0
					end
				end

				arg_100_1.text_.text = var_103_2
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102023", "story_v_out_412102.awb") ~= 0 then
					local var_103_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102023", "story_v_out_412102.awb") / 1000

					if var_103_5 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + 0
					end

					if var_103_1.prefab_name ~= "" and arg_100_1.actors_[var_103_1.prefab_name] ~= nil then
						local var_103_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_1.prefab_name].transform, "story_v_out_412102", "412102023", "story_v_out_412102.awb")

						arg_100_1:RecordAudio("412102023", var_103_6)
						arg_100_1:RecordAudio("412102023", var_103_6)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_412102", "412102023", "story_v_out_412102.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_412102", "412102023", "story_v_out_412102.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_7 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_7 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_7

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_7 and arg_100_1.time_ < 0 + var_103_7 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play412102024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 412102024
		arg_104_1.duration_ = 9.33

		local var_104_0 = {
			zh = 5.4,
			ja = 9.333
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play412102025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["1097ui_story"]) and arg_104_1.var_.characterEffect1097ui_story == nil then
				arg_104_1.var_.characterEffect1097ui_story = arg_104_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["1097ui_story"]) then
				if arg_104_1.var_.characterEffect1097ui_story and not isNil(arg_104_1.actors_["1097ui_story"]) then
					arg_104_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["1097ui_story"]) and arg_104_1.var_.characterEffect1097ui_story then
				arg_104_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_107_2 = arg_104_1.actors_["1197ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1197ui_story == nil then
				arg_104_1.var_.characterEffect1197ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.200000002980232

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1197ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1197ui_story then
				arg_104_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_107_4 = 0
			local var_107_5 = 0.275

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(412102024)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 11 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 11)

				if (11 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 11)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102024", "story_v_out_412102.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102024", "story_v_out_412102.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_412102", "412102024", "story_v_out_412102.awb")

						arg_104_1:RecordAudio("412102024", var_107_11)
						arg_104_1:RecordAudio("412102024", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_412102", "412102024", "story_v_out_412102.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_412102", "412102024", "story_v_out_412102.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play412102025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 412102025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play412102026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1097ui_story = arg_108_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_111_0 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 then
				arg_108_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_0)
				arg_108_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1097ui_story"].transform.position).z)
				arg_108_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1097ui_story"].transform.localEulerAngles = arg_108_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 then
				arg_108_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1097ui_story"].transform.position).z)
				arg_108_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1097ui_story"].transform.localEulerAngles = arg_108_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_111_1 = arg_108_1.actors_["1097ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1097ui_story == nil then
				arg_108_1.var_.characterEffect1097ui_story = var_111_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_2 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_2 and not isNil(var_111_1) then
				if arg_108_1.var_.characterEffect1097ui_story and not isNil(var_111_1) then
					arg_108_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_2)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_2 and arg_108_1.time_ < 0 + var_111_2 + arg_111_0 and not isNil(var_111_1) and arg_108_1.var_.characterEffect1097ui_story then
				arg_108_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_111_3 = arg_108_1.actors_["1197ui_story"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1197ui_story = var_111_3.localPosition
			end

			local var_111_4 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_4)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(0, 100, 0)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			local var_111_5 = 0
			local var_111_6 = 0.8

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(412102025).content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 32 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_7) / 32)

				if (32 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_7) / 32)) > 0 and var_111_6 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_10 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_10 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_10

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_10 and arg_108_1.time_ < var_111_5 + var_111_10 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_108_1:InitPlayNodeList()
	end,
	Play412102026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 412102026
		arg_112_1.duration_ = 3.6

		local var_112_0 = {
			zh = 2.466,
			ja = 3.6
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
				arg_112_0:Play412102027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1097ui_story = arg_112_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1097ui_story"].transform.position).z)
				arg_112_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1097ui_story"].transform.localEulerAngles = arg_112_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_112_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1097ui_story"].transform.position).z)
				arg_112_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1097ui_story"].transform.localEulerAngles = arg_112_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1097ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1097ui_story == nil then
				arg_112_1.var_.characterEffect1097ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1097ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1097ui_story then
				arg_112_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			local var_115_4 = 0
			local var_115_5 = 0.15

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(412102026)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 6 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 6)

				if (6 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 6)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102026", "story_v_out_412102.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102026", "story_v_out_412102.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_412102", "412102026", "story_v_out_412102.awb")

						arg_112_1:RecordAudio("412102026", var_115_11)
						arg_112_1:RecordAudio("412102026", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_412102", "412102026", "story_v_out_412102.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_412102", "412102026", "story_v_out_412102.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_112_1:InitPlayNodeList()
	end,
	Play412102027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 412102027
		arg_116_1.duration_ = 2

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play412102028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1097ui_story"]) and arg_116_1.var_.characterEffect1097ui_story == nil then
				arg_116_1.var_.characterEffect1097ui_story = arg_116_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1097ui_story"]) then
				if arg_116_1.var_.characterEffect1097ui_story and not isNil(arg_116_1.actors_["1097ui_story"]) then
					arg_116_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_116_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_0)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1097ui_story"]) and arg_116_1.var_.characterEffect1097ui_story then
				arg_116_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_116_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_119_1 = arg_116_1.actors_["1197ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1197ui_story = var_119_1.localPosition
			end

			local var_119_2 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_2 then
				var_119_1.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1197ui_story, Vector3.New(0.7, -0.545, -6.3), (arg_116_1.time_ - 0) / var_119_2)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_2 and arg_116_1.time_ < 0 + var_119_2 + arg_119_0 then
				var_119_1.localPosition = Vector3.New(0.7, -0.545, -6.3)
				var_119_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_1.position).x, (manager.ui.mainCamera.transform.position - var_119_1.position).y, (manager.ui.mainCamera.transform.position - var_119_1.position).z)
				var_119_1.localEulerAngles.z = 0
				var_119_1.localEulerAngles.x = 0
				var_119_1.localEulerAngles = var_119_1.localEulerAngles
			end

			local var_119_3 = arg_116_1.actors_["1197ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1197ui_story == nil then
				arg_116_1.var_.characterEffect1197ui_story = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.200000002980232

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect1197ui_story and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect1197ui_story then
				arg_116_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_119_6 = arg_116_1.actors_["1097ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1097ui_story = var_119_6.localPosition
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_6.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_116_1.time_ - 0) / var_119_7)
				var_119_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_6.position).x, (manager.ui.mainCamera.transform.position - var_119_6.position).y, (manager.ui.mainCamera.transform.position - var_119_6.position).z)
				var_119_6.localEulerAngles.z = 0
				var_119_6.localEulerAngles.x = 0
				var_119_6.localEulerAngles = var_119_6.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_6.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_119_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_6.position).x, (manager.ui.mainCamera.transform.position - var_119_6.position).y, (manager.ui.mainCamera.transform.position - var_119_6.position).z)
				var_119_6.localEulerAngles.z = 0
				var_119_6.localEulerAngles.x = 0
				var_119_6.localEulerAngles = var_119_6.localEulerAngles
			end

			local var_119_8 = 0
			local var_119_9 = 0.15

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_8 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_10 = arg_116_1:GetWordFromCfg(412102027)
				local var_119_11 = arg_116_1:FormatText(var_119_10.content)

				arg_116_1.text_.text = var_119_11

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_13 = 6 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 6)

				if (6 <= 0 and var_119_9 or var_119_9 * (utf8.len(var_119_11) / 6)) > 0 and var_119_9 < var_119_13 then
					arg_116_1.talkMaxDuration = var_119_13

					if var_119_13 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_13 + var_119_8
					end
				end

				arg_116_1.text_.text = var_119_11
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102027", "story_v_out_412102.awb") ~= 0 then
					local var_119_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102027", "story_v_out_412102.awb") / 1000

					if var_119_14 + var_119_8 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_14 + var_119_8
					end

					if var_119_10.prefab_name ~= "" and arg_116_1.actors_[var_119_10.prefab_name] ~= nil then
						local var_119_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_10.prefab_name].transform, "story_v_out_412102", "412102027", "story_v_out_412102.awb")

						arg_116_1:RecordAudio("412102027", var_119_15)
						arg_116_1:RecordAudio("412102027", var_119_15)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_412102", "412102027", "story_v_out_412102.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_412102", "412102027", "story_v_out_412102.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_16 = math.max(var_119_9, arg_116_1.talkMaxDuration)

			if var_119_8 <= arg_116_1.time_ and arg_116_1.time_ < var_119_8 + var_119_16 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_8) / var_119_16

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_8 + var_119_16 and arg_116_1.time_ < var_119_8 + var_119_16 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play412102028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 412102028
		arg_120_1.duration_ = 2

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play412102029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1097ui_story"]) and arg_120_1.var_.characterEffect1097ui_story == nil then
				arg_120_1.var_.characterEffect1097ui_story = arg_120_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1097ui_story"]) then
				if arg_120_1.var_.characterEffect1097ui_story and not isNil(arg_120_1.actors_["1097ui_story"]) then
					arg_120_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1097ui_story"]) and arg_120_1.var_.characterEffect1097ui_story then
				arg_120_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_123_2 = arg_120_1.actors_["1197ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1197ui_story == nil then
				arg_120_1.var_.characterEffect1197ui_story = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_3 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.characterEffect1197ui_story and not isNil(var_123_2) then
					arg_120_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_3)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1197ui_story then
				arg_120_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_123_4 = 0
			local var_123_5 = 0.1

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_4 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_6 = arg_120_1:GetWordFromCfg(412102028)
				local var_123_7 = arg_120_1:FormatText(var_123_6.content)

				arg_120_1.text_.text = var_123_7

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_9 = 4 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 4)

				if (4 <= 0 and var_123_5 or var_123_5 * (utf8.len(var_123_7) / 4)) > 0 and var_123_5 < var_123_9 then
					arg_120_1.talkMaxDuration = var_123_9

					if var_123_9 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_4
					end
				end

				arg_120_1.text_.text = var_123_7
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102028", "story_v_out_412102.awb") ~= 0 then
					local var_123_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102028", "story_v_out_412102.awb") / 1000

					if var_123_10 + var_123_4 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_4
					end

					if var_123_6.prefab_name ~= "" and arg_120_1.actors_[var_123_6.prefab_name] ~= nil then
						local var_123_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_6.prefab_name].transform, "story_v_out_412102", "412102028", "story_v_out_412102.awb")

						arg_120_1:RecordAudio("412102028", var_123_11)
						arg_120_1:RecordAudio("412102028", var_123_11)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_412102", "412102028", "story_v_out_412102.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_412102", "412102028", "story_v_out_412102.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_12 = math.max(var_123_5, arg_120_1.talkMaxDuration)

			if var_123_4 <= arg_120_1.time_ and arg_120_1.time_ < var_123_4 + var_123_12 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_4) / var_123_12

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_4 + var_123_12 and arg_120_1.time_ < var_123_4 + var_123_12 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play412102029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 412102029
		arg_124_1.duration_ = 6.57

		local var_124_0 = {
			zh = 4.866,
			ja = 6.566
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
				arg_124_0:Play412102030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1097ui_story"]) and arg_124_1.var_.characterEffect1097ui_story == nil then
				arg_124_1.var_.characterEffect1097ui_story = arg_124_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1097ui_story"]) then
				if arg_124_1.var_.characterEffect1097ui_story and not isNil(arg_124_1.actors_["1097ui_story"]) then
					arg_124_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_124_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1097ui_story"]) and arg_124_1.var_.characterEffect1097ui_story then
				arg_124_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_124_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_127_1 = arg_124_1.actors_["1197ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1197ui_story == nil then
				arg_124_1.var_.characterEffect1197ui_story = var_127_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_2 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 and not isNil(var_127_1) then
				if arg_124_1.var_.characterEffect1197ui_story and not isNil(var_127_1) then
					arg_124_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 and not isNil(var_127_1) and arg_124_1.var_.characterEffect1197ui_story then
				arg_124_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_127_4 = 0
			local var_127_5 = 0.55

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_4 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_6 = arg_124_1:GetWordFromCfg(412102029)
				local var_127_7 = arg_124_1:FormatText(var_127_6.content)

				arg_124_1.text_.text = var_127_7

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_9 = 22 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 22)

				if (22 <= 0 and var_127_5 or var_127_5 * (utf8.len(var_127_7) / 22)) > 0 and var_127_5 < var_127_9 then
					arg_124_1.talkMaxDuration = var_127_9

					if var_127_9 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_9 + var_127_4
					end
				end

				arg_124_1.text_.text = var_127_7
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102029", "story_v_out_412102.awb") ~= 0 then
					local var_127_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102029", "story_v_out_412102.awb") / 1000

					if var_127_10 + var_127_4 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_4
					end

					if var_127_6.prefab_name ~= "" and arg_124_1.actors_[var_127_6.prefab_name] ~= nil then
						local var_127_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_6.prefab_name].transform, "story_v_out_412102", "412102029", "story_v_out_412102.awb")

						arg_124_1:RecordAudio("412102029", var_127_11)
						arg_124_1:RecordAudio("412102029", var_127_11)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_412102", "412102029", "story_v_out_412102.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_412102", "412102029", "story_v_out_412102.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_12 = math.max(var_127_5, arg_124_1.talkMaxDuration)

			if var_127_4 <= arg_124_1.time_ and arg_124_1.time_ < var_127_4 + var_127_12 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_4) / var_127_12

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_4 + var_127_12 and arg_124_1.time_ < var_127_4 + var_127_12 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play412102030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 412102030
		arg_128_1.duration_ = 5.3

		local var_128_0 = {
			zh = 5.3,
			ja = 1.999999999999
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
				arg_128_0:Play412102031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1097ui_story"]) and arg_128_1.var_.characterEffect1097ui_story == nil then
				arg_128_1.var_.characterEffect1097ui_story = arg_128_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1097ui_story"]) then
				if arg_128_1.var_.characterEffect1097ui_story and not isNil(arg_128_1.actors_["1097ui_story"]) then
					arg_128_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1097ui_story"]) and arg_128_1.var_.characterEffect1097ui_story then
				arg_128_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_131_2 = arg_128_1.actors_["1197ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1197ui_story == nil then
				arg_128_1.var_.characterEffect1197ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1197ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1197ui_story then
				arg_128_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_131_4 = 0
			local var_131_5 = 0.375

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(412102030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 15 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 15)

				if (15 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 15)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102030", "story_v_out_412102.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102030", "story_v_out_412102.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_412102", "412102030", "story_v_out_412102.awb")

						arg_128_1:RecordAudio("412102030", var_131_11)
						arg_128_1:RecordAudio("412102030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_412102", "412102030", "story_v_out_412102.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_412102", "412102030", "story_v_out_412102.awb")
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
	Play412102031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 412102031
		arg_132_1.duration_ = 10.5

		local var_132_0 = {
			zh = 10.5,
			ja = 8.8
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play412102032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1097ui_story"]) and arg_132_1.var_.characterEffect1097ui_story == nil then
				arg_132_1.var_.characterEffect1097ui_story = arg_132_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1097ui_story"]) then
				if arg_132_1.var_.characterEffect1097ui_story and not isNil(arg_132_1.actors_["1097ui_story"]) then
					arg_132_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1097ui_story"]) and arg_132_1.var_.characterEffect1097ui_story then
				arg_132_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_135_1 = arg_132_1.actors_["1197ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1197ui_story == nil then
				arg_132_1.var_.characterEffect1197ui_story = var_135_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_2 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_2 and not isNil(var_135_1) then
				if arg_132_1.var_.characterEffect1197ui_story and not isNil(var_135_1) then
					arg_132_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_2 and arg_132_1.time_ < 0 + var_135_2 + arg_135_0 and not isNil(var_135_1) and arg_132_1.var_.characterEffect1197ui_story then
				arg_132_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_135_4 = 0
			local var_135_5 = 0.975

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(412102031)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 39 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 39)

				if (39 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 39)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102031", "story_v_out_412102.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102031", "story_v_out_412102.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_412102", "412102031", "story_v_out_412102.awb")

						arg_132_1:RecordAudio("412102031", var_135_11)
						arg_132_1:RecordAudio("412102031", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_412102", "412102031", "story_v_out_412102.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_412102", "412102031", "story_v_out_412102.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play412102032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 412102032
		arg_136_1.duration_ = 6.5

		local var_136_0 = {
			zh = 2.033,
			ja = 6.5
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
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play412102033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1097ui_story"]) and arg_136_1.var_.characterEffect1097ui_story == nil then
				arg_136_1.var_.characterEffect1097ui_story = arg_136_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1097ui_story"]) then
				if arg_136_1.var_.characterEffect1097ui_story and not isNil(arg_136_1.actors_["1097ui_story"]) then
					arg_136_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1097ui_story"]) and arg_136_1.var_.characterEffect1097ui_story then
				arg_136_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_139_2 = arg_136_1.actors_["1197ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1197ui_story == nil then
				arg_136_1.var_.characterEffect1197ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1197ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1197ui_story then
				arg_136_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_139_4 = 0
			local var_139_5 = 0.15

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(412102032)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 6 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 6)

				if (6 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 6)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102032", "story_v_out_412102.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102032", "story_v_out_412102.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_412102", "412102032", "story_v_out_412102.awb")

						arg_136_1:RecordAudio("412102032", var_139_11)
						arg_136_1:RecordAudio("412102032", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_412102", "412102032", "story_v_out_412102.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_412102", "412102032", "story_v_out_412102.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play412102033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 412102033
		arg_140_1.duration_ = 8.7

		local var_140_0 = {
			zh = 8.266,
			ja = 8.7
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play412102034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1097ui_story"]) and arg_140_1.var_.characterEffect1097ui_story == nil then
				arg_140_1.var_.characterEffect1097ui_story = arg_140_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1097ui_story"]) then
				if arg_140_1.var_.characterEffect1097ui_story and not isNil(arg_140_1.actors_["1097ui_story"]) then
					arg_140_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1097ui_story"]) and arg_140_1.var_.characterEffect1097ui_story then
				arg_140_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_143_1 = arg_140_1.actors_["1197ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1197ui_story == nil then
				arg_140_1.var_.characterEffect1197ui_story = var_143_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 and not isNil(var_143_1) then
				if arg_140_1.var_.characterEffect1197ui_story and not isNil(var_143_1) then
					arg_140_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1197ui_story then
				arg_140_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_143_4 = 0
			local var_143_5 = 0.75

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_6 = arg_140_1:GetWordFromCfg(412102033)
				local var_143_7 = arg_140_1:FormatText(var_143_6.content)

				arg_140_1.text_.text = var_143_7

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_9 = 30 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 30)

				if (30 <= 0 and var_143_5 or var_143_5 * (utf8.len(var_143_7) / 30)) > 0 and var_143_5 < var_143_9 then
					arg_140_1.talkMaxDuration = var_143_9

					if var_143_9 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_9 + var_143_4
					end
				end

				arg_140_1.text_.text = var_143_7
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102033", "story_v_out_412102.awb") ~= 0 then
					local var_143_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102033", "story_v_out_412102.awb") / 1000

					if var_143_10 + var_143_4 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_10 + var_143_4
					end

					if var_143_6.prefab_name ~= "" and arg_140_1.actors_[var_143_6.prefab_name] ~= nil then
						local var_143_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_6.prefab_name].transform, "story_v_out_412102", "412102033", "story_v_out_412102.awb")

						arg_140_1:RecordAudio("412102033", var_143_11)
						arg_140_1:RecordAudio("412102033", var_143_11)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_412102", "412102033", "story_v_out_412102.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_412102", "412102033", "story_v_out_412102.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_12 = math.max(var_143_5, arg_140_1.talkMaxDuration)

			if var_143_4 <= arg_140_1.time_ and arg_140_1.time_ < var_143_4 + var_143_12 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_4) / var_143_12

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_4 + var_143_12 and arg_140_1.time_ < var_143_4 + var_143_12 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play412102034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 412102034
		arg_144_1.duration_ = 8.2

		local var_144_0 = {
			zh = 5.033,
			ja = 8.2
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play412102035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1097ui_story"]) and arg_144_1.var_.characterEffect1097ui_story == nil then
				arg_144_1.var_.characterEffect1097ui_story = arg_144_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1097ui_story"]) then
				if arg_144_1.var_.characterEffect1097ui_story and not isNil(arg_144_1.actors_["1097ui_story"]) then
					arg_144_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1097ui_story"]) and arg_144_1.var_.characterEffect1097ui_story then
				arg_144_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_147_2 = arg_144_1.actors_["1197ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1197ui_story == nil then
				arg_144_1.var_.characterEffect1197ui_story = var_147_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_3 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_3 and not isNil(var_147_2) then
				if arg_144_1.var_.characterEffect1197ui_story and not isNil(var_147_2) then
					arg_144_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_3)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_3 and arg_144_1.time_ < 0 + var_147_3 + arg_147_0 and not isNil(var_147_2) and arg_144_1.var_.characterEffect1197ui_story then
				arg_144_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_147_4 = 0
			local var_147_5 = 0.525

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(412102034)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 21 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 21)

				if (21 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 21)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102034", "story_v_out_412102.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102034", "story_v_out_412102.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_412102", "412102034", "story_v_out_412102.awb")

						arg_144_1:RecordAudio("412102034", var_147_11)
						arg_144_1:RecordAudio("412102034", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_412102", "412102034", "story_v_out_412102.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_412102", "412102034", "story_v_out_412102.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play412102035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 412102035
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play412102036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1097ui_story = arg_148_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1097ui_story"].transform.position).z)
				arg_148_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1097ui_story"].transform.localEulerAngles = arg_148_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1097ui_story"].transform.position).z)
				arg_148_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1097ui_story"].transform.localEulerAngles = arg_148_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1097ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1097ui_story == nil then
				arg_148_1.var_.characterEffect1097ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1097ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_148_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_2)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1097ui_story then
				arg_148_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_148_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_151_3 = arg_148_1.actors_["1197ui_story"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1197ui_story = var_151_3.localPosition
			end

			local var_151_4 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_4 then
				var_151_3.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_4)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_4 and arg_148_1.time_ < 0 + var_151_4 + arg_151_0 then
				var_151_3.localPosition = Vector3.New(0, 100, 0)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles
			end

			local var_151_5 = 0
			local var_151_6 = 0.35

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_5 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, false)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_7 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(412102035).content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 14 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_7) / 14)

				if (14 <= 0 and var_151_6 or var_151_6 * (utf8.len(var_151_7) / 14)) > 0 and var_151_6 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_5 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_5
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_10 = math.max(var_151_6, arg_148_1.talkMaxDuration)

			if var_151_5 <= arg_148_1.time_ and arg_148_1.time_ < var_151_5 + var_151_10 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_5) / var_151_10

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_5 + var_151_10 and arg_148_1.time_ < var_151_5 + var_151_10 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play412102036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 412102036
		arg_152_1.duration_ = 16.13

		local var_152_0 = {
			zh = 4.666,
			ja = 16.133
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play412102037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1097ui_story"]) and arg_152_1.var_.characterEffect1097ui_story == nil then
				arg_152_1.var_.characterEffect1097ui_story = arg_152_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1097ui_story"]) then
				if arg_152_1.var_.characterEffect1097ui_story and not isNil(arg_152_1.actors_["1097ui_story"]) then
					arg_152_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1097ui_story"]) and arg_152_1.var_.characterEffect1097ui_story then
				arg_152_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_155_2 = arg_152_1.actors_["1097ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1097ui_story = var_155_2.localPosition
			end

			local var_155_3 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_3 then
				var_155_2.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_152_1.time_ - 0) / var_155_3)
				var_155_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_2.position).x, (manager.ui.mainCamera.transform.position - var_155_2.position).y, (manager.ui.mainCamera.transform.position - var_155_2.position).z)
				var_155_2.localEulerAngles.z = 0
				var_155_2.localEulerAngles.x = 0
				var_155_2.localEulerAngles = var_155_2.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_3 and arg_152_1.time_ < 0 + var_155_3 + arg_155_0 then
				var_155_2.localPosition = Vector3.New(0, -0.54, -6.3)
				var_155_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_2.position).x, (manager.ui.mainCamera.transform.position - var_155_2.position).y, (manager.ui.mainCamera.transform.position - var_155_2.position).z)
				var_155_2.localEulerAngles.z = 0
				var_155_2.localEulerAngles.x = 0
				var_155_2.localEulerAngles = var_155_2.localEulerAngles
			end

			local var_155_4 = 0
			local var_155_5 = 0.5

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(412102036)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 20 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 20)

				if (20 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 20)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102036", "story_v_out_412102.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102036", "story_v_out_412102.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_412102", "412102036", "story_v_out_412102.awb")

						arg_152_1:RecordAudio("412102036", var_155_11)
						arg_152_1:RecordAudio("412102036", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_412102", "412102036", "story_v_out_412102.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_412102", "412102036", "story_v_out_412102.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play412102037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 412102037
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play412102038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1097ui_story"]) and arg_156_1.var_.characterEffect1097ui_story == nil then
				arg_156_1.var_.characterEffect1097ui_story = arg_156_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1097ui_story"]) then
				if arg_156_1.var_.characterEffect1097ui_story and not isNil(arg_156_1.actors_["1097ui_story"]) then
					arg_156_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1097ui_story"]) and arg_156_1.var_.characterEffect1097ui_story then
				arg_156_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_159_1 = 0
			local var_159_2 = 0.075

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(412102037).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 3 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 3)

				if (3 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 3)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play412102038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 412102038
		arg_160_1.duration_ = 3.37

		local var_160_0 = {
			zh = 1.999999999999,
			ja = 3.366
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play412102039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["1097ui_story"]) and arg_160_1.var_.characterEffect1097ui_story == nil then
				arg_160_1.var_.characterEffect1097ui_story = arg_160_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.200000002980232

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["1097ui_story"]) then
				if arg_160_1.var_.characterEffect1097ui_story and not isNil(arg_160_1.actors_["1097ui_story"]) then
					arg_160_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["1097ui_story"]) and arg_160_1.var_.characterEffect1097ui_story then
				arg_160_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_163_2 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_2 + 1 and arg_160_1.time_ < var_163_2 + 1 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_3 = 0
			local var_163_4 = 1

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:GetWordFromCfg(412102038)
				local var_163_6 = arg_160_1:FormatText(var_163_5.content)

				arg_160_1.text_.text = var_163_6

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_8 = 6 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_6) / 6)

				if (6 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_6) / 6)) > 0 and var_163_4 < var_163_8 then
					arg_160_1.talkMaxDuration = var_163_8

					if var_163_8 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_8 + var_163_3
					end
				end

				arg_160_1.text_.text = var_163_6
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102038", "story_v_out_412102.awb") ~= 0 then
					local var_163_9 = manager.audio:GetVoiceLength("story_v_out_412102", "412102038", "story_v_out_412102.awb") / 1000

					if var_163_9 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_9 + var_163_3
					end

					if var_163_5.prefab_name ~= "" and arg_160_1.actors_[var_163_5.prefab_name] ~= nil then
						local var_163_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_5.prefab_name].transform, "story_v_out_412102", "412102038", "story_v_out_412102.awb")

						arg_160_1:RecordAudio("412102038", var_163_10)
						arg_160_1:RecordAudio("412102038", var_163_10)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_412102", "412102038", "story_v_out_412102.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_412102", "412102038", "story_v_out_412102.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_11 = math.max(var_163_4, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_11 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_3) / var_163_11

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_11 and arg_160_1.time_ < var_163_3 + var_163_11 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play412102039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 412102039
		arg_164_1.duration_ = 5

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play412102040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["1097ui_story"]) and arg_164_1.var_.characterEffect1097ui_story == nil then
				arg_164_1.var_.characterEffect1097ui_story = arg_164_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["1097ui_story"]) then
				if arg_164_1.var_.characterEffect1097ui_story and not isNil(arg_164_1.actors_["1097ui_story"]) then
					arg_164_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_164_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_0)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["1097ui_story"]) and arg_164_1.var_.characterEffect1097ui_story then
				arg_164_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_164_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_167_1 = 0
			local var_167_2 = 0.95

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_1 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, false)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_3 = arg_164_1:FormatText(arg_164_1:GetWordFromCfg(412102039).content)

				arg_164_1.text_.text = var_167_3

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_5 = 38 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 38)

				if (38 <= 0 and var_167_2 or var_167_2 * (utf8.len(var_167_3) / 38)) > 0 and var_167_2 < var_167_5 then
					arg_164_1.talkMaxDuration = var_167_5

					if var_167_5 + var_167_1 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + var_167_1
					end
				end

				arg_164_1.text_.text = var_167_3
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)
				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_6 = math.max(var_167_2, arg_164_1.talkMaxDuration)

			if var_167_1 <= arg_164_1.time_ and arg_164_1.time_ < var_167_1 + var_167_6 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_1) / var_167_6

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_1 + var_167_6 and arg_164_1.time_ < var_167_1 + var_167_6 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play412102040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 412102040
		arg_168_1.duration_ = 3.27

		local var_168_0 = {
			zh = 1.999999999999,
			ja = 3.266
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play412102041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1197ui_story = arg_168_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1197ui_story, Vector3.New(0.7, -0.545, -6.3), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1197ui_story"].transform.position).z)
				arg_168_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1197ui_story"].transform.localEulerAngles = arg_168_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0.7, -0.545, -6.3)
				arg_168_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1197ui_story"].transform.position).z)
				arg_168_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1197ui_story"].transform.localEulerAngles = arg_168_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			local var_171_1 = arg_168_1.actors_["1197ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1197ui_story == nil then
				arg_168_1.var_.characterEffect1197ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.2

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect1197ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect1197ui_story then
				arg_168_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_171_4 = arg_168_1.actors_["1097ui_story"].transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1097ui_story = var_171_4.localPosition
			end

			local var_171_5 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_5 then
				var_171_4.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_168_1.time_ - 0) / var_171_5)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_5 and arg_168_1.time_ < 0 + var_171_5 + arg_171_0 then
				var_171_4.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_171_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_171_4.position).x, (manager.ui.mainCamera.transform.position - var_171_4.position).y, (manager.ui.mainCamera.transform.position - var_171_4.position).z)
				var_171_4.localEulerAngles.z = 0
				var_171_4.localEulerAngles.x = 0
				var_171_4.localEulerAngles = var_171_4.localEulerAngles
			end

			local var_171_6 = 0
			local var_171_7 = 0.075

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_6 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_8 = arg_168_1:GetWordFromCfg(412102040)
				local var_171_9 = arg_168_1:FormatText(var_171_8.content)

				arg_168_1.text_.text = var_171_9

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_11 = 3 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 3)

				if (3 <= 0 and var_171_7 or var_171_7 * (utf8.len(var_171_9) / 3)) > 0 and var_171_7 < var_171_11 then
					arg_168_1.talkMaxDuration = var_171_11

					if var_171_11 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_11 + var_171_6
					end
				end

				arg_168_1.text_.text = var_171_9
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102040", "story_v_out_412102.awb") ~= 0 then
					local var_171_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102040", "story_v_out_412102.awb") / 1000

					if var_171_12 + var_171_6 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_12 + var_171_6
					end

					if var_171_8.prefab_name ~= "" and arg_168_1.actors_[var_171_8.prefab_name] ~= nil then
						local var_171_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_8.prefab_name].transform, "story_v_out_412102", "412102040", "story_v_out_412102.awb")

						arg_168_1:RecordAudio("412102040", var_171_13)
						arg_168_1:RecordAudio("412102040", var_171_13)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_412102", "412102040", "story_v_out_412102.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_412102", "412102040", "story_v_out_412102.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_14 = math.max(var_171_7, arg_168_1.talkMaxDuration)

			if var_171_6 <= arg_168_1.time_ and arg_168_1.time_ < var_171_6 + var_171_14 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_6) / var_171_14

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_6 + var_171_14 and arg_168_1.time_ < var_171_6 + var_171_14 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play412102041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 412102041
		arg_172_1.duration_ = 8.53

		local var_172_0 = {
			zh = 8.533,
			ja = 5.7
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play412102042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["1097ui_story"]) and arg_172_1.var_.characterEffect1097ui_story == nil then
				arg_172_1.var_.characterEffect1097ui_story = arg_172_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["1097ui_story"]) then
				if arg_172_1.var_.characterEffect1097ui_story and not isNil(arg_172_1.actors_["1097ui_story"]) then
					arg_172_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["1097ui_story"]) and arg_172_1.var_.characterEffect1097ui_story then
				arg_172_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_175_2 = arg_172_1.actors_["1197ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect1197ui_story == nil then
				arg_172_1.var_.characterEffect1197ui_story = var_175_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_3 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_3 and not isNil(var_175_2) then
				if arg_172_1.var_.characterEffect1197ui_story and not isNil(var_175_2) then
					arg_172_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_3)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_3 and arg_172_1.time_ < 0 + var_175_3 + arg_175_0 and not isNil(var_175_2) and arg_172_1.var_.characterEffect1197ui_story then
				arg_172_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_175_4 = 0
			local var_175_5 = 0.925

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_4 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_6 = arg_172_1:GetWordFromCfg(412102041)
				local var_175_7 = arg_172_1:FormatText(var_175_6.content)

				arg_172_1.text_.text = var_175_7

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_9 = 37 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 37)

				if (37 <= 0 and var_175_5 or var_175_5 * (utf8.len(var_175_7) / 37)) > 0 and var_175_5 < var_175_9 then
					arg_172_1.talkMaxDuration = var_175_9

					if var_175_9 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_4
					end
				end

				arg_172_1.text_.text = var_175_7
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102041", "story_v_out_412102.awb") ~= 0 then
					local var_175_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102041", "story_v_out_412102.awb") / 1000

					if var_175_10 + var_175_4 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_10 + var_175_4
					end

					if var_175_6.prefab_name ~= "" and arg_172_1.actors_[var_175_6.prefab_name] ~= nil then
						local var_175_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_6.prefab_name].transform, "story_v_out_412102", "412102041", "story_v_out_412102.awb")

						arg_172_1:RecordAudio("412102041", var_175_11)
						arg_172_1:RecordAudio("412102041", var_175_11)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_412102", "412102041", "story_v_out_412102.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_412102", "412102041", "story_v_out_412102.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_12 = math.max(var_175_5, arg_172_1.talkMaxDuration)

			if var_175_4 <= arg_172_1.time_ and arg_172_1.time_ < var_175_4 + var_175_12 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_4) / var_175_12

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_4 + var_175_12 and arg_172_1.time_ < var_175_4 + var_175_12 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play412102042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 412102042
		arg_176_1.duration_ = 3.97

		local var_176_0 = {
			zh = 1.999999999999,
			ja = 3.966
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play412102043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["1097ui_story"]) and arg_176_1.var_.characterEffect1097ui_story == nil then
				arg_176_1.var_.characterEffect1097ui_story = arg_176_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_0 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 and not isNil(arg_176_1.actors_["1097ui_story"]) then
				if arg_176_1.var_.characterEffect1097ui_story and not isNil(arg_176_1.actors_["1097ui_story"]) then
					arg_176_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_176_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_176_1.time_ - 0) / var_179_0)
				end
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 and not isNil(arg_176_1.actors_["1097ui_story"]) and arg_176_1.var_.characterEffect1097ui_story then
				arg_176_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_176_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_179_1 = arg_176_1.actors_["1197ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1197ui_story == nil then
				arg_176_1.var_.characterEffect1197ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1197ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1197ui_story then
				arg_176_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action1_1")
			end

			local var_179_4 = 0
			local var_179_5 = 0.225

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(412102042)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 9 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 9)

				if (9 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 9)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102042", "story_v_out_412102.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102042", "story_v_out_412102.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_out_412102", "412102042", "story_v_out_412102.awb")

						arg_176_1:RecordAudio("412102042", var_179_11)
						arg_176_1:RecordAudio("412102042", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_412102", "412102042", "story_v_out_412102.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_412102", "412102042", "story_v_out_412102.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play412102043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 412102043
		arg_180_1.duration_ = 3.6

		local var_180_0 = {
			zh = 2.7,
			ja = 3.6
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play412102044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["1097ui_story"]) and arg_180_1.var_.characterEffect1097ui_story == nil then
				arg_180_1.var_.characterEffect1097ui_story = arg_180_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["1097ui_story"]) then
				if arg_180_1.var_.characterEffect1097ui_story and not isNil(arg_180_1.actors_["1097ui_story"]) then
					arg_180_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["1097ui_story"]) and arg_180_1.var_.characterEffect1097ui_story then
				arg_180_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_183_2 = arg_180_1.actors_["1197ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.characterEffect1197ui_story == nil then
				arg_180_1.var_.characterEffect1197ui_story = var_183_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_3 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_3 and not isNil(var_183_2) then
				if arg_180_1.var_.characterEffect1197ui_story and not isNil(var_183_2) then
					arg_180_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_3)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_3 and arg_180_1.time_ < 0 + var_183_3 + arg_183_0 and not isNil(var_183_2) and arg_180_1.var_.characterEffect1197ui_story then
				arg_180_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_183_4 = 0
			local var_183_5 = 0.275

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_6 = arg_180_1:GetWordFromCfg(412102043)
				local var_183_7 = arg_180_1:FormatText(var_183_6.content)

				arg_180_1.text_.text = var_183_7

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_9 = 11 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 11)

				if (11 <= 0 and var_183_5 or var_183_5 * (utf8.len(var_183_7) / 11)) > 0 and var_183_5 < var_183_9 then
					arg_180_1.talkMaxDuration = var_183_9

					if var_183_9 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_4
					end
				end

				arg_180_1.text_.text = var_183_7
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102043", "story_v_out_412102.awb") ~= 0 then
					local var_183_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102043", "story_v_out_412102.awb") / 1000

					if var_183_10 + var_183_4 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_10 + var_183_4
					end

					if var_183_6.prefab_name ~= "" and arg_180_1.actors_[var_183_6.prefab_name] ~= nil then
						local var_183_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_6.prefab_name].transform, "story_v_out_412102", "412102043", "story_v_out_412102.awb")

						arg_180_1:RecordAudio("412102043", var_183_11)
						arg_180_1:RecordAudio("412102043", var_183_11)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_412102", "412102043", "story_v_out_412102.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_412102", "412102043", "story_v_out_412102.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_12 = math.max(var_183_5, arg_180_1.talkMaxDuration)

			if var_183_4 <= arg_180_1.time_ and arg_180_1.time_ < var_183_4 + var_183_12 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_4) / var_183_12

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_4 + var_183_12 and arg_180_1.time_ < var_183_4 + var_183_12 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play412102044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 412102044
		arg_184_1.duration_ = 3.8

		local var_184_0 = {
			zh = 3.8,
			ja = 1.9
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play412102045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			local var_187_0 = 0.25

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_1 = arg_184_1:GetWordFromCfg(412102044)
				local var_187_2 = arg_184_1:FormatText(var_187_1.content)

				arg_184_1.text_.text = var_187_2

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_4 = 10 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 10)

				if (10 <= 0 and var_187_0 or var_187_0 * (utf8.len(var_187_2) / 10)) > 0 and var_187_0 < var_187_4 then
					arg_184_1.talkMaxDuration = var_187_4

					if var_187_4 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_4 + 0
					end
				end

				arg_184_1.text_.text = var_187_2
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102044", "story_v_out_412102.awb") ~= 0 then
					local var_187_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102044", "story_v_out_412102.awb") / 1000

					if var_187_5 + 0 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + 0
					end

					if var_187_1.prefab_name ~= "" and arg_184_1.actors_[var_187_1.prefab_name] ~= nil then
						local var_187_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_1.prefab_name].transform, "story_v_out_412102", "412102044", "story_v_out_412102.awb")

						arg_184_1:RecordAudio("412102044", var_187_6)
						arg_184_1:RecordAudio("412102044", var_187_6)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_412102", "412102044", "story_v_out_412102.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_412102", "412102044", "story_v_out_412102.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_7 = math.max(var_187_0, arg_184_1.talkMaxDuration)

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_7 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - 0) / var_187_7

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= 0 + var_187_7 and arg_184_1.time_ < 0 + var_187_7 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play412102045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 412102045
		arg_188_1.duration_ = 5

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play412102046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			local var_191_9000

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1097ui_story = arg_188_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_191_0 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 then
				arg_188_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 0) / var_191_0)
				arg_188_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1097ui_story"].transform.position).z)
				arg_188_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1097ui_story"].transform.localEulerAngles = arg_188_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 then
				arg_188_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_188_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_188_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_188_1.actors_["1097ui_story"].transform.position).z)
				arg_188_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_188_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_188_1.actors_["1097ui_story"].transform.localEulerAngles = arg_188_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_191_1 = arg_188_1.actors_["1097ui_story"]

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect1097ui_story == nil then
				arg_188_1.var_.characterEffect1097ui_story = var_191_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_2 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_2 and not isNil(var_191_1) then
				if arg_188_1.var_.characterEffect1097ui_story and not isNil(var_191_1) then
					arg_188_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_188_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_2)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_2 and arg_188_1.time_ < 0 + var_191_2 + arg_191_0 and not isNil(var_191_1) and arg_188_1.var_.characterEffect1097ui_story then
				arg_188_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_188_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1:AudioAction("play", "effect", "se_story_132", "se_story_132_clock", "")
			end

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				local var_191_4 = arg_188_1.var_.effectdidasheng1

				if not arg_188_1.var_.effectdidasheng1 then
					var_191_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ripple"), manager.ui.mainCamera.transform)
					var_191_4.name = "didasheng1"
					arg_188_1.var_.effectdidasheng1 = var_191_4
				else
					var_191_4.transform:SetParent(var_191_9000)
				end

				var_191_4.transform.localPosition = Vector3.New(0, 0, 0)
				var_191_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_191_6 = arg_188_1.actors_["1197ui_story"].transform

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 then
				arg_188_1.var_.moveOldPos1197ui_story = var_191_6.localPosition
			end

			local var_191_7 = 0.001

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_7 then
				var_191_6.localPosition = Vector3.Lerp(arg_188_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_188_1.time_ - 0) / var_191_7)
				var_191_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_6.position).x, (manager.ui.mainCamera.transform.position - var_191_6.position).y, (manager.ui.mainCamera.transform.position - var_191_6.position).z)
				var_191_6.localEulerAngles.z = 0
				var_191_6.localEulerAngles.x = 0
				var_191_6.localEulerAngles = var_191_6.localEulerAngles
			end

			if arg_188_1.time_ >= 0 + var_191_7 and arg_188_1.time_ < 0 + var_191_7 + arg_191_0 then
				var_191_6.localPosition = Vector3.New(0, 100, 0)
				var_191_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_191_6.position).x, (manager.ui.mainCamera.transform.position - var_191_6.position).y, (manager.ui.mainCamera.transform.position - var_191_6.position).z)
				var_191_6.localEulerAngles.z = 0
				var_191_6.localEulerAngles.x = 0
				var_191_6.localEulerAngles = var_191_6.localEulerAngles
			end

			local var_191_8 = 0
			local var_191_9 = 0.225

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_8 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, false)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_10 = arg_188_1:FormatText(arg_188_1:GetWordFromCfg(412102045).content)

				arg_188_1.text_.text = var_191_10

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_12 = 9 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_10) / 9)

				if (9 <= 0 and var_191_9 or var_191_9 * (utf8.len(var_191_10) / 9)) > 0 and var_191_9 < var_191_12 then
					arg_188_1.talkMaxDuration = var_191_12

					if var_191_12 + var_191_8 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_12 + var_191_8
					end
				end

				arg_188_1.text_.text = var_191_10
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)
				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_13 = math.max(var_191_9, arg_188_1.talkMaxDuration)

			if var_191_8 <= arg_188_1.time_ and arg_188_1.time_ < var_191_8 + var_191_13 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_8) / var_191_13

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_8 + var_191_13 and arg_188_1.time_ < var_191_8 + var_191_13 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_188_1:InitPlayNodeList()
	end,
	Play412102046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 412102046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play412102047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.65

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_1 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(412102046).content)

				arg_192_1.text_.text = var_195_1

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_3 = 26 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 26)

				if (26 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_1) / 26)) > 0 and var_195_0 < var_195_3 then
					arg_192_1.talkMaxDuration = var_195_3

					if var_195_3 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_3 + 0
					end
				end

				arg_192_1.text_.text = var_195_1
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_4 = math.max(var_195_0, arg_192_1.talkMaxDuration)

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - 0) / var_195_4

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play412102047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 412102047
		arg_196_1.duration_ = 5.4

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 5.4
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play412102048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.var_.moveOldPos1097ui_story = arg_196_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_199_0 = 0.001

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 then
				arg_196_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_196_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_196_1.time_ - 0) / var_199_0)
				arg_196_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1097ui_story"].transform.position).z)
				arg_196_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1097ui_story"].transform.localEulerAngles = arg_196_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 then
				arg_196_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_196_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_196_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_196_1.actors_["1097ui_story"].transform.position).z)
				arg_196_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_196_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_196_1.actors_["1097ui_story"].transform.localEulerAngles = arg_196_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_199_1 = arg_196_1.actors_["1097ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1097ui_story == nil then
				arg_196_1.var_.characterEffect1097ui_story = var_199_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_2 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_2 and not isNil(var_199_1) then
				if arg_196_1.var_.characterEffect1097ui_story and not isNil(var_199_1) then
					arg_196_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_2 and arg_196_1.time_ < 0 + var_199_2 + arg_199_0 and not isNil(var_199_1) and arg_196_1.var_.characterEffect1097ui_story then
				arg_196_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				if arg_196_1.var_.effectdidasheng1 then
					Object.Destroy(arg_196_1.var_.effectdidasheng1)

					arg_196_1.var_.effectdidasheng1 = nil
				end
			end

			local var_199_5 = 0
			local var_199_6 = 0.15

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_5 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_7 = arg_196_1:GetWordFromCfg(412102047)
				local var_199_8 = arg_196_1:FormatText(var_199_7.content)

				arg_196_1.text_.text = var_199_8

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_10 = 6 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 6)

				if (6 <= 0 and var_199_6 or var_199_6 * (utf8.len(var_199_8) / 6)) > 0 and var_199_6 < var_199_10 then
					arg_196_1.talkMaxDuration = var_199_10

					if var_199_10 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_5
					end
				end

				arg_196_1.text_.text = var_199_8
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102047", "story_v_out_412102.awb") ~= 0 then
					local var_199_11 = manager.audio:GetVoiceLength("story_v_out_412102", "412102047", "story_v_out_412102.awb") / 1000

					if var_199_11 + var_199_5 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_11 + var_199_5
					end

					if var_199_7.prefab_name ~= "" and arg_196_1.actors_[var_199_7.prefab_name] ~= nil then
						local var_199_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_7.prefab_name].transform, "story_v_out_412102", "412102047", "story_v_out_412102.awb")

						arg_196_1:RecordAudio("412102047", var_199_12)
						arg_196_1:RecordAudio("412102047", var_199_12)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_412102", "412102047", "story_v_out_412102.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_412102", "412102047", "story_v_out_412102.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_13 = math.max(var_199_6, arg_196_1.talkMaxDuration)

			if var_199_5 <= arg_196_1.time_ and arg_196_1.time_ < var_199_5 + var_199_13 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_5) / var_199_13

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_5 + var_199_13 and arg_196_1.time_ < var_199_5 + var_199_13 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_196_1:InitPlayNodeList()
	end,
	Play412102048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 412102048
		arg_200_1.duration_ = 9.03

		local var_200_0 = {
			zh = 3.266,
			ja = 9.033
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play412102049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 0.375

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:GetWordFromCfg(412102048)
				local var_203_2 = arg_200_1:FormatText(var_203_1.content)

				arg_200_1.text_.text = var_203_2

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_4 = 15 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 15)

				if (15 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_2) / 15)) > 0 and var_203_0 < var_203_4 then
					arg_200_1.talkMaxDuration = var_203_4

					if var_203_4 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_4 + 0
					end
				end

				arg_200_1.text_.text = var_203_2
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102048", "story_v_out_412102.awb") ~= 0 then
					local var_203_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102048", "story_v_out_412102.awb") / 1000

					if var_203_5 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + 0
					end

					if var_203_1.prefab_name ~= "" and arg_200_1.actors_[var_203_1.prefab_name] ~= nil then
						local var_203_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_1.prefab_name].transform, "story_v_out_412102", "412102048", "story_v_out_412102.awb")

						arg_200_1:RecordAudio("412102048", var_203_6)
						arg_200_1:RecordAudio("412102048", var_203_6)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_412102", "412102048", "story_v_out_412102.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_412102", "412102048", "story_v_out_412102.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_7 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_7 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_7

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_7 and arg_200_1.time_ < 0 + var_203_7 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play412102049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 412102049
		arg_204_1.duration_ = 16.2

		local var_204_0 = {
			zh = 11.6,
			ja = 16.2
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play412102050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			local var_207_0 = 1.275

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_1 = arg_204_1:GetWordFromCfg(412102049)
				local var_207_2 = arg_204_1:FormatText(var_207_1.content)

				arg_204_1.text_.text = var_207_2

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_4 = 50 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 50)

				if (50 <= 0 and var_207_0 or var_207_0 * (utf8.len(var_207_2) / 50)) > 0 and var_207_0 < var_207_4 then
					arg_204_1.talkMaxDuration = var_207_4

					if var_207_4 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_4 + 0
					end
				end

				arg_204_1.text_.text = var_207_2
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102049", "story_v_out_412102.awb") ~= 0 then
					local var_207_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102049", "story_v_out_412102.awb") / 1000

					if var_207_5 + 0 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_5 + 0
					end

					if var_207_1.prefab_name ~= "" and arg_204_1.actors_[var_207_1.prefab_name] ~= nil then
						local var_207_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_1.prefab_name].transform, "story_v_out_412102", "412102049", "story_v_out_412102.awb")

						arg_204_1:RecordAudio("412102049", var_207_6)
						arg_204_1:RecordAudio("412102049", var_207_6)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_412102", "412102049", "story_v_out_412102.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_412102", "412102049", "story_v_out_412102.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_7 = math.max(var_207_0, arg_204_1.talkMaxDuration)

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_7 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - 0) / var_207_7

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= 0 + var_207_7 and arg_204_1.time_ < 0 + var_207_7 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play412102050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 412102050
		arg_208_1.duration_ = 2

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play412102051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1097ui_story"]) and arg_208_1.var_.characterEffect1097ui_story == nil then
				arg_208_1.var_.characterEffect1097ui_story = arg_208_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1097ui_story"]) then
				if arg_208_1.var_.characterEffect1097ui_story and not isNil(arg_208_1.actors_["1097ui_story"]) then
					arg_208_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1097ui_story"]) and arg_208_1.var_.characterEffect1097ui_story then
				arg_208_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_211_1 = arg_208_1.actors_["1197ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1197ui_story = var_211_1.localPosition
			end

			local var_211_2 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_2 then
				var_211_1.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1197ui_story, Vector3.New(0.7, -0.545, -6.3), (arg_208_1.time_ - 0) / var_211_2)
				var_211_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_1.position).x, (manager.ui.mainCamera.transform.position - var_211_1.position).y, (manager.ui.mainCamera.transform.position - var_211_1.position).z)
				var_211_1.localEulerAngles.z = 0
				var_211_1.localEulerAngles.x = 0
				var_211_1.localEulerAngles = var_211_1.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_2 and arg_208_1.time_ < 0 + var_211_2 + arg_211_0 then
				var_211_1.localPosition = Vector3.New(0.7, -0.545, -6.3)
				var_211_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_1.position).x, (manager.ui.mainCamera.transform.position - var_211_1.position).y, (manager.ui.mainCamera.transform.position - var_211_1.position).z)
				var_211_1.localEulerAngles.z = 0
				var_211_1.localEulerAngles.x = 0
				var_211_1.localEulerAngles = var_211_1.localEulerAngles
			end

			local var_211_3 = arg_208_1.actors_["1197ui_story"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_3) and arg_208_1.var_.characterEffect1197ui_story == nil then
				arg_208_1.var_.characterEffect1197ui_story = var_211_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_4 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 and not isNil(var_211_3) then
				if arg_208_1.var_.characterEffect1197ui_story and not isNil(var_211_3) then
					arg_208_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 and not isNil(var_211_3) and arg_208_1.var_.characterEffect1197ui_story then
				arg_208_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_1")
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_211_6 = arg_208_1.actors_["1097ui_story"].transform

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos1097ui_story = var_211_6.localPosition
			end

			local var_211_7 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				var_211_6.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_208_1.time_ - 0) / var_211_7)
				var_211_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_6.position).x, (manager.ui.mainCamera.transform.position - var_211_6.position).y, (manager.ui.mainCamera.transform.position - var_211_6.position).z)
				var_211_6.localEulerAngles.z = 0
				var_211_6.localEulerAngles.x = 0
				var_211_6.localEulerAngles = var_211_6.localEulerAngles
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				var_211_6.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_211_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_211_6.position).x, (manager.ui.mainCamera.transform.position - var_211_6.position).y, (manager.ui.mainCamera.transform.position - var_211_6.position).z)
				var_211_6.localEulerAngles.z = 0
				var_211_6.localEulerAngles.x = 0
				var_211_6.localEulerAngles = var_211_6.localEulerAngles
			end

			local var_211_8 = 0
			local var_211_9 = 0.2

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_8 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_10 = arg_208_1:GetWordFromCfg(412102050)
				local var_211_11 = arg_208_1:FormatText(var_211_10.content)

				arg_208_1.text_.text = var_211_11

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_13 = 8 <= 0 and var_211_9 or var_211_9 * (utf8.len(var_211_11) / 8)

				if (8 <= 0 and var_211_9 or var_211_9 * (utf8.len(var_211_11) / 8)) > 0 and var_211_9 < var_211_13 then
					arg_208_1.talkMaxDuration = var_211_13

					if var_211_13 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_13 + var_211_8
					end
				end

				arg_208_1.text_.text = var_211_11
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102050", "story_v_out_412102.awb") ~= 0 then
					local var_211_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102050", "story_v_out_412102.awb") / 1000

					if var_211_14 + var_211_8 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_14 + var_211_8
					end

					if var_211_10.prefab_name ~= "" and arg_208_1.actors_[var_211_10.prefab_name] ~= nil then
						local var_211_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_10.prefab_name].transform, "story_v_out_412102", "412102050", "story_v_out_412102.awb")

						arg_208_1:RecordAudio("412102050", var_211_15)
						arg_208_1:RecordAudio("412102050", var_211_15)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_412102", "412102050", "story_v_out_412102.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_412102", "412102050", "story_v_out_412102.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_16 = math.max(var_211_9, arg_208_1.talkMaxDuration)

			if var_211_8 <= arg_208_1.time_ and arg_208_1.time_ < var_211_8 + var_211_16 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_8) / var_211_16

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_8 + var_211_16 and arg_208_1.time_ < var_211_8 + var_211_16 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play412102051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 412102051
		arg_212_1.duration_ = 9.43

		local var_212_0 = {
			zh = 3.566,
			ja = 9.433
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play412102052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["1097ui_story"]) and arg_212_1.var_.characterEffect1097ui_story == nil then
				arg_212_1.var_.characterEffect1097ui_story = arg_212_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_0 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 and not isNil(arg_212_1.actors_["1097ui_story"]) then
				if arg_212_1.var_.characterEffect1097ui_story and not isNil(arg_212_1.actors_["1097ui_story"]) then
					arg_212_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 and not isNil(arg_212_1.actors_["1097ui_story"]) and arg_212_1.var_.characterEffect1097ui_story then
				arg_212_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			local var_215_2 = arg_212_1.actors_["1197ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1197ui_story == nil then
				arg_212_1.var_.characterEffect1197ui_story = var_215_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_3 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 and not isNil(var_215_2) then
				if arg_212_1.var_.characterEffect1197ui_story and not isNil(var_215_2) then
					arg_212_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_212_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_212_1.time_ - 0) / var_215_3)
				end
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 and not isNil(var_215_2) and arg_212_1.var_.characterEffect1197ui_story then
				arg_212_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_212_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_215_4 = 0
			local var_215_5 = 0.35

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_4 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_6 = arg_212_1:GetWordFromCfg(412102051)
				local var_215_7 = arg_212_1:FormatText(var_215_6.content)

				arg_212_1.text_.text = var_215_7

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_9 = 14 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 14)

				if (14 <= 0 and var_215_5 or var_215_5 * (utf8.len(var_215_7) / 14)) > 0 and var_215_5 < var_215_9 then
					arg_212_1.talkMaxDuration = var_215_9

					if var_215_9 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_9 + var_215_4
					end
				end

				arg_212_1.text_.text = var_215_7
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102051", "story_v_out_412102.awb") ~= 0 then
					local var_215_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102051", "story_v_out_412102.awb") / 1000

					if var_215_10 + var_215_4 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_10 + var_215_4
					end

					if var_215_6.prefab_name ~= "" and arg_212_1.actors_[var_215_6.prefab_name] ~= nil then
						local var_215_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_6.prefab_name].transform, "story_v_out_412102", "412102051", "story_v_out_412102.awb")

						arg_212_1:RecordAudio("412102051", var_215_11)
						arg_212_1:RecordAudio("412102051", var_215_11)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_412102", "412102051", "story_v_out_412102.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_412102", "412102051", "story_v_out_412102.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_5, arg_212_1.talkMaxDuration)

			if var_215_4 <= arg_212_1.time_ and arg_212_1.time_ < var_215_4 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_4) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_4 + var_215_12 and arg_212_1.time_ < var_215_4 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play412102052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 412102052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play412102053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1097ui_story = arg_216_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_219_0 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 then
				arg_216_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_0)
				arg_216_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1097ui_story"].transform.position).z)
				arg_216_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1097ui_story"].transform.localEulerAngles = arg_216_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 then
				arg_216_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_216_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_216_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_216_1.actors_["1097ui_story"].transform.position).z)
				arg_216_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_216_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_216_1.actors_["1097ui_story"].transform.localEulerAngles = arg_216_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_219_1 = arg_216_1.actors_["1097ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1097ui_story == nil then
				arg_216_1.var_.characterEffect1097ui_story = var_219_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_2 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_2 and not isNil(var_219_1) then
				if arg_216_1.var_.characterEffect1097ui_story and not isNil(var_219_1) then
					arg_216_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_216_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_2)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_2 and arg_216_1.time_ < 0 + var_219_2 + arg_219_0 and not isNil(var_219_1) and arg_216_1.var_.characterEffect1097ui_story then
				arg_216_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_216_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_219_3 = arg_216_1.actors_["1197ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1197ui_story = var_219_3.localPosition
			end

			local var_219_4 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				var_219_3.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_216_1.time_ - 0) / var_219_4)
				var_219_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_3.position).x, (manager.ui.mainCamera.transform.position - var_219_3.position).y, (manager.ui.mainCamera.transform.position - var_219_3.position).z)
				var_219_3.localEulerAngles.z = 0
				var_219_3.localEulerAngles.x = 0
				var_219_3.localEulerAngles = var_219_3.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				var_219_3.localPosition = Vector3.New(0, 100, 0)
				var_219_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_3.position).x, (manager.ui.mainCamera.transform.position - var_219_3.position).y, (manager.ui.mainCamera.transform.position - var_219_3.position).z)
				var_219_3.localEulerAngles.z = 0
				var_219_3.localEulerAngles.x = 0
				var_219_3.localEulerAngles = var_219_3.localEulerAngles
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action9_2")
			end

			local var_219_5 = 0
			local var_219_6 = 1.125

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_5 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_7 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(412102052).content)

				arg_216_1.text_.text = var_219_7

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_9 = 45 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 45)

				if (45 <= 0 and var_219_6 or var_219_6 * (utf8.len(var_219_7) / 45)) > 0 and var_219_6 < var_219_9 then
					arg_216_1.talkMaxDuration = var_219_9

					if var_219_9 + var_219_5 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_9 + var_219_5
					end
				end

				arg_216_1.text_.text = var_219_7
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_10 = math.max(var_219_6, arg_216_1.talkMaxDuration)

			if var_219_5 <= arg_216_1.time_ and arg_216_1.time_ < var_219_5 + var_219_10 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_5) / var_219_10

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_5 + var_219_10 and arg_216_1.time_ < var_219_5 + var_219_10 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play412102053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 412102053
		arg_220_1.duration_ = 4

		local var_220_0 = {
			zh = 2.966,
			ja = 4
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play412102054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["1097ui_story"]) and arg_220_1.var_.characterEffect1097ui_story == nil then
				arg_220_1.var_.characterEffect1097ui_story = arg_220_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_0 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 and not isNil(arg_220_1.actors_["1097ui_story"]) then
				if arg_220_1.var_.characterEffect1097ui_story and not isNil(arg_220_1.actors_["1097ui_story"]) then
					arg_220_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 and not isNil(arg_220_1.actors_["1097ui_story"]) and arg_220_1.var_.characterEffect1097ui_story then
				arg_220_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_223_2 = arg_220_1.actors_["1097ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1097ui_story = var_223_2.localPosition
			end

			local var_223_3 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 then
				var_223_2.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_220_1.time_ - 0) / var_223_3)
				var_223_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_2.position).x, (manager.ui.mainCamera.transform.position - var_223_2.position).y, (manager.ui.mainCamera.transform.position - var_223_2.position).z)
				var_223_2.localEulerAngles.z = 0
				var_223_2.localEulerAngles.x = 0
				var_223_2.localEulerAngles = var_223_2.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 then
				var_223_2.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_223_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_2.position).x, (manager.ui.mainCamera.transform.position - var_223_2.position).y, (manager.ui.mainCamera.transform.position - var_223_2.position).z)
				var_223_2.localEulerAngles.z = 0
				var_223_2.localEulerAngles.x = 0
				var_223_2.localEulerAngles = var_223_2.localEulerAngles
			end

			local var_223_4 = arg_220_1.actors_["1197ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1197ui_story = var_223_4.localPosition
			end

			local var_223_5 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_5 then
				var_223_4.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1197ui_story, Vector3.New(0.7, -0.545, -6.3), (arg_220_1.time_ - 0) / var_223_5)
				var_223_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_4.position).x, (manager.ui.mainCamera.transform.position - var_223_4.position).y, (manager.ui.mainCamera.transform.position - var_223_4.position).z)
				var_223_4.localEulerAngles.z = 0
				var_223_4.localEulerAngles.x = 0
				var_223_4.localEulerAngles = var_223_4.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_5 and arg_220_1.time_ < 0 + var_223_5 + arg_223_0 then
				var_223_4.localPosition = Vector3.New(0.7, -0.545, -6.3)
				var_223_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_4.position).x, (manager.ui.mainCamera.transform.position - var_223_4.position).y, (manager.ui.mainCamera.transform.position - var_223_4.position).z)
				var_223_4.localEulerAngles.z = 0
				var_223_4.localEulerAngles.x = 0
				var_223_4.localEulerAngles = var_223_4.localEulerAngles
			end

			local var_223_6 = 0
			local var_223_7 = 0.275

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_8 = arg_220_1:GetWordFromCfg(412102053)
				local var_223_9 = arg_220_1:FormatText(var_223_8.content)

				arg_220_1.text_.text = var_223_9

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 11 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 11)

				if (11 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 11)) > 0 and var_223_7 < var_223_11 then
					arg_220_1.talkMaxDuration = var_223_11

					if var_223_11 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_9
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102053", "story_v_out_412102.awb") ~= 0 then
					local var_223_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102053", "story_v_out_412102.awb") / 1000

					if var_223_12 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_12 + var_223_6
					end

					if var_223_8.prefab_name ~= "" and arg_220_1.actors_[var_223_8.prefab_name] ~= nil then
						local var_223_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_8.prefab_name].transform, "story_v_out_412102", "412102053", "story_v_out_412102.awb")

						arg_220_1:RecordAudio("412102053", var_223_13)
						arg_220_1:RecordAudio("412102053", var_223_13)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_412102", "412102053", "story_v_out_412102.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_412102", "412102053", "story_v_out_412102.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_14 and arg_220_1.time_ < var_223_6 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play412102054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 412102054
		arg_224_1.duration_ = 11.2

		local var_224_0 = {
			zh = 7.1,
			ja = 11.2
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play412102055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["1097ui_story"]) and arg_224_1.var_.characterEffect1097ui_story == nil then
				arg_224_1.var_.characterEffect1097ui_story = arg_224_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["1097ui_story"]) then
				if arg_224_1.var_.characterEffect1097ui_story and not isNil(arg_224_1.actors_["1097ui_story"]) then
					arg_224_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["1097ui_story"]) and arg_224_1.var_.characterEffect1097ui_story then
				arg_224_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_227_1 = arg_224_1.actors_["1197ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1197ui_story == nil then
				arg_224_1.var_.characterEffect1197ui_story = var_227_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_2 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_2 and not isNil(var_227_1) then
				if arg_224_1.var_.characterEffect1197ui_story and not isNil(var_227_1) then
					arg_224_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_2 and arg_224_1.time_ < 0 + var_227_2 + arg_227_0 and not isNil(var_227_1) and arg_224_1.var_.characterEffect1197ui_story then
				arg_224_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_227_4 = 0
			local var_227_5 = 0.875

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_4 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_6 = arg_224_1:GetWordFromCfg(412102054)
				local var_227_7 = arg_224_1:FormatText(var_227_6.content)

				arg_224_1.text_.text = var_227_7

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_9 = 35 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 35)

				if (35 <= 0 and var_227_5 or var_227_5 * (utf8.len(var_227_7) / 35)) > 0 and var_227_5 < var_227_9 then
					arg_224_1.talkMaxDuration = var_227_9

					if var_227_9 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_9 + var_227_4
					end
				end

				arg_224_1.text_.text = var_227_7
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102054", "story_v_out_412102.awb") ~= 0 then
					local var_227_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102054", "story_v_out_412102.awb") / 1000

					if var_227_10 + var_227_4 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_10 + var_227_4
					end

					if var_227_6.prefab_name ~= "" and arg_224_1.actors_[var_227_6.prefab_name] ~= nil then
						local var_227_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_6.prefab_name].transform, "story_v_out_412102", "412102054", "story_v_out_412102.awb")

						arg_224_1:RecordAudio("412102054", var_227_11)
						arg_224_1:RecordAudio("412102054", var_227_11)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_412102", "412102054", "story_v_out_412102.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_412102", "412102054", "story_v_out_412102.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_12 = math.max(var_227_5, arg_224_1.talkMaxDuration)

			if var_227_4 <= arg_224_1.time_ and arg_224_1.time_ < var_227_4 + var_227_12 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_4) / var_227_12

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_4 + var_227_12 and arg_224_1.time_ < var_227_4 + var_227_12 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play412102055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 412102055
		arg_228_1.duration_ = 2.3

		local var_228_0 = {
			zh = 2.233,
			ja = 2.3
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play412102056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(arg_228_1.actors_["1097ui_story"]) and arg_228_1.var_.characterEffect1097ui_story == nil then
				arg_228_1.var_.characterEffect1097ui_story = arg_228_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_0 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 and not isNil(arg_228_1.actors_["1097ui_story"]) then
				if arg_228_1.var_.characterEffect1097ui_story and not isNil(arg_228_1.actors_["1097ui_story"]) then
					arg_228_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 and not isNil(arg_228_1.actors_["1097ui_story"]) and arg_228_1.var_.characterEffect1097ui_story then
				arg_228_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_231_2 = arg_228_1.actors_["1197ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1197ui_story == nil then
				arg_228_1.var_.characterEffect1197ui_story = var_231_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_3 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_3 and not isNil(var_231_2) then
				if arg_228_1.var_.characterEffect1197ui_story and not isNil(var_231_2) then
					arg_228_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_228_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_228_1.time_ - 0) / var_231_3)
				end
			end

			if arg_228_1.time_ >= 0 + var_231_3 and arg_228_1.time_ < 0 + var_231_3 + arg_231_0 and not isNil(var_231_2) and arg_228_1.var_.characterEffect1197ui_story then
				arg_228_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_228_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			local var_231_4 = 0
			local var_231_5 = 0.2

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(412102055)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 8 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 8)

				if (8 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 8)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102055", "story_v_out_412102.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102055", "story_v_out_412102.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_412102", "412102055", "story_v_out_412102.awb")

						arg_228_1:RecordAudio("412102055", var_231_11)
						arg_228_1:RecordAudio("412102055", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_412102", "412102055", "story_v_out_412102.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_412102", "412102055", "story_v_out_412102.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play412102056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 412102056
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play412102057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1097ui_story = arg_232_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_235_0 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 then
				arg_232_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_0)
				arg_232_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1097ui_story"].transform.position).z)
				arg_232_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1097ui_story"].transform.localEulerAngles = arg_232_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 then
				arg_232_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_232_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_232_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_232_1.actors_["1097ui_story"].transform.position).z)
				arg_232_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_232_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_232_1.actors_["1097ui_story"].transform.localEulerAngles = arg_232_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_235_1 = arg_232_1.actors_["1097ui_story"]

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1097ui_story == nil then
				arg_232_1.var_.characterEffect1097ui_story = var_235_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_2 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_2 and not isNil(var_235_1) then
				if arg_232_1.var_.characterEffect1097ui_story and not isNil(var_235_1) then
					arg_232_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_2)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_2 and arg_232_1.time_ < 0 + var_235_2 + arg_235_0 and not isNil(var_235_1) and arg_232_1.var_.characterEffect1097ui_story then
				arg_232_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_235_3 = arg_232_1.actors_["1197ui_story"].transform

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.var_.moveOldPos1197ui_story = var_235_3.localPosition
			end

			local var_235_4 = 0.001

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				var_235_3.localPosition = Vector3.Lerp(arg_232_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_232_1.time_ - 0) / var_235_4)
				var_235_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_3.position).x, (manager.ui.mainCamera.transform.position - var_235_3.position).y, (manager.ui.mainCamera.transform.position - var_235_3.position).z)
				var_235_3.localEulerAngles.z = 0
				var_235_3.localEulerAngles.x = 0
				var_235_3.localEulerAngles = var_235_3.localEulerAngles
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				var_235_3.localPosition = Vector3.New(0, 100, 0)
				var_235_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_235_3.position).x, (manager.ui.mainCamera.transform.position - var_235_3.position).y, (manager.ui.mainCamera.transform.position - var_235_3.position).z)
				var_235_3.localEulerAngles.z = 0
				var_235_3.localEulerAngles.x = 0
				var_235_3.localEulerAngles = var_235_3.localEulerAngles
			end

			local var_235_5 = 0
			local var_235_6 = 1

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_5 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_7 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(412102056).content)

				arg_232_1.text_.text = var_235_7

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_9 = 40 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_7) / 40)

				if (40 <= 0 and var_235_6 or var_235_6 * (utf8.len(var_235_7) / 40)) > 0 and var_235_6 < var_235_9 then
					arg_232_1.talkMaxDuration = var_235_9

					if var_235_9 + var_235_5 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_9 + var_235_5
					end
				end

				arg_232_1.text_.text = var_235_7
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_10 = math.max(var_235_6, arg_232_1.talkMaxDuration)

			if var_235_5 <= arg_232_1.time_ and arg_232_1.time_ < var_235_5 + var_235_10 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_5) / var_235_10

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_5 + var_235_10 and arg_232_1.time_ < var_235_5 + var_235_10 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_232_1:InitPlayNodeList()
	end,
	Play412102057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 412102057
		arg_236_1.duration_ = 6.87

		local var_236_0 = {
			zh = 3.4,
			ja = 6.866
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play412102058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.var_.moveOldPos1197ui_story = arg_236_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_239_0 = 0.001

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_0 then
				arg_236_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_236_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_236_1.time_ - 0) / var_239_0)
				arg_236_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1197ui_story"].transform.position).z)
				arg_236_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1197ui_story"].transform.localEulerAngles = arg_236_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_236_1.time_ >= 0 + var_239_0 and arg_236_1.time_ < 0 + var_239_0 + arg_239_0 then
				arg_236_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_236_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_236_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_236_1.actors_["1197ui_story"].transform.position).z)
				arg_236_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_236_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_236_1.actors_["1197ui_story"].transform.localEulerAngles = arg_236_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_239_1 = arg_236_1.actors_["1197ui_story"]

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1197ui_story == nil then
				arg_236_1.var_.characterEffect1197ui_story = var_239_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_239_2 = 0.2

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_2 and not isNil(var_239_1) then
				if arg_236_1.var_.characterEffect1197ui_story and not isNil(var_239_1) then
					arg_236_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_236_1.time_ >= 0 + var_239_2 and arg_236_1.time_ < 0 + var_239_2 + arg_239_0 and not isNil(var_239_1) and arg_236_1.var_.characterEffect1197ui_story then
				arg_236_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_239_4 = 0
			local var_239_5 = 0.35

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:GetWordFromCfg(412102057)
				local var_239_7 = arg_236_1:FormatText(var_239_6.content)

				arg_236_1.text_.text = var_239_7

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_9 = 14 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 14)

				if (14 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_7) / 14)) > 0 and var_239_5 < var_239_9 then
					arg_236_1.talkMaxDuration = var_239_9

					if var_239_9 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_9 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_7
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102057", "story_v_out_412102.awb") ~= 0 then
					local var_239_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102057", "story_v_out_412102.awb") / 1000

					if var_239_10 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_10 + var_239_4
					end

					if var_239_6.prefab_name ~= "" and arg_236_1.actors_[var_239_6.prefab_name] ~= nil then
						local var_239_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_6.prefab_name].transform, "story_v_out_412102", "412102057", "story_v_out_412102.awb")

						arg_236_1:RecordAudio("412102057", var_239_11)
						arg_236_1:RecordAudio("412102057", var_239_11)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_412102", "412102057", "story_v_out_412102.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_412102", "412102057", "story_v_out_412102.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_12 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_12 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_12

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_12 and arg_236_1.time_ < var_239_4 + var_239_12 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_236_1:InitPlayNodeList()
	end,
	Play412102058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 412102058
		arg_240_1.duration_ = 5.97

		local var_240_0 = {
			zh = 1.999999999999,
			ja = 5.966
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play412102059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1097ui_story = arg_240_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1097ui_story"].transform.position).z)
				arg_240_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1097ui_story"].transform.localEulerAngles = arg_240_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_240_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1097ui_story"].transform.position).z)
				arg_240_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1097ui_story"].transform.localEulerAngles = arg_240_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["1097ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1097ui_story == nil then
				arg_240_1.var_.characterEffect1097ui_story = var_243_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_2 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_2 and not isNil(var_243_1) then
				if arg_240_1.var_.characterEffect1097ui_story and not isNil(var_243_1) then
					arg_240_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_2 and arg_240_1.time_ < 0 + var_243_2 + arg_243_0 and not isNil(var_243_1) and arg_240_1.var_.characterEffect1097ui_story then
				arg_240_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_243_4 = arg_240_1.actors_["1197ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1197ui_story = var_243_4.localPosition
			end

			local var_243_5 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_5 then
				var_243_4.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_5)
				var_243_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_4.position).x, (manager.ui.mainCamera.transform.position - var_243_4.position).y, (manager.ui.mainCamera.transform.position - var_243_4.position).z)
				var_243_4.localEulerAngles.z = 0
				var_243_4.localEulerAngles.x = 0
				var_243_4.localEulerAngles = var_243_4.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_5 and arg_240_1.time_ < 0 + var_243_5 + arg_243_0 then
				var_243_4.localPosition = Vector3.New(0, 100, 0)
				var_243_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_4.position).x, (manager.ui.mainCamera.transform.position - var_243_4.position).y, (manager.ui.mainCamera.transform.position - var_243_4.position).z)
				var_243_4.localEulerAngles.z = 0
				var_243_4.localEulerAngles.x = 0
				var_243_4.localEulerAngles = var_243_4.localEulerAngles
			end

			local var_243_6 = 0
			local var_243_7 = 0.125

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_6 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_8 = arg_240_1:GetWordFromCfg(412102058)
				local var_243_9 = arg_240_1:FormatText(var_243_8.content)

				arg_240_1.text_.text = var_243_9

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_11 = 5 <= 0 and var_243_7 or var_243_7 * (utf8.len(var_243_9) / 5)

				if (5 <= 0 and var_243_7 or var_243_7 * (utf8.len(var_243_9) / 5)) > 0 and var_243_7 < var_243_11 then
					arg_240_1.talkMaxDuration = var_243_11

					if var_243_11 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_11 + var_243_6
					end
				end

				arg_240_1.text_.text = var_243_9
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102058", "story_v_out_412102.awb") ~= 0 then
					local var_243_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102058", "story_v_out_412102.awb") / 1000

					if var_243_12 + var_243_6 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_6
					end

					if var_243_8.prefab_name ~= "" and arg_240_1.actors_[var_243_8.prefab_name] ~= nil then
						local var_243_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_8.prefab_name].transform, "story_v_out_412102", "412102058", "story_v_out_412102.awb")

						arg_240_1:RecordAudio("412102058", var_243_13)
						arg_240_1:RecordAudio("412102058", var_243_13)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_412102", "412102058", "story_v_out_412102.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_412102", "412102058", "story_v_out_412102.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_14 = math.max(var_243_7, arg_240_1.talkMaxDuration)

			if var_243_6 <= arg_240_1.time_ and arg_240_1.time_ < var_243_6 + var_243_14 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_6) / var_243_14

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_6 + var_243_14 and arg_240_1.time_ < var_243_6 + var_243_14 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play412102059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 412102059
		arg_244_1.duration_ = 4.23

		local var_244_0 = {
			zh = 2,
			ja = 4.233
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play412102060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["1097ui_story"]) and arg_244_1.var_.characterEffect1097ui_story == nil then
				arg_244_1.var_.characterEffect1097ui_story = arg_244_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["1097ui_story"]) then
				if arg_244_1.var_.characterEffect1097ui_story and not isNil(arg_244_1.actors_["1097ui_story"]) then
					arg_244_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_244_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["1097ui_story"]) and arg_244_1.var_.characterEffect1097ui_story then
				arg_244_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_244_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_247_1 = arg_244_1.actors_["1097ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1097ui_story = var_247_1.localPosition
			end

			local var_247_2 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 then
				var_247_1.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_244_1.time_ - 0) / var_247_2)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 then
				var_247_1.localPosition = Vector3.New(0, 100, 0)
				var_247_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_1.position).x, (manager.ui.mainCamera.transform.position - var_247_1.position).y, (manager.ui.mainCamera.transform.position - var_247_1.position).z)
				var_247_1.localEulerAngles.z = 0
				var_247_1.localEulerAngles.x = 0
				var_247_1.localEulerAngles = var_247_1.localEulerAngles
			end

			local var_247_3 = arg_244_1.actors_["1197ui_story"].transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos1197ui_story = var_247_3.localPosition
			end

			local var_247_4 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_4 then
				var_247_3.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_244_1.time_ - 0) / var_247_4)
				var_247_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_3.position).x, (manager.ui.mainCamera.transform.position - var_247_3.position).y, (manager.ui.mainCamera.transform.position - var_247_3.position).z)
				var_247_3.localEulerAngles.z = 0
				var_247_3.localEulerAngles.x = 0
				var_247_3.localEulerAngles = var_247_3.localEulerAngles
			end

			if arg_244_1.time_ >= 0 + var_247_4 and arg_244_1.time_ < 0 + var_247_4 + arg_247_0 then
				var_247_3.localPosition = Vector3.New(0, -0.545, -6.3)
				var_247_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_247_3.position).x, (manager.ui.mainCamera.transform.position - var_247_3.position).y, (manager.ui.mainCamera.transform.position - var_247_3.position).z)
				var_247_3.localEulerAngles.z = 0
				var_247_3.localEulerAngles.x = 0
				var_247_3.localEulerAngles = var_247_3.localEulerAngles
			end

			local var_247_5 = arg_244_1.actors_["1197ui_story"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_5) and arg_244_1.var_.characterEffect1197ui_story == nil then
				arg_244_1.var_.characterEffect1197ui_story = var_247_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_6 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_6 and not isNil(var_247_5) then
				if arg_244_1.var_.characterEffect1197ui_story and not isNil(var_247_5) then
					arg_244_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_244_1.time_ >= 0 + var_247_6 and arg_244_1.time_ < 0 + var_247_6 + arg_247_0 and not isNil(var_247_5) and arg_244_1.var_.characterEffect1197ui_story then
				arg_244_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_247_8 = 0
			local var_247_9 = 0.225

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_8 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_10 = arg_244_1:GetWordFromCfg(412102059)
				local var_247_11 = arg_244_1:FormatText(var_247_10.content)

				arg_244_1.text_.text = var_247_11

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_13 = 9 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 9)

				if (9 <= 0 and var_247_9 or var_247_9 * (utf8.len(var_247_11) / 9)) > 0 and var_247_9 < var_247_13 then
					arg_244_1.talkMaxDuration = var_247_13

					if var_247_13 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_13 + var_247_8
					end
				end

				arg_244_1.text_.text = var_247_11
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102059", "story_v_out_412102.awb") ~= 0 then
					local var_247_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102059", "story_v_out_412102.awb") / 1000

					if var_247_14 + var_247_8 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_14 + var_247_8
					end

					if var_247_10.prefab_name ~= "" and arg_244_1.actors_[var_247_10.prefab_name] ~= nil then
						local var_247_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_10.prefab_name].transform, "story_v_out_412102", "412102059", "story_v_out_412102.awb")

						arg_244_1:RecordAudio("412102059", var_247_15)
						arg_244_1:RecordAudio("412102059", var_247_15)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_412102", "412102059", "story_v_out_412102.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_412102", "412102059", "story_v_out_412102.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_16 = math.max(var_247_9, arg_244_1.talkMaxDuration)

			if var_247_8 <= arg_244_1.time_ and arg_244_1.time_ < var_247_8 + var_247_16 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_8) / var_247_16

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_8 + var_247_16 and arg_244_1.time_ < var_247_8 + var_247_16 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play412102060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 412102060
		arg_248_1.duration_ = 4.73

		local var_248_0 = {
			zh = 1.999999999999,
			ja = 4.733
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play412102061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1097ui_story = arg_248_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1097ui_story"].transform.position).z)
				arg_248_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1097ui_story"].transform.localEulerAngles = arg_248_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_248_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1097ui_story"].transform.position).z)
				arg_248_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1097ui_story"].transform.localEulerAngles = arg_248_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["1097ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1097ui_story == nil then
				arg_248_1.var_.characterEffect1097ui_story = var_251_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_2 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_2 and not isNil(var_251_1) then
				if arg_248_1.var_.characterEffect1097ui_story and not isNil(var_251_1) then
					arg_248_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_2 and arg_248_1.time_ < 0 + var_251_2 + arg_251_0 and not isNil(var_251_1) and arg_248_1.var_.characterEffect1097ui_story then
				arg_248_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_251_4 = arg_248_1.actors_["1197ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1197ui_story = var_251_4.localPosition
			end

			local var_251_5 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_5 then
				var_251_4.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_5)
				var_251_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_4.position).x, (manager.ui.mainCamera.transform.position - var_251_4.position).y, (manager.ui.mainCamera.transform.position - var_251_4.position).z)
				var_251_4.localEulerAngles.z = 0
				var_251_4.localEulerAngles.x = 0
				var_251_4.localEulerAngles = var_251_4.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_5 and arg_248_1.time_ < 0 + var_251_5 + arg_251_0 then
				var_251_4.localPosition = Vector3.New(0, 100, 0)
				var_251_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_4.position).x, (manager.ui.mainCamera.transform.position - var_251_4.position).y, (manager.ui.mainCamera.transform.position - var_251_4.position).z)
				var_251_4.localEulerAngles.z = 0
				var_251_4.localEulerAngles.x = 0
				var_251_4.localEulerAngles = var_251_4.localEulerAngles
			end

			local var_251_6 = 0
			local var_251_7 = 0.175

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_6 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_8 = arg_248_1:GetWordFromCfg(412102060)
				local var_251_9 = arg_248_1:FormatText(var_251_8.content)

				arg_248_1.text_.text = var_251_9

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_11 = 7 <= 0 and var_251_7 or var_251_7 * (utf8.len(var_251_9) / 7)

				if (7 <= 0 and var_251_7 or var_251_7 * (utf8.len(var_251_9) / 7)) > 0 and var_251_7 < var_251_11 then
					arg_248_1.talkMaxDuration = var_251_11

					if var_251_11 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_11 + var_251_6
					end
				end

				arg_248_1.text_.text = var_251_9
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102060", "story_v_out_412102.awb") ~= 0 then
					local var_251_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102060", "story_v_out_412102.awb") / 1000

					if var_251_12 + var_251_6 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_12 + var_251_6
					end

					if var_251_8.prefab_name ~= "" and arg_248_1.actors_[var_251_8.prefab_name] ~= nil then
						local var_251_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_8.prefab_name].transform, "story_v_out_412102", "412102060", "story_v_out_412102.awb")

						arg_248_1:RecordAudio("412102060", var_251_13)
						arg_248_1:RecordAudio("412102060", var_251_13)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_412102", "412102060", "story_v_out_412102.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_412102", "412102060", "story_v_out_412102.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_14 = math.max(var_251_7, arg_248_1.talkMaxDuration)

			if var_251_6 <= arg_248_1.time_ and arg_248_1.time_ < var_251_6 + var_251_14 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_6) / var_251_14

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_6 + var_251_14 and arg_248_1.time_ < var_251_6 + var_251_14 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play412102061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 412102061
		arg_252_1.duration_ = 7.7

		local var_252_0 = {
			zh = 4.433,
			ja = 7.7
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play412102062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(arg_252_1.actors_["1097ui_story"]) and arg_252_1.var_.characterEffect1097ui_story == nil then
				arg_252_1.var_.characterEffect1097ui_story = arg_252_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_0 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 and not isNil(arg_252_1.actors_["1097ui_story"]) then
				if arg_252_1.var_.characterEffect1097ui_story and not isNil(arg_252_1.actors_["1097ui_story"]) then
					arg_252_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_0)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 and not isNil(arg_252_1.actors_["1097ui_story"]) and arg_252_1.var_.characterEffect1097ui_story then
				arg_252_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_255_1 = arg_252_1.actors_["1097ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1097ui_story = var_255_1.localPosition
			end

			local var_255_2 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 then
				var_255_1.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_2)
				var_255_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_1.position).x, (manager.ui.mainCamera.transform.position - var_255_1.position).y, (manager.ui.mainCamera.transform.position - var_255_1.position).z)
				var_255_1.localEulerAngles.z = 0
				var_255_1.localEulerAngles.x = 0
				var_255_1.localEulerAngles = var_255_1.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 then
				var_255_1.localPosition = Vector3.New(0, 100, 0)
				var_255_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_1.position).x, (manager.ui.mainCamera.transform.position - var_255_1.position).y, (manager.ui.mainCamera.transform.position - var_255_1.position).z)
				var_255_1.localEulerAngles.z = 0
				var_255_1.localEulerAngles.x = 0
				var_255_1.localEulerAngles = var_255_1.localEulerAngles
			end

			local var_255_3 = arg_252_1.actors_["1197ui_story"].transform

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1197ui_story = var_255_3.localPosition
			end

			local var_255_4 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				var_255_3.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_252_1.time_ - 0) / var_255_4)
				var_255_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_3.position).x, (manager.ui.mainCamera.transform.position - var_255_3.position).y, (manager.ui.mainCamera.transform.position - var_255_3.position).z)
				var_255_3.localEulerAngles.z = 0
				var_255_3.localEulerAngles.x = 0
				var_255_3.localEulerAngles = var_255_3.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				var_255_3.localPosition = Vector3.New(0, -0.545, -6.3)
				var_255_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_255_3.position).x, (manager.ui.mainCamera.transform.position - var_255_3.position).y, (manager.ui.mainCamera.transform.position - var_255_3.position).z)
				var_255_3.localEulerAngles.z = 0
				var_255_3.localEulerAngles.x = 0
				var_255_3.localEulerAngles = var_255_3.localEulerAngles
			end

			local var_255_5 = arg_252_1.actors_["1197ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_5) and arg_252_1.var_.characterEffect1197ui_story == nil then
				arg_252_1.var_.characterEffect1197ui_story = var_255_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_6 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_6 and not isNil(var_255_5) then
				if arg_252_1.var_.characterEffect1197ui_story and not isNil(var_255_5) then
					arg_252_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_252_1.time_ >= 0 + var_255_6 and arg_252_1.time_ < 0 + var_255_6 + arg_255_0 and not isNil(var_255_5) and arg_252_1.var_.characterEffect1197ui_story then
				arg_252_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_255_8 = 0
			local var_255_9 = 0.475

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_8 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_10 = arg_252_1:GetWordFromCfg(412102061)
				local var_255_11 = arg_252_1:FormatText(var_255_10.content)

				arg_252_1.text_.text = var_255_11

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_13 = 19 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 19)

				if (19 <= 0 and var_255_9 or var_255_9 * (utf8.len(var_255_11) / 19)) > 0 and var_255_9 < var_255_13 then
					arg_252_1.talkMaxDuration = var_255_13

					if var_255_13 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_13 + var_255_8
					end
				end

				arg_252_1.text_.text = var_255_11
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102061", "story_v_out_412102.awb") ~= 0 then
					local var_255_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102061", "story_v_out_412102.awb") / 1000

					if var_255_14 + var_255_8 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_14 + var_255_8
					end

					if var_255_10.prefab_name ~= "" and arg_252_1.actors_[var_255_10.prefab_name] ~= nil then
						local var_255_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_10.prefab_name].transform, "story_v_out_412102", "412102061", "story_v_out_412102.awb")

						arg_252_1:RecordAudio("412102061", var_255_15)
						arg_252_1:RecordAudio("412102061", var_255_15)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_412102", "412102061", "story_v_out_412102.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_412102", "412102061", "story_v_out_412102.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_16 = math.max(var_255_9, arg_252_1.talkMaxDuration)

			if var_255_8 <= arg_252_1.time_ and arg_252_1.time_ < var_255_8 + var_255_16 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_8) / var_255_16

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_8 + var_255_16 and arg_252_1.time_ < var_255_8 + var_255_16 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play412102062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 412102062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play412102063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1197ui_story = arg_256_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1197ui_story"].transform.position).z)
				arg_256_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1197ui_story"].transform.localEulerAngles = arg_256_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_256_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1197ui_story"].transform.position).z)
				arg_256_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1197ui_story"].transform.localEulerAngles = arg_256_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_259_1 = arg_256_1.actors_["1097ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1097ui_story == nil then
				arg_256_1.var_.characterEffect1097ui_story = var_259_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_2 and not isNil(var_259_1) then
				if arg_256_1.var_.characterEffect1097ui_story and not isNil(var_259_1) then
					arg_256_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_256_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_256_1.time_ - 0) / var_259_2)
				end
			end

			if arg_256_1.time_ >= 0 + var_259_2 and arg_256_1.time_ < 0 + var_259_2 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1097ui_story then
				arg_256_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_256_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_259_3 = 0
			local var_259_4 = 0.825

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_3 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_5 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(412102062).content)

				arg_256_1.text_.text = var_259_5

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_7 = 33 <= 0 and var_259_4 or var_259_4 * (utf8.len(var_259_5) / 33)

				if (33 <= 0 and var_259_4 or var_259_4 * (utf8.len(var_259_5) / 33)) > 0 and var_259_4 < var_259_7 then
					arg_256_1.talkMaxDuration = var_259_7

					if var_259_7 + var_259_3 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_7 + var_259_3
					end
				end

				arg_256_1.text_.text = var_259_5
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_8 = math.max(var_259_4, arg_256_1.talkMaxDuration)

			if var_259_3 <= arg_256_1.time_ and arg_256_1.time_ < var_259_3 + var_259_8 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_3) / var_259_8

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_3 + var_259_8 and arg_256_1.time_ < var_259_3 + var_259_8 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play412102063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 412102063
		arg_260_1.duration_ = 5

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play412102064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.45

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, false)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:FormatText(arg_260_1:GetWordFromCfg(412102063).content)

				arg_260_1.text_.text = var_263_1

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_3 = 18 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 18)

				if (18 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_1) / 18)) > 0 and var_263_0 < var_263_3 then
					arg_260_1.talkMaxDuration = var_263_3

					if var_263_3 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_3 + 0
					end
				end

				arg_260_1.text_.text = var_263_1
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)
				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_4 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_4

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play412102064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 412102064
		arg_264_1.duration_ = 7.2

		local var_264_0 = {
			zh = 7.2,
			ja = 6.966
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play412102065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos1097ui_story = arg_264_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_267_0 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 then
				arg_264_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_264_1.time_ - 0) / var_267_0)
				arg_264_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1097ui_story"].transform.position).z)
				arg_264_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1097ui_story"].transform.localEulerAngles = arg_264_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 then
				arg_264_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_264_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["1097ui_story"].transform.position).z)
				arg_264_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["1097ui_story"].transform.localEulerAngles = arg_264_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_267_1 = arg_264_1.actors_["1097ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect1097ui_story == nil then
				arg_264_1.var_.characterEffect1097ui_story = var_267_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_2 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_2 and not isNil(var_267_1) then
				if arg_264_1.var_.characterEffect1097ui_story and not isNil(var_267_1) then
					arg_264_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_2 and arg_264_1.time_ < 0 + var_267_2 + arg_267_0 and not isNil(var_267_1) and arg_264_1.var_.characterEffect1097ui_story then
				arg_264_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_267_4 = 0
			local var_267_5 = 0.8

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(412102064)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 32 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 32)

				if (32 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 32)) > 0 and var_267_5 < var_267_9 then
					arg_264_1.talkMaxDuration = var_267_9

					if var_267_9 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_9 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102064", "story_v_out_412102.awb") ~= 0 then
					local var_267_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102064", "story_v_out_412102.awb") / 1000

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end

					if var_267_6.prefab_name ~= "" and arg_264_1.actors_[var_267_6.prefab_name] ~= nil then
						local var_267_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_6.prefab_name].transform, "story_v_out_412102", "412102064", "story_v_out_412102.awb")

						arg_264_1:RecordAudio("412102064", var_267_11)
						arg_264_1:RecordAudio("412102064", var_267_11)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_412102", "412102064", "story_v_out_412102.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_412102", "412102064", "story_v_out_412102.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_12 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_12 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_12

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_12 and arg_264_1.time_ < var_267_4 + var_267_12 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play412102065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 412102065
		arg_268_1.duration_ = 7.2

		local var_268_0 = {
			zh = 7.2,
			ja = 4.6
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play412102066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1097ui_story"]) and arg_268_1.var_.characterEffect1097ui_story == nil then
				arg_268_1.var_.characterEffect1097ui_story = arg_268_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1097ui_story"]) then
				if arg_268_1.var_.characterEffect1097ui_story and not isNil(arg_268_1.actors_["1097ui_story"]) then
					arg_268_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1097ui_story"]) and arg_268_1.var_.characterEffect1097ui_story then
				arg_268_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_271_1 = arg_268_1.actors_["1097ui_story"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1097ui_story = var_271_1.localPosition
			end

			local var_271_2 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_2 then
				var_271_1.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_268_1.time_ - 0) / var_271_2)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_2 and arg_268_1.time_ < 0 + var_271_2 + arg_271_0 then
				var_271_1.localPosition = Vector3.New(0, 100, 0)
				var_271_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_1.position).x, (manager.ui.mainCamera.transform.position - var_271_1.position).y, (manager.ui.mainCamera.transform.position - var_271_1.position).z)
				var_271_1.localEulerAngles.z = 0
				var_271_1.localEulerAngles.x = 0
				var_271_1.localEulerAngles = var_271_1.localEulerAngles
			end

			local var_271_3 = arg_268_1.actors_["1197ui_story"].transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.moveOldPos1197ui_story = var_271_3.localPosition
			end

			local var_271_4 = 0.001

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_4 then
				var_271_3.localPosition = Vector3.Lerp(arg_268_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_268_1.time_ - 0) / var_271_4)
				var_271_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_3.position).x, (manager.ui.mainCamera.transform.position - var_271_3.position).y, (manager.ui.mainCamera.transform.position - var_271_3.position).z)
				var_271_3.localEulerAngles.z = 0
				var_271_3.localEulerAngles.x = 0
				var_271_3.localEulerAngles = var_271_3.localEulerAngles
			end

			if arg_268_1.time_ >= 0 + var_271_4 and arg_268_1.time_ < 0 + var_271_4 + arg_271_0 then
				var_271_3.localPosition = Vector3.New(0, -0.545, -6.3)
				var_271_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_271_3.position).x, (manager.ui.mainCamera.transform.position - var_271_3.position).y, (manager.ui.mainCamera.transform.position - var_271_3.position).z)
				var_271_3.localEulerAngles.z = 0
				var_271_3.localEulerAngles.x = 0
				var_271_3.localEulerAngles = var_271_3.localEulerAngles
			end

			local var_271_5 = arg_268_1.actors_["1197ui_story"]

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(var_271_5) and arg_268_1.var_.characterEffect1197ui_story == nil then
				arg_268_1.var_.characterEffect1197ui_story = var_271_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_6 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_6 and not isNil(var_271_5) then
				if arg_268_1.var_.characterEffect1197ui_story and not isNil(var_271_5) then
					arg_268_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_268_1.time_ >= 0 + var_271_6 and arg_268_1.time_ < 0 + var_271_6 + arg_271_0 and not isNil(var_271_5) and arg_268_1.var_.characterEffect1197ui_story then
				arg_268_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_271_8 = 0
			local var_271_9 = 0.725

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_10 = arg_268_1:GetWordFromCfg(412102065)
				local var_271_11 = arg_268_1:FormatText(var_271_10.content)

				arg_268_1.text_.text = var_271_11

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_13 = 29 <= 0 and var_271_9 or var_271_9 * (utf8.len(var_271_11) / 29)

				if (29 <= 0 and var_271_9 or var_271_9 * (utf8.len(var_271_11) / 29)) > 0 and var_271_9 < var_271_13 then
					arg_268_1.talkMaxDuration = var_271_13

					if var_271_13 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_13 + var_271_8
					end
				end

				arg_268_1.text_.text = var_271_11
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102065", "story_v_out_412102.awb") ~= 0 then
					local var_271_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102065", "story_v_out_412102.awb") / 1000

					if var_271_14 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_14 + var_271_8
					end

					if var_271_10.prefab_name ~= "" and arg_268_1.actors_[var_271_10.prefab_name] ~= nil then
						local var_271_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_10.prefab_name].transform, "story_v_out_412102", "412102065", "story_v_out_412102.awb")

						arg_268_1:RecordAudio("412102065", var_271_15)
						arg_268_1:RecordAudio("412102065", var_271_15)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_412102", "412102065", "story_v_out_412102.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_412102", "412102065", "story_v_out_412102.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_16 = math.max(var_271_9, arg_268_1.talkMaxDuration)

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_16 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_8) / var_271_16

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_8 + var_271_16 and arg_268_1.time_ < var_271_8 + var_271_16 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_268_1:InitPlayNodeList()
	end,
	Play412102066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 412102066
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play412102067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.var_.moveOldPos1197ui_story = arg_272_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_275_0 = 0.001

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 then
				arg_272_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_272_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_272_1.time_ - 0) / var_275_0)
				arg_272_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1197ui_story"].transform.position).z)
				arg_272_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1197ui_story"].transform.localEulerAngles = arg_272_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 then
				arg_272_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_272_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_272_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_272_1.actors_["1197ui_story"].transform.position).z)
				arg_272_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_272_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_272_1.actors_["1197ui_story"].transform.localEulerAngles = arg_272_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_275_1 = arg_272_1.actors_["1097ui_story"]

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1097ui_story == nil then
				arg_272_1.var_.characterEffect1097ui_story = var_275_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_2 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_2 and not isNil(var_275_1) then
				if arg_272_1.var_.characterEffect1097ui_story and not isNil(var_275_1) then
					arg_272_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_272_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_272_1.time_ - 0) / var_275_2)
				end
			end

			if arg_272_1.time_ >= 0 + var_275_2 and arg_272_1.time_ < 0 + var_275_2 + arg_275_0 and not isNil(var_275_1) and arg_272_1.var_.characterEffect1097ui_story then
				arg_272_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_272_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_275_3 = 0
			local var_275_4 = 0.25

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_3 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_5 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(412102066).content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 10 <= 0 and var_275_4 or var_275_4 * (utf8.len(var_275_5) / 10)

				if (10 <= 0 and var_275_4 or var_275_4 * (utf8.len(var_275_5) / 10)) > 0 and var_275_4 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_3 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_3
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_8 = math.max(var_275_4, arg_272_1.talkMaxDuration)

			if var_275_3 <= arg_272_1.time_ and arg_272_1.time_ < var_275_3 + var_275_8 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_3) / var_275_8

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_3 + var_275_8 and arg_272_1.time_ < var_275_3 + var_275_8 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_272_1:InitPlayNodeList()
	end,
	Play412102067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 412102067
		arg_276_1.duration_ = 3.2

		local var_276_0 = {
			zh = 1.999999999999,
			ja = 3.2
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play412102068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1097ui_story = arg_276_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1097ui_story"].transform.position).z)
				arg_276_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1097ui_story"].transform.localEulerAngles = arg_276_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_276_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1097ui_story"].transform.position).z)
				arg_276_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1097ui_story"].transform.localEulerAngles = arg_276_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_279_1 = arg_276_1.actors_["1097ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect1097ui_story == nil then
				arg_276_1.var_.characterEffect1097ui_story = var_279_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_2 and not isNil(var_279_1) then
				if arg_276_1.var_.characterEffect1097ui_story and not isNil(var_279_1) then
					arg_276_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_2 and arg_276_1.time_ < 0 + var_279_2 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect1097ui_story then
				arg_276_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_279_4 = 0
			local var_279_5 = 0.075

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_6 = arg_276_1:GetWordFromCfg(412102067)
				local var_279_7 = arg_276_1:FormatText(var_279_6.content)

				arg_276_1.text_.text = var_279_7

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_9 = 3 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_7) / 3)

				if (3 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_7) / 3)) > 0 and var_279_5 < var_279_9 then
					arg_276_1.talkMaxDuration = var_279_9

					if var_279_9 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_4
					end
				end

				arg_276_1.text_.text = var_279_7
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102067", "story_v_out_412102.awb") ~= 0 then
					local var_279_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102067", "story_v_out_412102.awb") / 1000

					if var_279_10 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_4
					end

					if var_279_6.prefab_name ~= "" and arg_276_1.actors_[var_279_6.prefab_name] ~= nil then
						local var_279_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_6.prefab_name].transform, "story_v_out_412102", "412102067", "story_v_out_412102.awb")

						arg_276_1:RecordAudio("412102067", var_279_11)
						arg_276_1:RecordAudio("412102067", var_279_11)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_412102", "412102067", "story_v_out_412102.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_412102", "412102067", "story_v_out_412102.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_12 = math.max(var_279_5, arg_276_1.talkMaxDuration)

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_12 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_4) / var_279_12

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_4 + var_279_12 and arg_276_1.time_ < var_279_4 + var_279_12 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play412102068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 412102068
		arg_280_1.duration_ = 1.9

		local var_280_0 = {
			zh = 1.2,
			ja = 1.9
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play412102069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1097ui_story"]) and arg_280_1.var_.characterEffect1097ui_story == nil then
				arg_280_1.var_.characterEffect1097ui_story = arg_280_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1097ui_story"]) then
				if arg_280_1.var_.characterEffect1097ui_story and not isNil(arg_280_1.actors_["1097ui_story"]) then
					arg_280_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1097ui_story"]) and arg_280_1.var_.characterEffect1097ui_story then
				arg_280_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_283_1 = arg_280_1.actors_["1197ui_story"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1197ui_story = var_283_1.localPosition
			end

			local var_283_2 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_2 then
				var_283_1.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_280_1.time_ - 0) / var_283_2)
				var_283_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_1.position).x, (manager.ui.mainCamera.transform.position - var_283_1.position).y, (manager.ui.mainCamera.transform.position - var_283_1.position).z)
				var_283_1.localEulerAngles.z = 0
				var_283_1.localEulerAngles.x = 0
				var_283_1.localEulerAngles = var_283_1.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_2 and arg_280_1.time_ < 0 + var_283_2 + arg_283_0 then
				var_283_1.localPosition = Vector3.New(0, -0.545, -6.3)
				var_283_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_1.position).x, (manager.ui.mainCamera.transform.position - var_283_1.position).y, (manager.ui.mainCamera.transform.position - var_283_1.position).z)
				var_283_1.localEulerAngles.z = 0
				var_283_1.localEulerAngles.x = 0
				var_283_1.localEulerAngles = var_283_1.localEulerAngles
			end

			local var_283_3 = arg_280_1.actors_["1197ui_story"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect1197ui_story == nil then
				arg_280_1.var_.characterEffect1197ui_story = var_283_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_4 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_4 and not isNil(var_283_3) then
				if arg_280_1.var_.characterEffect1197ui_story and not isNil(var_283_3) then
					arg_280_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_280_1.time_ >= 0 + var_283_4 and arg_280_1.time_ < 0 + var_283_4 + arg_283_0 and not isNil(var_283_3) and arg_280_1.var_.characterEffect1197ui_story then
				arg_280_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_283_6 = arg_280_1.actors_["1097ui_story"].transform

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos1097ui_story = var_283_6.localPosition
			end

			local var_283_7 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_7 then
				var_283_6.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_280_1.time_ - 0) / var_283_7)
				var_283_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_6.position).x, (manager.ui.mainCamera.transform.position - var_283_6.position).y, (manager.ui.mainCamera.transform.position - var_283_6.position).z)
				var_283_6.localEulerAngles.z = 0
				var_283_6.localEulerAngles.x = 0
				var_283_6.localEulerAngles = var_283_6.localEulerAngles
			end

			if arg_280_1.time_ >= 0 + var_283_7 and arg_280_1.time_ < 0 + var_283_7 + arg_283_0 then
				var_283_6.localPosition = Vector3.New(0, 100, 0)
				var_283_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_283_6.position).x, (manager.ui.mainCamera.transform.position - var_283_6.position).y, (manager.ui.mainCamera.transform.position - var_283_6.position).z)
				var_283_6.localEulerAngles.z = 0
				var_283_6.localEulerAngles.x = 0
				var_283_6.localEulerAngles = var_283_6.localEulerAngles
			end

			local var_283_8 = 0
			local var_283_9 = 0.1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_8 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_10 = arg_280_1:GetWordFromCfg(412102068)
				local var_283_11 = arg_280_1:FormatText(var_283_10.content)

				arg_280_1.text_.text = var_283_11

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_13 = 4 <= 0 and var_283_9 or var_283_9 * (utf8.len(var_283_11) / 4)

				if (4 <= 0 and var_283_9 or var_283_9 * (utf8.len(var_283_11) / 4)) > 0 and var_283_9 < var_283_13 then
					arg_280_1.talkMaxDuration = var_283_13

					if var_283_13 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_8
					end
				end

				arg_280_1.text_.text = var_283_11
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102068", "story_v_out_412102.awb") ~= 0 then
					local var_283_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102068", "story_v_out_412102.awb") / 1000

					if var_283_14 + var_283_8 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_14 + var_283_8
					end

					if var_283_10.prefab_name ~= "" and arg_280_1.actors_[var_283_10.prefab_name] ~= nil then
						local var_283_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_10.prefab_name].transform, "story_v_out_412102", "412102068", "story_v_out_412102.awb")

						arg_280_1:RecordAudio("412102068", var_283_15)
						arg_280_1:RecordAudio("412102068", var_283_15)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_412102", "412102068", "story_v_out_412102.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_412102", "412102068", "story_v_out_412102.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_16 = math.max(var_283_9, arg_280_1.talkMaxDuration)

			if var_283_8 <= arg_280_1.time_ and arg_280_1.time_ < var_283_8 + var_283_16 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_8) / var_283_16

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_8 + var_283_16 and arg_280_1.time_ < var_283_8 + var_283_16 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play412102069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 412102069
		arg_284_1.duration_ = 12.17

		local var_284_0 = {
			zh = 6.8,
			ja = 12.166
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play412102070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1097ui_story = arg_284_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_287_0 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_0 then
				arg_284_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_284_1.time_ - 0) / var_287_0)
				arg_284_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).z)
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles = arg_284_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_0 and arg_284_1.time_ < 0 + var_287_0 + arg_287_0 then
				arg_284_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_284_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_284_1.actors_["1097ui_story"].transform.position).z)
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_284_1.actors_["1097ui_story"].transform.localEulerAngles = arg_284_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_287_1 = arg_284_1.actors_["1097ui_story"]

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1097ui_story == nil then
				arg_284_1.var_.characterEffect1097ui_story = var_287_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_287_2 = 0.200000002980232

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_2 and not isNil(var_287_1) then
				if arg_284_1.var_.characterEffect1097ui_story and not isNil(var_287_1) then
					arg_284_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_284_1.time_ >= 0 + var_287_2 and arg_284_1.time_ < 0 + var_287_2 + arg_287_0 and not isNil(var_287_1) and arg_284_1.var_.characterEffect1097ui_story then
				arg_284_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_287_4 = arg_284_1.actors_["1197ui_story"].transform

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.var_.moveOldPos1197ui_story = var_287_4.localPosition
			end

			local var_287_5 = 0.001

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_5 then
				var_287_4.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_284_1.time_ - 0) / var_287_5)
				var_287_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_4.position).x, (manager.ui.mainCamera.transform.position - var_287_4.position).y, (manager.ui.mainCamera.transform.position - var_287_4.position).z)
				var_287_4.localEulerAngles.z = 0
				var_287_4.localEulerAngles.x = 0
				var_287_4.localEulerAngles = var_287_4.localEulerAngles
			end

			if arg_284_1.time_ >= 0 + var_287_5 and arg_284_1.time_ < 0 + var_287_5 + arg_287_0 then
				var_287_4.localPosition = Vector3.New(0, 100, 0)
				var_287_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_287_4.position).x, (manager.ui.mainCamera.transform.position - var_287_4.position).y, (manager.ui.mainCamera.transform.position - var_287_4.position).z)
				var_287_4.localEulerAngles.z = 0
				var_287_4.localEulerAngles.x = 0
				var_287_4.localEulerAngles = var_287_4.localEulerAngles
			end

			local var_287_6 = 0
			local var_287_7 = 0.825

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_6 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_8 = arg_284_1:GetWordFromCfg(412102069)
				local var_287_9 = arg_284_1:FormatText(var_287_8.content)

				arg_284_1.text_.text = var_287_9

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_11 = 33 <= 0 and var_287_7 or var_287_7 * (utf8.len(var_287_9) / 33)

				if (33 <= 0 and var_287_7 or var_287_7 * (utf8.len(var_287_9) / 33)) > 0 and var_287_7 < var_287_11 then
					arg_284_1.talkMaxDuration = var_287_11

					if var_287_11 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_11 + var_287_6
					end
				end

				arg_284_1.text_.text = var_287_9
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102069", "story_v_out_412102.awb") ~= 0 then
					local var_287_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102069", "story_v_out_412102.awb") / 1000

					if var_287_12 + var_287_6 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_12 + var_287_6
					end

					if var_287_8.prefab_name ~= "" and arg_284_1.actors_[var_287_8.prefab_name] ~= nil then
						local var_287_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_8.prefab_name].transform, "story_v_out_412102", "412102069", "story_v_out_412102.awb")

						arg_284_1:RecordAudio("412102069", var_287_13)
						arg_284_1:RecordAudio("412102069", var_287_13)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_412102", "412102069", "story_v_out_412102.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_412102", "412102069", "story_v_out_412102.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_14 = math.max(var_287_7, arg_284_1.talkMaxDuration)

			if var_287_6 <= arg_284_1.time_ and arg_284_1.time_ < var_287_6 + var_287_14 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_6) / var_287_14

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_6 + var_287_14 and arg_284_1.time_ < var_287_6 + var_287_14 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play412102070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 412102070
		arg_288_1.duration_ = 9.03

		local var_288_0 = {
			zh = 9.033,
			ja = 5.033
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play412102071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 1.05

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:GetWordFromCfg(412102070)
				local var_291_2 = arg_288_1:FormatText(var_291_1.content)

				arg_288_1.text_.text = var_291_2

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_4 = 42 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 42)

				if (42 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_2) / 42)) > 0 and var_291_0 < var_291_4 then
					arg_288_1.talkMaxDuration = var_291_4

					if var_291_4 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_4 + 0
					end
				end

				arg_288_1.text_.text = var_291_2
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102070", "story_v_out_412102.awb") ~= 0 then
					local var_291_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102070", "story_v_out_412102.awb") / 1000

					if var_291_5 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_5 + 0
					end

					if var_291_1.prefab_name ~= "" and arg_288_1.actors_[var_291_1.prefab_name] ~= nil then
						local var_291_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_1.prefab_name].transform, "story_v_out_412102", "412102070", "story_v_out_412102.awb")

						arg_288_1:RecordAudio("412102070", var_291_6)
						arg_288_1:RecordAudio("412102070", var_291_6)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_412102", "412102070", "story_v_out_412102.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_412102", "412102070", "story_v_out_412102.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_7 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_7 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_7

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_7 and arg_288_1.time_ < 0 + var_291_7 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play412102071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 412102071
		arg_292_1.duration_ = 3.47

		local var_292_0 = {
			zh = 2.4,
			ja = 3.466
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play412102072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1197ui_story = arg_292_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_295_0 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 then
				arg_292_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_292_1.time_ - 0) / var_295_0)
				arg_292_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1197ui_story"].transform.position).z)
				arg_292_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1197ui_story"].transform.localEulerAngles = arg_292_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 then
				arg_292_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_292_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_292_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_292_1.actors_["1197ui_story"].transform.position).z)
				arg_292_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_292_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_292_1.actors_["1197ui_story"].transform.localEulerAngles = arg_292_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_295_1 = arg_292_1.actors_["1197ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1197ui_story == nil then
				arg_292_1.var_.characterEffect1197ui_story = var_295_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_2 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_2 and not isNil(var_295_1) then
				if arg_292_1.var_.characterEffect1197ui_story and not isNil(var_295_1) then
					arg_292_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_2 and arg_292_1.time_ < 0 + var_295_2 + arg_295_0 and not isNil(var_295_1) and arg_292_1.var_.characterEffect1197ui_story then
				arg_292_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_295_4 = arg_292_1.actors_["1097ui_story"].transform

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1.var_.moveOldPos1097ui_story = var_295_4.localPosition
			end

			local var_295_5 = 0.001

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_5 then
				var_295_4.localPosition = Vector3.Lerp(arg_292_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_292_1.time_ - 0) / var_295_5)
				var_295_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_4.position).x, (manager.ui.mainCamera.transform.position - var_295_4.position).y, (manager.ui.mainCamera.transform.position - var_295_4.position).z)
				var_295_4.localEulerAngles.z = 0
				var_295_4.localEulerAngles.x = 0
				var_295_4.localEulerAngles = var_295_4.localEulerAngles
			end

			if arg_292_1.time_ >= 0 + var_295_5 and arg_292_1.time_ < 0 + var_295_5 + arg_295_0 then
				var_295_4.localPosition = Vector3.New(0, 100, 0)
				var_295_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_295_4.position).x, (manager.ui.mainCamera.transform.position - var_295_4.position).y, (manager.ui.mainCamera.transform.position - var_295_4.position).z)
				var_295_4.localEulerAngles.z = 0
				var_295_4.localEulerAngles.x = 0
				var_295_4.localEulerAngles = var_295_4.localEulerAngles
			end

			local var_295_6 = 0
			local var_295_7 = 0.25

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_6 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_8 = arg_292_1:GetWordFromCfg(412102071)
				local var_295_9 = arg_292_1:FormatText(var_295_8.content)

				arg_292_1.text_.text = var_295_9

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_11 = 10 <= 0 and var_295_7 or var_295_7 * (utf8.len(var_295_9) / 10)

				if (10 <= 0 and var_295_7 or var_295_7 * (utf8.len(var_295_9) / 10)) > 0 and var_295_7 < var_295_11 then
					arg_292_1.talkMaxDuration = var_295_11

					if var_295_11 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_11 + var_295_6
					end
				end

				arg_292_1.text_.text = var_295_9
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102071", "story_v_out_412102.awb") ~= 0 then
					local var_295_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102071", "story_v_out_412102.awb") / 1000

					if var_295_12 + var_295_6 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_12 + var_295_6
					end

					if var_295_8.prefab_name ~= "" and arg_292_1.actors_[var_295_8.prefab_name] ~= nil then
						local var_295_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_8.prefab_name].transform, "story_v_out_412102", "412102071", "story_v_out_412102.awb")

						arg_292_1:RecordAudio("412102071", var_295_13)
						arg_292_1:RecordAudio("412102071", var_295_13)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_412102", "412102071", "story_v_out_412102.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_412102", "412102071", "story_v_out_412102.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_14 = math.max(var_295_7, arg_292_1.talkMaxDuration)

			if var_295_6 <= arg_292_1.time_ and arg_292_1.time_ < var_295_6 + var_295_14 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_6) / var_295_14

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_6 + var_295_14 and arg_292_1.time_ < var_295_6 + var_295_14 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_292_1:InitPlayNodeList()
	end,
	Play412102072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 412102072
		arg_296_1.duration_ = 12.27

		local var_296_0 = {
			zh = 4.2,
			ja = 12.266
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play412102073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1097ui_story = arg_296_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_299_0 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 then
				arg_296_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_296_1.time_ - 0) / var_299_0)
				arg_296_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).z)
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles = arg_296_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 then
				arg_296_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_296_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_296_1.actors_["1097ui_story"].transform.position).z)
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_296_1.actors_["1097ui_story"].transform.localEulerAngles = arg_296_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_299_1 = arg_296_1.actors_["1097ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1097ui_story == nil then
				arg_296_1.var_.characterEffect1097ui_story = var_299_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_2 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_2 and not isNil(var_299_1) then
				if arg_296_1.var_.characterEffect1097ui_story and not isNil(var_299_1) then
					arg_296_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_2 and arg_296_1.time_ < 0 + var_299_2 + arg_299_0 and not isNil(var_299_1) and arg_296_1.var_.characterEffect1097ui_story then
				arg_296_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_2")
			end

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_299_4 = arg_296_1.actors_["1197ui_story"].transform

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 then
				arg_296_1.var_.moveOldPos1197ui_story = var_299_4.localPosition
			end

			local var_299_5 = 0.001

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_5 then
				var_299_4.localPosition = Vector3.Lerp(arg_296_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_296_1.time_ - 0) / var_299_5)
				var_299_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_4.position).x, (manager.ui.mainCamera.transform.position - var_299_4.position).y, (manager.ui.mainCamera.transform.position - var_299_4.position).z)
				var_299_4.localEulerAngles.z = 0
				var_299_4.localEulerAngles.x = 0
				var_299_4.localEulerAngles = var_299_4.localEulerAngles
			end

			if arg_296_1.time_ >= 0 + var_299_5 and arg_296_1.time_ < 0 + var_299_5 + arg_299_0 then
				var_299_4.localPosition = Vector3.New(0, 100, 0)
				var_299_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_299_4.position).x, (manager.ui.mainCamera.transform.position - var_299_4.position).y, (manager.ui.mainCamera.transform.position - var_299_4.position).z)
				var_299_4.localEulerAngles.z = 0
				var_299_4.localEulerAngles.x = 0
				var_299_4.localEulerAngles = var_299_4.localEulerAngles
			end

			local var_299_6 = 0
			local var_299_7 = 0.45

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_6 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_8 = arg_296_1:GetWordFromCfg(412102072)
				local var_299_9 = arg_296_1:FormatText(var_299_8.content)

				arg_296_1.text_.text = var_299_9

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_11 = 18 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_9) / 18)

				if (18 <= 0 and var_299_7 or var_299_7 * (utf8.len(var_299_9) / 18)) > 0 and var_299_7 < var_299_11 then
					arg_296_1.talkMaxDuration = var_299_11

					if var_299_11 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_11 + var_299_6
					end
				end

				arg_296_1.text_.text = var_299_9
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102072", "story_v_out_412102.awb") ~= 0 then
					local var_299_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102072", "story_v_out_412102.awb") / 1000

					if var_299_12 + var_299_6 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_12 + var_299_6
					end

					if var_299_8.prefab_name ~= "" and arg_296_1.actors_[var_299_8.prefab_name] ~= nil then
						local var_299_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_8.prefab_name].transform, "story_v_out_412102", "412102072", "story_v_out_412102.awb")

						arg_296_1:RecordAudio("412102072", var_299_13)
						arg_296_1:RecordAudio("412102072", var_299_13)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_412102", "412102072", "story_v_out_412102.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_412102", "412102072", "story_v_out_412102.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_14 = math.max(var_299_7, arg_296_1.talkMaxDuration)

			if var_299_6 <= arg_296_1.time_ and arg_296_1.time_ < var_299_6 + var_299_14 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_6) / var_299_14

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_6 + var_299_14 and arg_296_1.time_ < var_299_6 + var_299_14 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_296_1:InitPlayNodeList()
	end,
	Play412102073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 412102073
		arg_300_1.duration_ = 7.2

		local var_300_0 = {
			zh = 2.833,
			ja = 7.2
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play412102074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["1097ui_story"]) and arg_300_1.var_.characterEffect1097ui_story == nil then
				arg_300_1.var_.characterEffect1097ui_story = arg_300_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["1097ui_story"]) then
				if arg_300_1.var_.characterEffect1097ui_story and not isNil(arg_300_1.actors_["1097ui_story"]) then
					arg_300_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_300_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["1097ui_story"]) and arg_300_1.var_.characterEffect1097ui_story then
				arg_300_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_300_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_303_1 = arg_300_1.actors_["1197ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1197ui_story = var_303_1.localPosition
			end

			local var_303_2 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_2 then
				var_303_1.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_300_1.time_ - 0) / var_303_2)
				var_303_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_1.position).x, (manager.ui.mainCamera.transform.position - var_303_1.position).y, (manager.ui.mainCamera.transform.position - var_303_1.position).z)
				var_303_1.localEulerAngles.z = 0
				var_303_1.localEulerAngles.x = 0
				var_303_1.localEulerAngles = var_303_1.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_2 and arg_300_1.time_ < 0 + var_303_2 + arg_303_0 then
				var_303_1.localPosition = Vector3.New(0, -0.545, -6.3)
				var_303_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_1.position).x, (manager.ui.mainCamera.transform.position - var_303_1.position).y, (manager.ui.mainCamera.transform.position - var_303_1.position).z)
				var_303_1.localEulerAngles.z = 0
				var_303_1.localEulerAngles.x = 0
				var_303_1.localEulerAngles = var_303_1.localEulerAngles
			end

			local var_303_3 = arg_300_1.actors_["1197ui_story"]

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1197ui_story == nil then
				arg_300_1.var_.characterEffect1197ui_story = var_303_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_4 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_4 and not isNil(var_303_3) then
				if arg_300_1.var_.characterEffect1197ui_story and not isNil(var_303_3) then
					arg_300_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_300_1.time_ >= 0 + var_303_4 and arg_300_1.time_ < 0 + var_303_4 + arg_303_0 and not isNil(var_303_3) and arg_300_1.var_.characterEffect1197ui_story then
				arg_300_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_303_6 = arg_300_1.actors_["1097ui_story"].transform

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 then
				arg_300_1.var_.moveOldPos1097ui_story = var_303_6.localPosition
			end

			local var_303_7 = 0.001

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_7 then
				var_303_6.localPosition = Vector3.Lerp(arg_300_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_300_1.time_ - 0) / var_303_7)
				var_303_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_6.position).x, (manager.ui.mainCamera.transform.position - var_303_6.position).y, (manager.ui.mainCamera.transform.position - var_303_6.position).z)
				var_303_6.localEulerAngles.z = 0
				var_303_6.localEulerAngles.x = 0
				var_303_6.localEulerAngles = var_303_6.localEulerAngles
			end

			if arg_300_1.time_ >= 0 + var_303_7 and arg_300_1.time_ < 0 + var_303_7 + arg_303_0 then
				var_303_6.localPosition = Vector3.New(0, 100, 0)
				var_303_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_303_6.position).x, (manager.ui.mainCamera.transform.position - var_303_6.position).y, (manager.ui.mainCamera.transform.position - var_303_6.position).z)
				var_303_6.localEulerAngles.z = 0
				var_303_6.localEulerAngles.x = 0
				var_303_6.localEulerAngles = var_303_6.localEulerAngles
			end

			local var_303_8 = 0
			local var_303_9 = 0.3

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_8 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, false)
				arg_300_1.callingController_:SetSelectedState("normal")

				local var_303_10 = arg_300_1:GetWordFromCfg(412102073)
				local var_303_11 = arg_300_1:FormatText(var_303_10.content)

				arg_300_1.text_.text = var_303_11

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_13 = 12 <= 0 and var_303_9 or var_303_9 * (utf8.len(var_303_11) / 12)

				if (12 <= 0 and var_303_9 or var_303_9 * (utf8.len(var_303_11) / 12)) > 0 and var_303_9 < var_303_13 then
					arg_300_1.talkMaxDuration = var_303_13

					if var_303_13 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_13 + var_303_8
					end
				end

				arg_300_1.text_.text = var_303_11
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102073", "story_v_out_412102.awb") ~= 0 then
					local var_303_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102073", "story_v_out_412102.awb") / 1000

					if var_303_14 + var_303_8 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_14 + var_303_8
					end

					if var_303_10.prefab_name ~= "" and arg_300_1.actors_[var_303_10.prefab_name] ~= nil then
						local var_303_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_10.prefab_name].transform, "story_v_out_412102", "412102073", "story_v_out_412102.awb")

						arg_300_1:RecordAudio("412102073", var_303_15)
						arg_300_1:RecordAudio("412102073", var_303_15)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_412102", "412102073", "story_v_out_412102.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_412102", "412102073", "story_v_out_412102.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_16 = math.max(var_303_9, arg_300_1.talkMaxDuration)

			if var_303_8 <= arg_300_1.time_ and arg_300_1.time_ < var_303_8 + var_303_16 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_8) / var_303_16

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_8 + var_303_16 and arg_300_1.time_ < var_303_8 + var_303_16 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_300_1:InitPlayNodeList()
	end,
	Play412102074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 412102074
		arg_304_1.duration_ = 4.97

		local var_304_0 = {
			zh = 1.999999999999,
			ja = 4.966
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play412102075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1097ui_story = arg_304_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_307_0 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_0 then
				arg_304_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_304_1.time_ - 0) / var_307_0)
				arg_304_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1097ui_story"].transform.position).z)
				arg_304_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1097ui_story"].transform.localEulerAngles = arg_304_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_0 and arg_304_1.time_ < 0 + var_307_0 + arg_307_0 then
				arg_304_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_304_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_304_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_304_1.actors_["1097ui_story"].transform.position).z)
				arg_304_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_304_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_304_1.actors_["1097ui_story"].transform.localEulerAngles = arg_304_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_307_1 = arg_304_1.actors_["1097ui_story"]

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1097ui_story == nil then
				arg_304_1.var_.characterEffect1097ui_story = var_307_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_307_2 = 0.200000002980232

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_2 and not isNil(var_307_1) then
				if arg_304_1.var_.characterEffect1097ui_story and not isNil(var_307_1) then
					arg_304_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_304_1.time_ >= 0 + var_307_2 and arg_304_1.time_ < 0 + var_307_2 + arg_307_0 and not isNil(var_307_1) and arg_304_1.var_.characterEffect1097ui_story then
				arg_304_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_307_4 = arg_304_1.actors_["1197ui_story"].transform

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.var_.moveOldPos1197ui_story = var_307_4.localPosition
			end

			local var_307_5 = 0.001

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_5 then
				var_307_4.localPosition = Vector3.Lerp(arg_304_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_304_1.time_ - 0) / var_307_5)
				var_307_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_4.position).x, (manager.ui.mainCamera.transform.position - var_307_4.position).y, (manager.ui.mainCamera.transform.position - var_307_4.position).z)
				var_307_4.localEulerAngles.z = 0
				var_307_4.localEulerAngles.x = 0
				var_307_4.localEulerAngles = var_307_4.localEulerAngles
			end

			if arg_304_1.time_ >= 0 + var_307_5 and arg_304_1.time_ < 0 + var_307_5 + arg_307_0 then
				var_307_4.localPosition = Vector3.New(0, 100, 0)
				var_307_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_307_4.position).x, (manager.ui.mainCamera.transform.position - var_307_4.position).y, (manager.ui.mainCamera.transform.position - var_307_4.position).z)
				var_307_4.localEulerAngles.z = 0
				var_307_4.localEulerAngles.x = 0
				var_307_4.localEulerAngles = var_307_4.localEulerAngles
			end

			local var_307_6 = 0
			local var_307_7 = 0.1

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_6 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_8 = arg_304_1:GetWordFromCfg(412102074)
				local var_307_9 = arg_304_1:FormatText(var_307_8.content)

				arg_304_1.text_.text = var_307_9

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_11 = 4 <= 0 and var_307_7 or var_307_7 * (utf8.len(var_307_9) / 4)

				if (4 <= 0 and var_307_7 or var_307_7 * (utf8.len(var_307_9) / 4)) > 0 and var_307_7 < var_307_11 then
					arg_304_1.talkMaxDuration = var_307_11

					if var_307_11 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_11 + var_307_6
					end
				end

				arg_304_1.text_.text = var_307_9
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102074", "story_v_out_412102.awb") ~= 0 then
					local var_307_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102074", "story_v_out_412102.awb") / 1000

					if var_307_12 + var_307_6 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_12 + var_307_6
					end

					if var_307_8.prefab_name ~= "" and arg_304_1.actors_[var_307_8.prefab_name] ~= nil then
						local var_307_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_8.prefab_name].transform, "story_v_out_412102", "412102074", "story_v_out_412102.awb")

						arg_304_1:RecordAudio("412102074", var_307_13)
						arg_304_1:RecordAudio("412102074", var_307_13)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_412102", "412102074", "story_v_out_412102.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_412102", "412102074", "story_v_out_412102.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_14 = math.max(var_307_7, arg_304_1.talkMaxDuration)

			if var_307_6 <= arg_304_1.time_ and arg_304_1.time_ < var_307_6 + var_307_14 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_6) / var_307_14

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_6 + var_307_14 and arg_304_1.time_ < var_307_6 + var_307_14 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_304_1:InitPlayNodeList()
	end,
	Play412102075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 412102075
		arg_308_1.duration_ = 3.43

		local var_308_0 = {
			zh = 3.2,
			ja = 3.433
		}
		local var_308_1 = manager.audio:GetLocalizationFlag()

		if var_308_0[var_308_1] ~= nil then
			arg_308_1.duration_ = var_308_0[var_308_1]
		end

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play412102076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(arg_308_1.actors_["1097ui_story"]) and arg_308_1.var_.characterEffect1097ui_story == nil then
				arg_308_1.var_.characterEffect1097ui_story = arg_308_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_0 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 and not isNil(arg_308_1.actors_["1097ui_story"]) then
				if arg_308_1.var_.characterEffect1097ui_story and not isNil(arg_308_1.actors_["1097ui_story"]) then
					arg_308_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_308_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_308_1.time_ - 0) / var_311_0)
				end
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 and not isNil(arg_308_1.actors_["1097ui_story"]) and arg_308_1.var_.characterEffect1097ui_story then
				arg_308_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_308_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_311_1 = arg_308_1.actors_["1197ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1197ui_story = var_311_1.localPosition
			end

			local var_311_2 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_2 then
				var_311_1.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_308_1.time_ - 0) / var_311_2)
				var_311_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_1.position).x, (manager.ui.mainCamera.transform.position - var_311_1.position).y, (manager.ui.mainCamera.transform.position - var_311_1.position).z)
				var_311_1.localEulerAngles.z = 0
				var_311_1.localEulerAngles.x = 0
				var_311_1.localEulerAngles = var_311_1.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_2 and arg_308_1.time_ < 0 + var_311_2 + arg_311_0 then
				var_311_1.localPosition = Vector3.New(0, -0.545, -6.3)
				var_311_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_1.position).x, (manager.ui.mainCamera.transform.position - var_311_1.position).y, (manager.ui.mainCamera.transform.position - var_311_1.position).z)
				var_311_1.localEulerAngles.z = 0
				var_311_1.localEulerAngles.x = 0
				var_311_1.localEulerAngles = var_311_1.localEulerAngles
			end

			local var_311_3 = arg_308_1.actors_["1197ui_story"]

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 and not isNil(var_311_3) and arg_308_1.var_.characterEffect1197ui_story == nil then
				arg_308_1.var_.characterEffect1197ui_story = var_311_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_311_4 = 0.200000002980232

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_4 and not isNil(var_311_3) then
				if arg_308_1.var_.characterEffect1197ui_story and not isNil(var_311_3) then
					arg_308_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_308_1.time_ >= 0 + var_311_4 and arg_308_1.time_ < 0 + var_311_4 + arg_311_0 and not isNil(var_311_3) and arg_308_1.var_.characterEffect1197ui_story then
				arg_308_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_311_6 = arg_308_1.actors_["1097ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1097ui_story = var_311_6.localPosition
			end

			local var_311_7 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_7 then
				var_311_6.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_7)
				var_311_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_6.position).x, (manager.ui.mainCamera.transform.position - var_311_6.position).y, (manager.ui.mainCamera.transform.position - var_311_6.position).z)
				var_311_6.localEulerAngles.z = 0
				var_311_6.localEulerAngles.x = 0
				var_311_6.localEulerAngles = var_311_6.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_7 and arg_308_1.time_ < 0 + var_311_7 + arg_311_0 then
				var_311_6.localPosition = Vector3.New(0, 100, 0)
				var_311_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_6.position).x, (manager.ui.mainCamera.transform.position - var_311_6.position).y, (manager.ui.mainCamera.transform.position - var_311_6.position).z)
				var_311_6.localEulerAngles.z = 0
				var_311_6.localEulerAngles.x = 0
				var_311_6.localEulerAngles = var_311_6.localEulerAngles
			end

			local var_311_8 = 0
			local var_311_9 = 0.375

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_8 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, true)

				arg_308_1.leftNameTxt_.text = arg_308_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_308_1.leftNameTxt_.transform)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1.leftNameTxt_.text)
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_10 = arg_308_1:GetWordFromCfg(412102075)
				local var_311_11 = arg_308_1:FormatText(var_311_10.content)

				arg_308_1.text_.text = var_311_11

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_13 = 15 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 15)

				if (15 <= 0 and var_311_9 or var_311_9 * (utf8.len(var_311_11) / 15)) > 0 and var_311_9 < var_311_13 then
					arg_308_1.talkMaxDuration = var_311_13

					if var_311_13 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_13 + var_311_8
					end
				end

				arg_308_1.text_.text = var_311_11
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102075", "story_v_out_412102.awb") ~= 0 then
					local var_311_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102075", "story_v_out_412102.awb") / 1000

					if var_311_14 + var_311_8 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_14 + var_311_8
					end

					if var_311_10.prefab_name ~= "" and arg_308_1.actors_[var_311_10.prefab_name] ~= nil then
						local var_311_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_308_1.actors_[var_311_10.prefab_name].transform, "story_v_out_412102", "412102075", "story_v_out_412102.awb")

						arg_308_1:RecordAudio("412102075", var_311_15)
						arg_308_1:RecordAudio("412102075", var_311_15)
					else
						arg_308_1:AudioAction("play", "voice", "story_v_out_412102", "412102075", "story_v_out_412102.awb")
					end

					arg_308_1:RecordHistoryTalkVoice("story_v_out_412102", "412102075", "story_v_out_412102.awb")
				end

				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_16 = math.max(var_311_9, arg_308_1.talkMaxDuration)

			if var_311_8 <= arg_308_1.time_ and arg_308_1.time_ < var_311_8 + var_311_16 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_8) / var_311_16

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_8 + var_311_16 and arg_308_1.time_ < var_311_8 + var_311_16 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play412102076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 412102076
		arg_312_1.duration_ = 5.6

		local var_312_0 = {
			zh = 5.1,
			ja = 5.6
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play412102077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1097ui_story = arg_312_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_315_0 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_0 then
				arg_312_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_312_1.time_ - 0) / var_315_0)
				arg_312_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).z)
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles = arg_312_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_0 and arg_312_1.time_ < 0 + var_315_0 + arg_315_0 then
				arg_312_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_312_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["1097ui_story"].transform.position).z)
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["1097ui_story"].transform.localEulerAngles = arg_312_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_315_1 = arg_312_1.actors_["1097ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1097ui_story == nil then
				arg_312_1.var_.characterEffect1097ui_story = var_315_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_2 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_2 and not isNil(var_315_1) then
				if arg_312_1.var_.characterEffect1097ui_story and not isNil(var_315_1) then
					arg_312_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_2 and arg_312_1.time_ < 0 + var_315_2 + arg_315_0 and not isNil(var_315_1) and arg_312_1.var_.characterEffect1097ui_story then
				arg_312_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_315_4 = arg_312_1.actors_["1197ui_story"].transform

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos1197ui_story = var_315_4.localPosition
			end

			local var_315_5 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_5 then
				var_315_4.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_312_1.time_ - 0) / var_315_5)
				var_315_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_4.position).x, (manager.ui.mainCamera.transform.position - var_315_4.position).y, (manager.ui.mainCamera.transform.position - var_315_4.position).z)
				var_315_4.localEulerAngles.z = 0
				var_315_4.localEulerAngles.x = 0
				var_315_4.localEulerAngles = var_315_4.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_5 and arg_312_1.time_ < 0 + var_315_5 + arg_315_0 then
				var_315_4.localPosition = Vector3.New(0, 100, 0)
				var_315_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_315_4.position).x, (manager.ui.mainCamera.transform.position - var_315_4.position).y, (manager.ui.mainCamera.transform.position - var_315_4.position).z)
				var_315_4.localEulerAngles.z = 0
				var_315_4.localEulerAngles.x = 0
				var_315_4.localEulerAngles = var_315_4.localEulerAngles
			end

			local var_315_6 = 0
			local var_315_7 = 0.65

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_8 = arg_312_1:GetWordFromCfg(412102076)
				local var_315_9 = arg_312_1:FormatText(var_315_8.content)

				arg_312_1.text_.text = var_315_9

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 26 <= 0 and var_315_7 or var_315_7 * (utf8.len(var_315_9) / 26)

				if (26 <= 0 and var_315_7 or var_315_7 * (utf8.len(var_315_9) / 26)) > 0 and var_315_7 < var_315_11 then
					arg_312_1.talkMaxDuration = var_315_11

					if var_315_11 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_11 + var_315_6
					end
				end

				arg_312_1.text_.text = var_315_9
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102076", "story_v_out_412102.awb") ~= 0 then
					local var_315_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102076", "story_v_out_412102.awb") / 1000

					if var_315_12 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_12 + var_315_6
					end

					if var_315_8.prefab_name ~= "" and arg_312_1.actors_[var_315_8.prefab_name] ~= nil then
						local var_315_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_8.prefab_name].transform, "story_v_out_412102", "412102076", "story_v_out_412102.awb")

						arg_312_1:RecordAudio("412102076", var_315_13)
						arg_312_1:RecordAudio("412102076", var_315_13)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_412102", "412102076", "story_v_out_412102.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_412102", "412102076", "story_v_out_412102.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_14 = math.max(var_315_7, arg_312_1.talkMaxDuration)

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_14 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_14

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_14 and arg_312_1.time_ < var_315_6 + var_315_14 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play412102077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 412102077
		arg_316_1.duration_ = 6.1

		local var_316_0 = {
			zh = 4.433,
			ja = 6.1
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play412102078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.5

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, false)
				arg_316_1.callingController_:SetSelectedState("normal")

				local var_319_1 = arg_316_1:GetWordFromCfg(412102077)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 20 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 20)

				if (20 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 20)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102077", "story_v_out_412102.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102077", "story_v_out_412102.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_412102", "412102077", "story_v_out_412102.awb")

						arg_316_1:RecordAudio("412102077", var_319_6)
						arg_316_1:RecordAudio("412102077", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_412102", "412102077", "story_v_out_412102.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_412102", "412102077", "story_v_out_412102.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play412102078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 412102078
		arg_320_1.duration_ = 7.43

		local var_320_0 = {
			zh = 6.6,
			ja = 7.433
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play412102079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1197ui_story = arg_320_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_323_0 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_0 then
				arg_320_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_320_1.time_ - 0) / var_323_0)
				arg_320_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1197ui_story"].transform.position).z)
				arg_320_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1197ui_story"].transform.localEulerAngles = arg_320_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_0 and arg_320_1.time_ < 0 + var_323_0 + arg_323_0 then
				arg_320_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_320_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["1197ui_story"].transform.position).z)
				arg_320_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["1197ui_story"].transform.localEulerAngles = arg_320_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_323_1 = arg_320_1.actors_["1197ui_story"]

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1197ui_story == nil then
				arg_320_1.var_.characterEffect1197ui_story = var_323_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_323_2 = 0.200000002980232

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_2 and not isNil(var_323_1) then
				if arg_320_1.var_.characterEffect1197ui_story and not isNil(var_323_1) then
					arg_320_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_320_1.time_ >= 0 + var_323_2 and arg_320_1.time_ < 0 + var_323_2 + arg_323_0 and not isNil(var_323_1) and arg_320_1.var_.characterEffect1197ui_story then
				arg_320_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			local var_323_4 = arg_320_1.actors_["1097ui_story"].transform

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos1097ui_story = var_323_4.localPosition
			end

			local var_323_5 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_5 then
				var_323_4.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_320_1.time_ - 0) / var_323_5)
				var_323_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_323_4.position).x, (manager.ui.mainCamera.transform.position - var_323_4.position).y, (manager.ui.mainCamera.transform.position - var_323_4.position).z)
				var_323_4.localEulerAngles.z = 0
				var_323_4.localEulerAngles.x = 0
				var_323_4.localEulerAngles = var_323_4.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_5 and arg_320_1.time_ < 0 + var_323_5 + arg_323_0 then
				var_323_4.localPosition = Vector3.New(0, 100, 0)
				var_323_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_323_4.position).x, (manager.ui.mainCamera.transform.position - var_323_4.position).y, (manager.ui.mainCamera.transform.position - var_323_4.position).z)
				var_323_4.localEulerAngles.z = 0
				var_323_4.localEulerAngles.x = 0
				var_323_4.localEulerAngles = var_323_4.localEulerAngles
			end

			local var_323_6 = 0
			local var_323_7 = 0.75

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_6 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[927].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_8 = arg_320_1:GetWordFromCfg(412102078)
				local var_323_9 = arg_320_1:FormatText(var_323_8.content)

				arg_320_1.text_.text = var_323_9

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_11 = 30 <= 0 and var_323_7 or var_323_7 * (utf8.len(var_323_9) / 30)

				if (30 <= 0 and var_323_7 or var_323_7 * (utf8.len(var_323_9) / 30)) > 0 and var_323_7 < var_323_11 then
					arg_320_1.talkMaxDuration = var_323_11

					if var_323_11 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_11 + var_323_6
					end
				end

				arg_320_1.text_.text = var_323_9
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102078", "story_v_out_412102.awb") ~= 0 then
					local var_323_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102078", "story_v_out_412102.awb") / 1000

					if var_323_12 + var_323_6 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_12 + var_323_6
					end

					if var_323_8.prefab_name ~= "" and arg_320_1.actors_[var_323_8.prefab_name] ~= nil then
						local var_323_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_8.prefab_name].transform, "story_v_out_412102", "412102078", "story_v_out_412102.awb")

						arg_320_1:RecordAudio("412102078", var_323_13)
						arg_320_1:RecordAudio("412102078", var_323_13)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_412102", "412102078", "story_v_out_412102.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_412102", "412102078", "story_v_out_412102.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_14 = math.max(var_323_7, arg_320_1.talkMaxDuration)

			if var_323_6 <= arg_320_1.time_ and arg_320_1.time_ < var_323_6 + var_323_14 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_6) / var_323_14

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_6 + var_323_14 and arg_320_1.time_ < var_323_6 + var_323_14 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play412102079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 412102079
		arg_324_1.duration_ = 2

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play412102080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1097ui_story = arg_324_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_327_0 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 then
				arg_324_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1097ui_story, Vector3.New(0, -0.54, -6.3), (arg_324_1.time_ - 0) / var_327_0)
				arg_324_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1097ui_story"].transform.position).z)
				arg_324_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["1097ui_story"].transform.localEulerAngles = arg_324_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 then
				arg_324_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, -0.54, -6.3)
				arg_324_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_324_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_324_1.actors_["1097ui_story"].transform.position).z)
				arg_324_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_324_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_324_1.actors_["1097ui_story"].transform.localEulerAngles = arg_324_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_327_1 = arg_324_1.actors_["1097ui_story"]

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect1097ui_story == nil then
				arg_324_1.var_.characterEffect1097ui_story = var_327_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_2 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_2 and not isNil(var_327_1) then
				if arg_324_1.var_.characterEffect1097ui_story and not isNil(var_327_1) then
					arg_324_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_2 and arg_324_1.time_ < 0 + var_327_2 + arg_327_0 and not isNil(var_327_1) and arg_324_1.var_.characterEffect1097ui_story then
				arg_324_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action1_1")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_327_4 = arg_324_1.actors_["1197ui_story"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos1197ui_story = var_327_4.localPosition
			end

			local var_327_5 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_5 then
				var_327_4.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_324_1.time_ - 0) / var_327_5)
				var_327_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_4.position).x, (manager.ui.mainCamera.transform.position - var_327_4.position).y, (manager.ui.mainCamera.transform.position - var_327_4.position).z)
				var_327_4.localEulerAngles.z = 0
				var_327_4.localEulerAngles.x = 0
				var_327_4.localEulerAngles = var_327_4.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_5 and arg_324_1.time_ < 0 + var_327_5 + arg_327_0 then
				var_327_4.localPosition = Vector3.New(0, 100, 0)
				var_327_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_4.position).x, (manager.ui.mainCamera.transform.position - var_327_4.position).y, (manager.ui.mainCamera.transform.position - var_327_4.position).z)
				var_327_4.localEulerAngles.z = 0
				var_327_4.localEulerAngles.x = 0
				var_327_4.localEulerAngles = var_327_4.localEulerAngles
			end

			local var_327_6 = 0
			local var_327_7 = 0.075

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[928].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_8 = arg_324_1:GetWordFromCfg(412102079)
				local var_327_9 = arg_324_1:FormatText(var_327_8.content)

				arg_324_1.text_.text = var_327_9

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 3 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 3)

				if (3 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 3)) > 0 and var_327_7 < var_327_11 then
					arg_324_1.talkMaxDuration = var_327_11

					if var_327_11 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_11 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_9
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102079", "story_v_out_412102.awb") ~= 0 then
					local var_327_12 = manager.audio:GetVoiceLength("story_v_out_412102", "412102079", "story_v_out_412102.awb") / 1000

					if var_327_12 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_6
					end

					if var_327_8.prefab_name ~= "" and arg_324_1.actors_[var_327_8.prefab_name] ~= nil then
						local var_327_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_8.prefab_name].transform, "story_v_out_412102", "412102079", "story_v_out_412102.awb")

						arg_324_1:RecordAudio("412102079", var_327_13)
						arg_324_1:RecordAudio("412102079", var_327_13)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_412102", "412102079", "story_v_out_412102.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_412102", "412102079", "story_v_out_412102.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play412102080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 412102080
		arg_328_1.duration_ = 5.13

		local var_328_0 = {
			zh = 5.13333333333333,
			ja = 4.73333333333333
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play412102081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if arg_328_1.bgs_.STwhite == nil then
				local var_331_0 = Object.Instantiate(arg_328_1.paintGo_)

				var_331_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STwhite")
				var_331_0.name = "STwhite"
				var_331_0.transform.parent = arg_328_1.stage_.transform
				var_331_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.bgs_.STwhite = var_331_0
			end

			if 0.4 < arg_328_1.time_ and arg_328_1.time_ <= 0.4 + arg_331_0 then
				local var_331_1 = arg_328_1.bgs_.STwhite

				arg_328_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_331_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_2 = var_331_1:GetComponent("SpriteRenderer")

				if var_331_2 and var_331_2.sprite then
					local var_331_3 = 2 * (var_331_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_331_1.transform.localScale = Vector3.New(var_331_3 / var_331_2.sprite.bounds.size.y < var_331_3 * manager.ui.mainCameraCom_.aspect / var_331_2.sprite.bounds.size.x and var_331_3 * manager.ui.mainCameraCom_.aspect / var_331_2.sprite.bounds.size.x or var_331_3 / var_331_2.sprite.bounds.size.y, var_331_3 / var_331_2.sprite.bounds.size.y < var_331_3 * manager.ui.mainCameraCom_.aspect / var_331_2.sprite.bounds.size.x and var_331_3 * manager.ui.mainCameraCom_.aspect / var_331_2.sprite.bounds.size.x or var_331_3 / var_331_2.sprite.bounds.size.y, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "STwhite" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_4 = "10076ui_story"

			if arg_328_1.actors_["10076ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10076ui_story"))) then
				local var_331_5 = Object.Instantiate(Asset.Load("Char/" .. "10076ui_story"), arg_328_1.stage_.transform)

				var_331_5.name = var_331_4
				var_331_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_328_1.actors_[var_331_4] = var_331_5

				local var_331_6 = var_331_5:GetComponentInChildren(typeof(CharacterEffect))

				var_331_6.enabled = true

				local var_331_7 = GameObjectTools.GetOrAddComponent(var_331_5, typeof(DynamicBoneHelper))

				if var_331_7 then
					var_331_7:EnableDynamicBone(false)
				end

				arg_328_1:ShowWeapon(var_331_6.transform, false)

				arg_328_1.var_[var_331_4 .. "Animator"] = var_331_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_328_1.var_[var_331_4 .. "Animator"].applyRootMotion = true
				arg_328_1.var_[var_331_4 .. "LipSync"] = var_331_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_331_8 = arg_328_1.actors_["10076ui_story"].transform

			if 0.2 < arg_328_1.time_ and arg_328_1.time_ <= 0.2 + arg_331_0 then
				arg_328_1.var_.moveOldPos10076ui_story = var_331_8.localPosition
			end

			local var_331_9 = 0.001

			if 0.2 <= arg_328_1.time_ and arg_328_1.time_ < 0.2 + var_331_9 then
				var_331_8.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10076ui_story, Vector3.New(0, -0.35, -4), (arg_328_1.time_ - 0.2) / var_331_9)
				var_331_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_8.position).x, (manager.ui.mainCamera.transform.position - var_331_8.position).y, (manager.ui.mainCamera.transform.position - var_331_8.position).z)
				var_331_8.localEulerAngles.z = 0
				var_331_8.localEulerAngles.x = 0
				var_331_8.localEulerAngles = var_331_8.localEulerAngles
			end

			if arg_328_1.time_ >= 0.2 + var_331_9 and arg_328_1.time_ < 0.2 + var_331_9 + arg_331_0 then
				var_331_8.localPosition = Vector3.New(0, -0.35, -4)
				var_331_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_8.position).x, (manager.ui.mainCamera.transform.position - var_331_8.position).y, (manager.ui.mainCamera.transform.position - var_331_8.position).z)
				var_331_8.localEulerAngles.z = 0
				var_331_8.localEulerAngles.x = 0
				var_331_8.localEulerAngles = var_331_8.localEulerAngles
			end

			local var_331_10 = arg_328_1.actors_["10076ui_story"]

			if 0.2 < arg_328_1.time_ and arg_328_1.time_ <= 0.2 + arg_331_0 and not isNil(var_331_10) and arg_328_1.var_.characterEffect10076ui_story == nil then
				arg_328_1.var_.characterEffect10076ui_story = var_331_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_11 = 0.034000001847744

			if 0.2 <= arg_328_1.time_ and arg_328_1.time_ < 0.2 + var_331_11 and not isNil(var_331_10) then
				if arg_328_1.var_.characterEffect10076ui_story and not isNil(var_331_10) then
					arg_328_1.var_.characterEffect10076ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 0.2 + var_331_11 and arg_328_1.time_ < 0.2 + var_331_11 + arg_331_0 and not isNil(var_331_10) and arg_328_1.var_.characterEffect10076ui_story then
				arg_328_1.var_.characterEffect10076ui_story.fillFlat = false
			end

			if 0.4 < arg_328_1.time_ and arg_328_1.time_ <= 0.4 + arg_331_0 then
				arg_328_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/story10076/story10076action/10076action1_1")
			end

			if 0.4 < arg_328_1.time_ and arg_328_1.time_ <= 0.4 + arg_331_0 then
				arg_328_1:PlayTimeline("10076ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_331_13 = arg_328_1.actors_["1097ui_story"].transform

			if 0.4 < arg_328_1.time_ and arg_328_1.time_ <= 0.4 + arg_331_0 then
				arg_328_1.var_.moveOldPos1097ui_story = var_331_13.localPosition
			end

			local var_331_14 = 0.001

			if 0.4 <= arg_328_1.time_ and arg_328_1.time_ < 0.4 + var_331_14 then
				var_331_13.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_328_1.time_ - 0.4) / var_331_14)
				var_331_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_13.position).x, (manager.ui.mainCamera.transform.position - var_331_13.position).y, (manager.ui.mainCamera.transform.position - var_331_13.position).z)
				var_331_13.localEulerAngles.z = 0
				var_331_13.localEulerAngles.x = 0
				var_331_13.localEulerAngles = var_331_13.localEulerAngles
			end

			if arg_328_1.time_ >= 0.4 + var_331_14 and arg_328_1.time_ < 0.4 + var_331_14 + arg_331_0 then
				var_331_13.localPosition = Vector3.New(0, 100, 0)
				var_331_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_13.position).x, (manager.ui.mainCamera.transform.position - var_331_13.position).y, (manager.ui.mainCamera.transform.position - var_331_13.position).z)
				var_331_13.localEulerAngles.z = 0
				var_331_13.localEulerAngles.x = 0
				var_331_13.localEulerAngles = var_331_13.localEulerAngles
			end

			local var_331_15 = arg_328_1.actors_["1097ui_story"]

			if 0.4 < arg_328_1.time_ and arg_328_1.time_ <= 0.4 + arg_331_0 and not isNil(var_331_15) and arg_328_1.var_.characterEffect1097ui_story == nil then
				arg_328_1.var_.characterEffect1097ui_story = var_331_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_16 = 0.200000002980232

			if 0.4 <= arg_328_1.time_ and arg_328_1.time_ < 0.4 + var_331_16 and not isNil(var_331_15) then
				if arg_328_1.var_.characterEffect1097ui_story and not isNil(var_331_15) then
					arg_328_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_328_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 0.4) / var_331_16)
				end
			end

			if arg_328_1.time_ >= 0.4 + var_331_16 and arg_328_1.time_ < 0.4 + var_331_16 + arg_331_0 and not isNil(var_331_15) and arg_328_1.var_.characterEffect1097ui_story then
				arg_328_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_328_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_331_17 = 0.200000002980232

			if 0.200000002980232 < arg_328_1.time_ and arg_328_1.time_ <= var_331_17 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_18 = 1.2

			if var_331_17 <= arg_328_1.time_ and arg_328_1.time_ < var_331_17 + var_331_18 then
				local var_331_19 = Color.New(1, 1, 1)

				var_331_19.a = Mathf.Lerp(1, 0, (arg_328_1.time_ - var_331_17) / var_331_18)
				arg_328_1.mask_.color = var_331_19
			end

			if arg_328_1.time_ >= var_331_17 + var_331_18 and arg_328_1.time_ < var_331_17 + var_331_18 + arg_331_0 then
				local var_331_20 = Color.New(1, 1, 1)

				arg_328_1.mask_.enabled = false
				var_331_20.a = 0
				arg_328_1.mask_.color = var_331_20
			end

			local var_331_21 = 0

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_21 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			if arg_328_1.time_ >= var_331_21 + 0.200000002980232 and arg_328_1.time_ < var_331_21 + 0.200000002980232 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_22 = 0.733333333333333
			local var_331_23 = 0.4

			if 0.733333333333333 < arg_328_1.time_ and arg_328_1.time_ <= var_331_22 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[917].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_24 = arg_328_1:GetWordFromCfg(412102080)
				local var_331_25 = arg_328_1:FormatText(var_331_24.content)

				arg_328_1.text_.text = var_331_25

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_27 = 16 <= 0 and var_331_23 or var_331_23 * (utf8.len(var_331_25) / 16)

				if (16 <= 0 and var_331_23 or var_331_23 * (utf8.len(var_331_25) / 16)) > 0 and var_331_23 < var_331_27 then
					arg_328_1.talkMaxDuration = var_331_27

					if var_331_27 + var_331_22 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_27 + var_331_22
					end
				end

				arg_328_1.text_.text = var_331_25
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102080", "story_v_out_412102.awb") ~= 0 then
					local var_331_28 = manager.audio:GetVoiceLength("story_v_out_412102", "412102080", "story_v_out_412102.awb") / 1000

					if var_331_28 + var_331_22 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_28 + var_331_22
					end

					if var_331_24.prefab_name ~= "" and arg_328_1.actors_[var_331_24.prefab_name] ~= nil then
						local var_331_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_24.prefab_name].transform, "story_v_out_412102", "412102080", "story_v_out_412102.awb")

						arg_328_1:RecordAudio("412102080", var_331_29)
						arg_328_1:RecordAudio("412102080", var_331_29)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_412102", "412102080", "story_v_out_412102.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_412102", "412102080", "story_v_out_412102.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_30 = math.max(var_331_23, arg_328_1.talkMaxDuration)

			if var_331_22 <= arg_328_1.time_ and arg_328_1.time_ < var_331_22 + var_331_30 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_22) / var_331_30

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_22 + var_331_30 and arg_328_1.time_ < var_331_22 + var_331_30 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0.4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play412102081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 412102081
		arg_332_1.duration_ = 4.93

		local var_332_0 = {
			zh = 4.333,
			ja = 4.933
		}
		local var_332_1 = manager.audio:GetLocalizationFlag()

		if var_332_0[var_332_1] ~= nil then
			arg_332_1.duration_ = var_332_0[var_332_1]
		end

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play412102082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if arg_332_1.actors_["10077ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10077ui_story"))) then
				local var_335_0 = Object.Instantiate(Asset.Load("Char/" .. "10077ui_story"), arg_332_1.stage_.transform)

				var_335_0.name = "10077ui_story"
				var_335_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_332_1.actors_["10077ui_story"] = var_335_0

				local var_335_1 = var_335_0:GetComponentInChildren(typeof(CharacterEffect))

				var_335_1.enabled = true

				local var_335_2 = GameObjectTools.GetOrAddComponent(var_335_0, typeof(DynamicBoneHelper))

				if var_335_2 then
					var_335_2:EnableDynamicBone(false)
				end

				arg_332_1:ShowWeapon(var_335_1.transform, false)

				arg_332_1.var_["10077ui_story" .. "Animator"] = var_335_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_332_1.var_["10077ui_story" .. "Animator"].applyRootMotion = true
				arg_332_1.var_["10077ui_story" .. "LipSync"] = var_335_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_335_3 = arg_332_1.actors_["10077ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10077ui_story = var_335_3.localPosition
			end

			local var_335_4 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_4 then
				var_335_3.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10077ui_story, Vector3.New(0, 0, -5), (arg_332_1.time_ - 0) / var_335_4)
				var_335_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_3.position).x, (manager.ui.mainCamera.transform.position - var_335_3.position).y, (manager.ui.mainCamera.transform.position - var_335_3.position).z)
				var_335_3.localEulerAngles.z = 0
				var_335_3.localEulerAngles.x = 0
				var_335_3.localEulerAngles = var_335_3.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_4 and arg_332_1.time_ < 0 + var_335_4 + arg_335_0 then
				var_335_3.localPosition = Vector3.New(0, 0, -5)
				var_335_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_3.position).x, (manager.ui.mainCamera.transform.position - var_335_3.position).y, (manager.ui.mainCamera.transform.position - var_335_3.position).z)
				var_335_3.localEulerAngles.z = 0
				var_335_3.localEulerAngles.x = 0
				var_335_3.localEulerAngles = var_335_3.localEulerAngles
			end

			local var_335_5 = arg_332_1.actors_["10077ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.characterEffect10077ui_story == nil then
				arg_332_1.var_.characterEffect10077ui_story = var_335_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_6 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_6 and not isNil(var_335_5) then
				if arg_332_1.var_.characterEffect10077ui_story and not isNil(var_335_5) then
					arg_332_1.var_.characterEffect10077ui_story.fillFlat = false
				end
			end

			if arg_332_1.time_ >= 0 + var_335_6 and arg_332_1.time_ < 0 + var_335_6 + arg_335_0 and not isNil(var_335_5) and arg_332_1.var_.characterEffect10077ui_story then
				arg_332_1.var_.characterEffect10077ui_story.fillFlat = false
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/story10077/story10077action/10077action4_1")
			end

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1:PlayTimeline("10077ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_335_8 = arg_332_1.actors_["10076ui_story"].transform

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				arg_332_1.var_.moveOldPos10076ui_story = var_335_8.localPosition
			end

			local var_335_9 = 0.001

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_9 then
				var_335_8.localPosition = Vector3.Lerp(arg_332_1.var_.moveOldPos10076ui_story, Vector3.New(0, 100, 0), (arg_332_1.time_ - 0) / var_335_9)
				var_335_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_8.position).x, (manager.ui.mainCamera.transform.position - var_335_8.position).y, (manager.ui.mainCamera.transform.position - var_335_8.position).z)
				var_335_8.localEulerAngles.z = 0
				var_335_8.localEulerAngles.x = 0
				var_335_8.localEulerAngles = var_335_8.localEulerAngles
			end

			if arg_332_1.time_ >= 0 + var_335_9 and arg_332_1.time_ < 0 + var_335_9 + arg_335_0 then
				var_335_8.localPosition = Vector3.New(0, 100, 0)
				var_335_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_335_8.position).x, (manager.ui.mainCamera.transform.position - var_335_8.position).y, (manager.ui.mainCamera.transform.position - var_335_8.position).z)
				var_335_8.localEulerAngles.z = 0
				var_335_8.localEulerAngles.x = 0
				var_335_8.localEulerAngles = var_335_8.localEulerAngles
			end

			local var_335_10 = arg_332_1.actors_["10076ui_story"]

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 and not isNil(var_335_10) and arg_332_1.var_.characterEffect10076ui_story == nil then
				arg_332_1.var_.characterEffect10076ui_story = var_335_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_335_11 = 0.200000002980232

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_11 and not isNil(var_335_10) then
				if arg_332_1.var_.characterEffect10076ui_story and not isNil(var_335_10) then
					arg_332_1.var_.characterEffect10076ui_story.fillFlat = true
					arg_332_1.var_.characterEffect10076ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_332_1.time_ - 0) / var_335_11)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_11 and arg_332_1.time_ < 0 + var_335_11 + arg_335_0 and not isNil(var_335_10) and arg_332_1.var_.characterEffect10076ui_story then
				arg_332_1.var_.characterEffect10076ui_story.fillFlat = true
				arg_332_1.var_.characterEffect10076ui_story.fillRatio = 0.5
			end

			local var_335_12 = 0
			local var_335_13 = 0.425

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_12 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, true)

				arg_332_1.leftNameTxt_.text = arg_332_1:FormatText(StoryNameCfg[922].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_332_1.leftNameTxt_.transform)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1.leftNameTxt_.text)
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_14 = arg_332_1:GetWordFromCfg(412102081)
				local var_335_15 = arg_332_1:FormatText(var_335_14.content)

				arg_332_1.text_.text = var_335_15

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_17 = 17 <= 0 and var_335_13 or var_335_13 * (utf8.len(var_335_15) / 17)

				if (17 <= 0 and var_335_13 or var_335_13 * (utf8.len(var_335_15) / 17)) > 0 and var_335_13 < var_335_17 then
					arg_332_1.talkMaxDuration = var_335_17

					if var_335_17 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_17 + var_335_12
					end
				end

				arg_332_1.text_.text = var_335_15
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102081", "story_v_out_412102.awb") ~= 0 then
					local var_335_18 = manager.audio:GetVoiceLength("story_v_out_412102", "412102081", "story_v_out_412102.awb") / 1000

					if var_335_18 + var_335_12 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_18 + var_335_12
					end

					if var_335_14.prefab_name ~= "" and arg_332_1.actors_[var_335_14.prefab_name] ~= nil then
						local var_335_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_332_1.actors_[var_335_14.prefab_name].transform, "story_v_out_412102", "412102081", "story_v_out_412102.awb")

						arg_332_1:RecordAudio("412102081", var_335_19)
						arg_332_1:RecordAudio("412102081", var_335_19)
					else
						arg_332_1:AudioAction("play", "voice", "story_v_out_412102", "412102081", "story_v_out_412102.awb")
					end

					arg_332_1:RecordHistoryTalkVoice("story_v_out_412102", "412102081", "story_v_out_412102.awb")
				end

				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_20 = math.max(var_335_13, arg_332_1.talkMaxDuration)

			if var_335_12 <= arg_332_1.time_ and arg_332_1.time_ < var_335_12 + var_335_20 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_12) / var_335_20

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_12 + var_335_20 and arg_332_1.time_ < var_335_12 + var_335_20 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10076ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_332_1:InitPlayNodeList()
	end,
	Play412102082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 412102082
		arg_336_1.duration_ = 6.3

		local var_336_0 = {
			zh = 5.233,
			ja = 6.3
		}
		local var_336_1 = manager.audio:GetLocalizationFlag()

		if var_336_0[var_336_1] ~= nil then
			arg_336_1.duration_ = var_336_0[var_336_1]
		end

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play412102083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			if arg_336_1.actors_["10078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10078ui_story"))) then
				local var_339_0 = Object.Instantiate(Asset.Load("Char/" .. "10078ui_story"), arg_336_1.stage_.transform)

				var_339_0.name = "10078ui_story"
				var_339_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_336_1.actors_["10078ui_story"] = var_339_0

				local var_339_1 = var_339_0:GetComponentInChildren(typeof(CharacterEffect))

				var_339_1.enabled = true

				local var_339_2 = GameObjectTools.GetOrAddComponent(var_339_0, typeof(DynamicBoneHelper))

				if var_339_2 then
					var_339_2:EnableDynamicBone(false)
				end

				arg_336_1:ShowWeapon(var_339_1.transform, false)

				arg_336_1.var_["10078ui_story" .. "Animator"] = var_339_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_336_1.var_["10078ui_story" .. "Animator"].applyRootMotion = true
				arg_336_1.var_["10078ui_story" .. "LipSync"] = var_339_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_339_3 = arg_336_1.actors_["10078ui_story"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10078ui_story = var_339_3.localPosition
			end

			local var_339_4 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				var_339_3.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10078ui_story, Vector3.New(0, -0.5, -6.3), (arg_336_1.time_ - 0) / var_339_4)
				var_339_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_3.position).x, (manager.ui.mainCamera.transform.position - var_339_3.position).y, (manager.ui.mainCamera.transform.position - var_339_3.position).z)
				var_339_3.localEulerAngles.z = 0
				var_339_3.localEulerAngles.x = 0
				var_339_3.localEulerAngles = var_339_3.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				var_339_3.localPosition = Vector3.New(0, -0.5, -6.3)
				var_339_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_3.position).x, (manager.ui.mainCamera.transform.position - var_339_3.position).y, (manager.ui.mainCamera.transform.position - var_339_3.position).z)
				var_339_3.localEulerAngles.z = 0
				var_339_3.localEulerAngles.x = 0
				var_339_3.localEulerAngles = var_339_3.localEulerAngles
			end

			local var_339_5 = arg_336_1.actors_["10078ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.characterEffect10078ui_story == nil then
				arg_336_1.var_.characterEffect10078ui_story = var_339_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_6 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_6 and not isNil(var_339_5) then
				if arg_336_1.var_.characterEffect10078ui_story and not isNil(var_339_5) then
					arg_336_1.var_.characterEffect10078ui_story.fillFlat = false
				end
			end

			if arg_336_1.time_ >= 0 + var_339_6 and arg_336_1.time_ < 0 + var_339_6 + arg_339_0 and not isNil(var_339_5) and arg_336_1.var_.characterEffect10078ui_story then
				arg_336_1.var_.characterEffect10078ui_story.fillFlat = false
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/story6046/story6046action/6046action5_1")
			end

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1:PlayTimeline("10078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_339_8 = arg_336_1.actors_["10077ui_story"].transform

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.var_.moveOldPos10077ui_story = var_339_8.localPosition
			end

			local var_339_9 = 0.001

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_9 then
				var_339_8.localPosition = Vector3.Lerp(arg_336_1.var_.moveOldPos10077ui_story, Vector3.New(0, 100, 0), (arg_336_1.time_ - 0) / var_339_9)
				var_339_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_8.position).x, (manager.ui.mainCamera.transform.position - var_339_8.position).y, (manager.ui.mainCamera.transform.position - var_339_8.position).z)
				var_339_8.localEulerAngles.z = 0
				var_339_8.localEulerAngles.x = 0
				var_339_8.localEulerAngles = var_339_8.localEulerAngles
			end

			if arg_336_1.time_ >= 0 + var_339_9 and arg_336_1.time_ < 0 + var_339_9 + arg_339_0 then
				var_339_8.localPosition = Vector3.New(0, 100, 0)
				var_339_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_339_8.position).x, (manager.ui.mainCamera.transform.position - var_339_8.position).y, (manager.ui.mainCamera.transform.position - var_339_8.position).z)
				var_339_8.localEulerAngles.z = 0
				var_339_8.localEulerAngles.x = 0
				var_339_8.localEulerAngles = var_339_8.localEulerAngles
			end

			local var_339_10 = arg_336_1.actors_["10077ui_story"]

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 and not isNil(var_339_10) and arg_336_1.var_.characterEffect10077ui_story == nil then
				arg_336_1.var_.characterEffect10077ui_story = var_339_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_339_11 = 0.200000002980232

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_11 and not isNil(var_339_10) then
				if arg_336_1.var_.characterEffect10077ui_story and not isNil(var_339_10) then
					arg_336_1.var_.characterEffect10077ui_story.fillFlat = true
					arg_336_1.var_.characterEffect10077ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_336_1.time_ - 0) / var_339_11)
				end
			end

			if arg_336_1.time_ >= 0 + var_339_11 and arg_336_1.time_ < 0 + var_339_11 + arg_339_0 and not isNil(var_339_10) and arg_336_1.var_.characterEffect10077ui_story then
				arg_336_1.var_.characterEffect10077ui_story.fillFlat = true
				arg_336_1.var_.characterEffect10077ui_story.fillRatio = 0.5
			end

			local var_339_12 = 0
			local var_339_13 = 0.325

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= var_339_12 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, true)

				arg_336_1.leftNameTxt_.text = arg_336_1:FormatText(StoryNameCfg[919].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_336_1.leftNameTxt_.transform)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1.leftNameTxt_.text)
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_14 = arg_336_1:GetWordFromCfg(412102082)
				local var_339_15 = arg_336_1:FormatText(var_339_14.content)

				arg_336_1.text_.text = var_339_15

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_17 = 13 <= 0 and var_339_13 or var_339_13 * (utf8.len(var_339_15) / 13)

				if (13 <= 0 and var_339_13 or var_339_13 * (utf8.len(var_339_15) / 13)) > 0 and var_339_13 < var_339_17 then
					arg_336_1.talkMaxDuration = var_339_17

					if var_339_17 + var_339_12 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_17 + var_339_12
					end
				end

				arg_336_1.text_.text = var_339_15
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102082", "story_v_out_412102.awb") ~= 0 then
					local var_339_18 = manager.audio:GetVoiceLength("story_v_out_412102", "412102082", "story_v_out_412102.awb") / 1000

					if var_339_18 + var_339_12 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_18 + var_339_12
					end

					if var_339_14.prefab_name ~= "" and arg_336_1.actors_[var_339_14.prefab_name] ~= nil then
						local var_339_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_336_1.actors_[var_339_14.prefab_name].transform, "story_v_out_412102", "412102082", "story_v_out_412102.awb")

						arg_336_1:RecordAudio("412102082", var_339_19)
						arg_336_1:RecordAudio("412102082", var_339_19)
					else
						arg_336_1:AudioAction("play", "voice", "story_v_out_412102", "412102082", "story_v_out_412102.awb")
					end

					arg_336_1:RecordHistoryTalkVoice("story_v_out_412102", "412102082", "story_v_out_412102.awb")
				end

				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_20 = math.max(var_339_13, arg_336_1.talkMaxDuration)

			if var_339_12 <= arg_336_1.time_ and arg_336_1.time_ < var_339_12 + var_339_20 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - var_339_12) / var_339_20

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= var_339_12 + var_339_20 and arg_336_1.time_ < var_339_12 + var_339_20 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10077ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_336_1:InitPlayNodeList()
	end,
	Play412102083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 412102083
		arg_340_1.duration_ = 4.57

		local var_340_0 = {
			zh = 4.566,
			ja = 4.166
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play412102084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if arg_340_1.actors_["10083ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10083ui_story"))) then
				local var_343_0 = Object.Instantiate(Asset.Load("Char/" .. "10083ui_story"), arg_340_1.stage_.transform)

				var_343_0.name = "10083ui_story"
				var_343_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_340_1.actors_["10083ui_story"] = var_343_0

				local var_343_1 = var_343_0:GetComponentInChildren(typeof(CharacterEffect))

				var_343_1.enabled = true

				local var_343_2 = GameObjectTools.GetOrAddComponent(var_343_0, typeof(DynamicBoneHelper))

				if var_343_2 then
					var_343_2:EnableDynamicBone(false)
				end

				arg_340_1:ShowWeapon(var_343_1.transform, false)

				arg_340_1.var_["10083ui_story" .. "Animator"] = var_343_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_340_1.var_["10083ui_story" .. "Animator"].applyRootMotion = true
				arg_340_1.var_["10083ui_story" .. "LipSync"] = var_343_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_343_3 = arg_340_1.actors_["10083ui_story"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos10083ui_story = var_343_3.localPosition
			end

			local var_343_4 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				var_343_3.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10083ui_story, Vector3.New(0, -2.6, -2.8), (arg_340_1.time_ - 0) / var_343_4)
				var_343_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_3.position).x, (manager.ui.mainCamera.transform.position - var_343_3.position).y, (manager.ui.mainCamera.transform.position - var_343_3.position).z)
				var_343_3.localEulerAngles.z = 0
				var_343_3.localEulerAngles.x = 0
				var_343_3.localEulerAngles = var_343_3.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				var_343_3.localPosition = Vector3.New(0, -2.6, -2.8)
				var_343_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_3.position).x, (manager.ui.mainCamera.transform.position - var_343_3.position).y, (manager.ui.mainCamera.transform.position - var_343_3.position).z)
				var_343_3.localEulerAngles.z = 0
				var_343_3.localEulerAngles.x = 0
				var_343_3.localEulerAngles = var_343_3.localEulerAngles
			end

			local var_343_5 = arg_340_1.actors_["10083ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.characterEffect10083ui_story == nil then
				arg_340_1.var_.characterEffect10083ui_story = var_343_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_6 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_6 and not isNil(var_343_5) then
				if arg_340_1.var_.characterEffect10083ui_story and not isNil(var_343_5) then
					arg_340_1.var_.characterEffect10083ui_story.fillFlat = false
				end
			end

			if arg_340_1.time_ >= 0 + var_343_6 and arg_340_1.time_ < 0 + var_343_6 + arg_343_0 and not isNil(var_343_5) and arg_340_1.var_.characterEffect10083ui_story then
				arg_340_1.var_.characterEffect10083ui_story.fillFlat = false
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/story10083/story10083action/10083action1_1")
			end

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1:PlayTimeline("10083ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_343_8 = arg_340_1.actors_["10078ui_story"].transform

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.var_.moveOldPos10078ui_story = var_343_8.localPosition
			end

			local var_343_9 = 0.001

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_9 then
				var_343_8.localPosition = Vector3.Lerp(arg_340_1.var_.moveOldPos10078ui_story, Vector3.New(0, 100, 0), (arg_340_1.time_ - 0) / var_343_9)
				var_343_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_8.position).x, (manager.ui.mainCamera.transform.position - var_343_8.position).y, (manager.ui.mainCamera.transform.position - var_343_8.position).z)
				var_343_8.localEulerAngles.z = 0
				var_343_8.localEulerAngles.x = 0
				var_343_8.localEulerAngles = var_343_8.localEulerAngles
			end

			if arg_340_1.time_ >= 0 + var_343_9 and arg_340_1.time_ < 0 + var_343_9 + arg_343_0 then
				var_343_8.localPosition = Vector3.New(0, 100, 0)
				var_343_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_343_8.position).x, (manager.ui.mainCamera.transform.position - var_343_8.position).y, (manager.ui.mainCamera.transform.position - var_343_8.position).z)
				var_343_8.localEulerAngles.z = 0
				var_343_8.localEulerAngles.x = 0
				var_343_8.localEulerAngles = var_343_8.localEulerAngles
			end

			local var_343_10 = arg_340_1.actors_["10078ui_story"]

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(var_343_10) and arg_340_1.var_.characterEffect10078ui_story == nil then
				arg_340_1.var_.characterEffect10078ui_story = var_343_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_11 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_11 and not isNil(var_343_10) then
				if arg_340_1.var_.characterEffect10078ui_story and not isNil(var_343_10) then
					arg_340_1.var_.characterEffect10078ui_story.fillFlat = true
					arg_340_1.var_.characterEffect10078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_11)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_11 and arg_340_1.time_ < 0 + var_343_11 + arg_343_0 and not isNil(var_343_10) and arg_340_1.var_.characterEffect10078ui_story then
				arg_340_1.var_.characterEffect10078ui_story.fillFlat = true
				arg_340_1.var_.characterEffect10078ui_story.fillRatio = 0.5
			end

			local var_343_12 = 0
			local var_343_13 = 0.425

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_12 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[918].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_14 = arg_340_1:GetWordFromCfg(412102083)
				local var_343_15 = arg_340_1:FormatText(var_343_14.content)

				arg_340_1.text_.text = var_343_15

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_17 = 17 <= 0 and var_343_13 or var_343_13 * (utf8.len(var_343_15) / 17)

				if (17 <= 0 and var_343_13 or var_343_13 * (utf8.len(var_343_15) / 17)) > 0 and var_343_13 < var_343_17 then
					arg_340_1.talkMaxDuration = var_343_17

					if var_343_17 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_17 + var_343_12
					end
				end

				arg_340_1.text_.text = var_343_15
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102083", "story_v_out_412102.awb") ~= 0 then
					local var_343_18 = manager.audio:GetVoiceLength("story_v_out_412102", "412102083", "story_v_out_412102.awb") / 1000

					if var_343_18 + var_343_12 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_18 + var_343_12
					end

					if var_343_14.prefab_name ~= "" and arg_340_1.actors_[var_343_14.prefab_name] ~= nil then
						local var_343_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_14.prefab_name].transform, "story_v_out_412102", "412102083", "story_v_out_412102.awb")

						arg_340_1:RecordAudio("412102083", var_343_19)
						arg_340_1:RecordAudio("412102083", var_343_19)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_412102", "412102083", "story_v_out_412102.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_412102", "412102083", "story_v_out_412102.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_20 = math.max(var_343_13, arg_340_1.talkMaxDuration)

			if var_343_12 <= arg_340_1.time_ and arg_340_1.time_ < var_343_12 + var_343_20 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_12) / var_343_20

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_12 + var_343_20 and arg_340_1.time_ < var_343_12 + var_343_20 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_340_1:InitPlayNodeList()
	end,
	Play412102084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 412102084
		arg_344_1.duration_ = 3.67

		local var_344_0 = {
			zh = 3.632999999999,
			ja = 3.665999999999
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play412102085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				local var_347_0 = arg_344_1.bgs_.STwhite

				arg_344_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_347_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_347_1 = var_347_0:GetComponent("SpriteRenderer")

				if var_347_1 and var_347_1.sprite then
					local var_347_2 = 2 * (var_347_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_347_0.transform.localScale = Vector3.New(var_347_2 / var_347_1.sprite.bounds.size.y < var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x and var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x or var_347_2 / var_347_1.sprite.bounds.size.y, var_347_2 / var_347_1.sprite.bounds.size.y < var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x and var_347_2 * manager.ui.mainCameraCom_.aspect / var_347_1.sprite.bounds.size.x or var_347_2 / var_347_1.sprite.bounds.size.y, 0)
				end

				for iter_347_0, iter_347_1 in pairs(arg_344_1.bgs_) do
					if iter_347_0 ~= "STwhite" then
						iter_347_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_347_3 = 1.999999999999

			if 1.999999999999 < arg_344_1.time_ and arg_344_1.time_ <= var_347_3 + arg_347_0 then
				arg_344_1.allBtn_.enabled = false
			end

			if arg_344_1.time_ >= var_347_3 + 0.3 and arg_344_1.time_ < var_347_3 + 0.3 + arg_347_0 then
				arg_344_1.allBtn_.enabled = true
			end

			local var_347_4 = 0

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.mask_.enabled = true
				arg_344_1.mask_.raycastTarget = true

				arg_344_1:SetGaussion(false)
			end

			local var_347_5 = 2

			if var_347_4 <= arg_344_1.time_ and arg_344_1.time_ < var_347_4 + var_347_5 then
				local var_347_6 = Color.New(1, 1, 1)

				var_347_6.a = Mathf.Lerp(1, 0, (arg_344_1.time_ - var_347_4) / var_347_5)
				arg_344_1.mask_.color = var_347_6
			end

			if arg_344_1.time_ >= var_347_4 + var_347_5 and arg_344_1.time_ < var_347_4 + var_347_5 + arg_347_0 then
				local var_347_7 = Color.New(1, 1, 1)

				arg_344_1.mask_.enabled = false
				var_347_7.a = 0
				arg_344_1.mask_.color = var_347_7
			end

			local var_347_8 = arg_344_1.actors_["10083ui_story"].transform

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10083ui_story = var_347_8.localPosition
			end

			local var_347_9 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_9 then
				var_347_8.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10083ui_story, Vector3.New(0, 100, 0), (arg_344_1.time_ - 0) / var_347_9)
				var_347_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_347_8.position).x, (manager.ui.mainCamera.transform.position - var_347_8.position).y, (manager.ui.mainCamera.transform.position - var_347_8.position).z)
				var_347_8.localEulerAngles.z = 0
				var_347_8.localEulerAngles.x = 0
				var_347_8.localEulerAngles = var_347_8.localEulerAngles
			end

			if arg_344_1.time_ >= 0 + var_347_9 and arg_344_1.time_ < 0 + var_347_9 + arg_347_0 then
				var_347_8.localPosition = Vector3.New(0, 100, 0)
				var_347_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_347_8.position).x, (manager.ui.mainCamera.transform.position - var_347_8.position).y, (manager.ui.mainCamera.transform.position - var_347_8.position).z)
				var_347_8.localEulerAngles.z = 0
				var_347_8.localEulerAngles.x = 0
				var_347_8.localEulerAngles = var_347_8.localEulerAngles
			end

			local var_347_10 = arg_344_1.actors_["10083ui_story"]

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 and not isNil(var_347_10) and arg_344_1.var_.characterEffect10083ui_story == nil then
				arg_344_1.var_.characterEffect10083ui_story = var_347_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_347_11 = 0.034000001847744

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_11 and not isNil(var_347_10) then
				if arg_344_1.var_.characterEffect10083ui_story and not isNil(var_347_10) then
					arg_344_1.var_.characterEffect10083ui_story.fillFlat = true
					arg_344_1.var_.characterEffect10083ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_344_1.time_ - 0) / var_347_11)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_11 and arg_344_1.time_ < 0 + var_347_11 + arg_347_0 and not isNil(var_347_10) and arg_344_1.var_.characterEffect10083ui_story then
				arg_344_1.var_.characterEffect10083ui_story.fillFlat = true
				arg_344_1.var_.characterEffect10083ui_story.fillRatio = 0.5
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_347_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_344_1.bgmTxt_.text ~= var_347_14 and arg_344_1.bgmTxt_.text ~= "" then
						if arg_344_1.bgmTxt2_.text ~= "" then
							arg_344_1.bgmTxt_.text = arg_344_1.bgmTxt2_.text
						end

						arg_344_1.bgmTxt2_.text = var_347_14

						arg_344_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_344_1.bgmTxt_.text = var_347_14
						arg_344_1.bgmTxt2_.text = var_347_14
					end

					if arg_344_1.bgmTimer then
						arg_344_1.bgmTimer:Stop()

						arg_344_1.bgmTimer = nil
					end

					if arg_344_1.settingData.show_music_name == 1 then
						arg_344_1.musicController:SetSelectedState("show")
						arg_344_1.musicAnimator_:Play("open", 0, 0)

						if arg_344_1.settingData.music_time ~= 0 then
							arg_344_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_344_1.settingData.music_time), function()
								if arg_344_1 == nil or isNil(arg_344_1.bgmTxt_) then
									return
								end

								arg_344_1.musicController:SetSelectedState("hide")
								arg_344_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_344_1.frameCnt_ <= 1 then
				arg_344_1.dialog_:SetActive(false)
			end

			local var_347_15 = 1.999999999999
			local var_347_16 = 0.225

			if 1.999999999999 < arg_344_1.time_ and arg_344_1.time_ <= var_347_15 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0

				arg_344_1.dialog_:SetActive(true)

				arg_344_1.dialogCg_.alpha = 0

				local var_347_17 = LeanTween.value(arg_344_1.dialog_, 0, 1, 0.3)

				var_347_17:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_344_1.dialogCg_.alpha = arg_349_0
				end))
				var_347_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_344_1.dialog_)
					var_347_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_344_1.duration_ = arg_344_1.duration_ + 0.3

				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_18 = arg_344_1:GetWordFromCfg(412102084)
				local var_347_19 = arg_344_1:FormatText(var_347_18.content)

				arg_344_1.text_.text = var_347_19

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_21 = 9 <= 0 and var_347_16 or var_347_16 * (utf8.len(var_347_19) / 9)

				if (9 <= 0 and var_347_16 or var_347_16 * (utf8.len(var_347_19) / 9)) > 0 and var_347_16 < var_347_21 then
					arg_344_1.talkMaxDuration = var_347_21
					var_347_15 = var_347_15 + 0.3

					if var_347_21 + var_347_15 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_21 + var_347_15
					end
				end

				arg_344_1.text_.text = var_347_19
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102084", "story_v_out_412102.awb") ~= 0 then
					local var_347_22 = manager.audio:GetVoiceLength("story_v_out_412102", "412102084", "story_v_out_412102.awb") / 1000

					if var_347_22 + var_347_15 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_22 + var_347_15
					end

					if var_347_18.prefab_name ~= "" and arg_344_1.actors_[var_347_18.prefab_name] ~= nil then
						local var_347_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_18.prefab_name].transform, "story_v_out_412102", "412102084", "story_v_out_412102.awb")

						arg_344_1:RecordAudio("412102084", var_347_23)
						arg_344_1:RecordAudio("412102084", var_347_23)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_412102", "412102084", "story_v_out_412102.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_412102", "412102084", "story_v_out_412102.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_24 = var_347_15 + 0.3
			local var_347_25 = math.max(var_347_16, arg_344_1.talkMaxDuration)

			if var_347_15 + 0.3 <= arg_344_1.time_ and arg_344_1.time_ < var_347_24 + var_347_25 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_24) / var_347_25

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_24 + var_347_25 and arg_344_1.time_ < var_347_24 + var_347_25 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10083ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play412102085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 412102085
		arg_351_1.duration_ = 5.1

		local var_351_0 = {
			zh = 4.265999999999,
			ja = 5.099999999999
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play412102086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if arg_351_1.bgs_.EN0107 == nil then
				local var_354_0 = Object.Instantiate(arg_351_1.paintGo_)

				var_354_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "EN0107")
				var_354_0.name = "EN0107"
				var_354_0.transform.parent = arg_351_1.stage_.transform
				var_354_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_351_1.bgs_.EN0107 = var_354_0
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				local var_354_1 = arg_351_1.bgs_.EN0107

				arg_351_1.bgs_.EN0107.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_354_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_354_2 = var_354_1:GetComponent("SpriteRenderer")

				if var_354_2 and var_354_2.sprite then
					local var_354_3 = 2 * (var_354_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_354_1.transform.localScale = Vector3.New(var_354_3 / var_354_2.sprite.bounds.size.y < var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x and var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x or var_354_3 / var_354_2.sprite.bounds.size.y, var_354_3 / var_354_2.sprite.bounds.size.y < var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x and var_354_3 * manager.ui.mainCameraCom_.aspect / var_354_2.sprite.bounds.size.x or var_354_3 / var_354_2.sprite.bounds.size.y, 0)
				end

				for iter_354_0, iter_354_1 in pairs(arg_351_1.bgs_) do
					if iter_354_0 ~= "EN0107" then
						iter_354_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_354_4 = 1.999999999999

			if 1.999999999999 < arg_351_1.time_ and arg_351_1.time_ <= var_354_4 + arg_354_0 then
				arg_351_1.allBtn_.enabled = false
			end

			if arg_351_1.time_ >= var_354_4 + 0.3 and arg_351_1.time_ < var_354_4 + 0.3 + arg_354_0 then
				arg_351_1.allBtn_.enabled = true
			end

			local var_354_5 = 0

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_5 + arg_354_0 then
				arg_351_1.mask_.enabled = true
				arg_351_1.mask_.raycastTarget = true

				arg_351_1:SetGaussion(false)
			end

			local var_354_6 = 2

			if var_354_5 <= arg_351_1.time_ and arg_351_1.time_ < var_354_5 + var_354_6 then
				local var_354_7 = Color.New(0, 0, 0)

				var_354_7.a = Mathf.Lerp(1, 0, (arg_351_1.time_ - var_354_5) / var_354_6)
				arg_351_1.mask_.color = var_354_7
			end

			if arg_351_1.time_ >= var_354_5 + var_354_6 and arg_351_1.time_ < var_354_5 + var_354_6 + arg_354_0 then
				local var_354_8 = Color.New(0, 0, 0)

				arg_351_1.mask_.enabled = false
				var_354_8.a = 0
				arg_351_1.mask_.color = var_354_8
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_354_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_351_1.bgmTxt_.text ~= var_354_11 and arg_351_1.bgmTxt_.text ~= "" then
						if arg_351_1.bgmTxt2_.text ~= "" then
							arg_351_1.bgmTxt_.text = arg_351_1.bgmTxt2_.text
						end

						arg_351_1.bgmTxt2_.text = var_354_11

						arg_351_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_351_1.bgmTxt_.text = var_354_11
						arg_351_1.bgmTxt2_.text = var_354_11
					end

					if arg_351_1.bgmTimer then
						arg_351_1.bgmTimer:Stop()

						arg_351_1.bgmTimer = nil
					end

					if arg_351_1.settingData.show_music_name == 1 then
						arg_351_1.musicController:SetSelectedState("show")
						arg_351_1.musicAnimator_:Play("open", 0, 0)

						if arg_351_1.settingData.music_time ~= 0 then
							arg_351_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_351_1.settingData.music_time), function()
								if arg_351_1 == nil or isNil(arg_351_1.bgmTxt_) then
									return
								end

								arg_351_1.musicController:SetSelectedState("hide")
								arg_351_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.266666666666667 < arg_351_1.time_ and arg_351_1.time_ <= 0.266666666666667 + arg_354_0 then
				arg_351_1:AudioAction("play", "music", "bgm_activity_3_2_ui", "bgm_activity_3_2_ui", "bgm_activity_3_2_ui.awb")

				local var_354_14 = manager.audio:GetAudioName("bgm_activity_3_2_ui", "bgm_activity_3_2_ui")

				if "" ~= "" then
					if arg_351_1.bgmTxt_.text ~= var_354_14 and arg_351_1.bgmTxt_.text ~= "" then
						if arg_351_1.bgmTxt2_.text ~= "" then
							arg_351_1.bgmTxt_.text = arg_351_1.bgmTxt2_.text
						end

						arg_351_1.bgmTxt2_.text = var_354_14

						arg_351_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_351_1.bgmTxt_.text = var_354_14
						arg_351_1.bgmTxt2_.text = var_354_14
					end

					if arg_351_1.bgmTimer then
						arg_351_1.bgmTimer:Stop()

						arg_351_1.bgmTimer = nil
					end

					if arg_351_1.settingData.show_music_name == 1 then
						arg_351_1.musicController:SetSelectedState("show")
						arg_351_1.musicAnimator_:Play("open", 0, 0)

						if arg_351_1.settingData.music_time ~= 0 then
							arg_351_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_351_1.settingData.music_time), function()
								if arg_351_1 == nil or isNil(arg_351_1.bgmTxt_) then
									return
								end

								arg_351_1.musicController:SetSelectedState("hide")
								arg_351_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_354_15 = arg_351_1.bgs_.EN0107.transform

			if 0.0333333333333333 < arg_351_1.time_ and arg_351_1.time_ <= 0.0333333333333333 + arg_354_0 then
				arg_351_1.var_.moveOldPosEN0107 = var_354_15.localPosition
			end

			local var_354_16 = 0.001

			if 0.0333333333333333 <= arg_351_1.time_ and arg_351_1.time_ < 0.0333333333333333 + var_354_16 then
				var_354_15.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPosEN0107, Vector3.New(-0.5, 0, 2), (arg_351_1.time_ - 0.0333333333333333) / var_354_16)
			end

			if arg_351_1.time_ >= 0.0333333333333333 + var_354_16 and arg_351_1.time_ < 0.0333333333333333 + var_354_16 + arg_354_0 then
				var_354_15.localPosition = Vector3.New(-0.5, 0, 2)
			end

			local var_354_17 = arg_351_1.bgs_.EN0107.transform

			if 0.05 < arg_351_1.time_ and arg_351_1.time_ <= 0.05 + arg_354_0 then
				arg_351_1.var_.moveOldPosEN0107 = var_354_17.localPosition
			end

			local var_354_18 = 3

			if 0.05 <= arg_351_1.time_ and arg_351_1.time_ < 0.05 + var_354_18 then
				var_354_17.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPosEN0107, Vector3.New(-1, 0, 2), (arg_351_1.time_ - 0.05) / var_354_18)
			end

			if arg_351_1.time_ >= 0.05 + var_354_18 and arg_351_1.time_ < 0.05 + var_354_18 + arg_354_0 then
				var_354_17.localPosition = Vector3.New(-1, 0, 2)
			end

			if arg_351_1.frameCnt_ <= 1 then
				arg_351_1.dialog_:SetActive(false)
			end

			local var_354_19 = 1.999999999999
			local var_354_20 = 0.225

			if 1.999999999999 < arg_351_1.time_ and arg_351_1.time_ <= var_354_19 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0

				arg_351_1.dialog_:SetActive(true)

				arg_351_1.dialogCg_.alpha = 0

				local var_354_21 = LeanTween.value(arg_351_1.dialog_, 0, 1, 0.3)

				var_354_21:setOnUpdate(LuaHelper.FloatAction(function(arg_357_0)
					arg_351_1.dialogCg_.alpha = arg_357_0
				end))
				var_354_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_351_1.dialog_)
					var_354_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_351_1.duration_ = arg_351_1.duration_ + 0.3

				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_22 = arg_351_1:GetWordFromCfg(412102085)
				local var_354_23 = arg_351_1:FormatText(var_354_22.content)

				arg_351_1.text_.text = var_354_23

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_25 = 9 <= 0 and var_354_20 or var_354_20 * (utf8.len(var_354_23) / 9)

				if (9 <= 0 and var_354_20 or var_354_20 * (utf8.len(var_354_23) / 9)) > 0 and var_354_20 < var_354_25 then
					arg_351_1.talkMaxDuration = var_354_25
					var_354_19 = var_354_19 + 0.3

					if var_354_25 + var_354_19 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_25 + var_354_19
					end
				end

				arg_351_1.text_.text = var_354_23
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102085", "story_v_out_412102.awb") ~= 0 then
					local var_354_26 = manager.audio:GetVoiceLength("story_v_out_412102", "412102085", "story_v_out_412102.awb") / 1000

					if var_354_26 + var_354_19 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_26 + var_354_19
					end

					if var_354_22.prefab_name ~= "" and arg_351_1.actors_[var_354_22.prefab_name] ~= nil then
						local var_354_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_22.prefab_name].transform, "story_v_out_412102", "412102085", "story_v_out_412102.awb")

						arg_351_1:RecordAudio("412102085", var_354_27)
						arg_351_1:RecordAudio("412102085", var_354_27)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_412102", "412102085", "story_v_out_412102.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_412102", "412102085", "story_v_out_412102.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_28 = var_354_19 + 0.3
			local var_354_29 = math.max(var_354_20, arg_351_1.talkMaxDuration)

			if var_354_19 + 0.3 <= arg_351_1.time_ and arg_351_1.time_ < var_354_28 + var_354_29 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_28) / var_354_29

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_28 + var_354_29 and arg_351_1.time_ < var_354_28 + var_354_29 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0.0333333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 3,
				className = "StoryMoveNode",
				startTime = 0.05,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_351_1:InitPlayNodeList()
	end,
	Play412102086 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 412102086
		arg_359_1.duration_ = 2.5

		local var_359_0 = {
			zh = 2.016666666666,
			ja = 2.5
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play412102087(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				local var_362_0 = arg_359_1.var_.effectxiaokunzhengyan1

				if not arg_359_1.var_.effectxiaokunzhengyan1 then
					var_362_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_scence_pingmu_niuqu"), manager.ui.mainCamera.transform)
					var_362_0.name = "xiaokunzhengyan1"
					arg_359_1.var_.effectxiaokunzhengyan1 = var_362_0
				else
					var_362_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_362_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_362_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.2 < arg_359_1.time_ and arg_359_1.time_ <= 0.2 + arg_362_0 then
				if arg_359_1.var_.effectxiaokunzhengyan1 then
					Object.Destroy(arg_359_1.var_.effectxiaokunzhengyan1)

					arg_359_1.var_.effectxiaokunzhengyan1 = nil
				end
			end

			local var_362_3 = arg_359_1.bgs_.EN0107.transform

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.var_.moveOldPosEN0107 = var_362_3.localPosition
			end

			local var_362_4 = 0.001

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				var_362_3.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPosEN0107, Vector3.New(0, 1, 9.5), (arg_359_1.time_ - 0) / var_362_4)
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				var_362_3.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_362_5 = arg_359_1.bgs_.EN0107.transform

			if 0.0166666666666667 < arg_359_1.time_ and arg_359_1.time_ <= 0.0166666666666667 + arg_362_0 then
				arg_359_1.var_.moveOldPosEN0107 = var_362_5.localPosition
			end

			local var_362_6 = 2

			if 0.0166666666666667 <= arg_359_1.time_ and arg_359_1.time_ < 0.0166666666666667 + var_362_6 then
				var_362_5.localPosition = Vector3.Lerp(arg_359_1.var_.moveOldPosEN0107, Vector3.New(0, 1, 10), (arg_359_1.time_ - 0.0166666666666667) / var_362_6)
			end

			if arg_359_1.time_ >= 0.0166666666666667 + var_362_6 and arg_359_1.time_ < 0.0166666666666667 + var_362_6 + arg_362_0 then
				var_362_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_362_7 = 0.3

			if 0.3 < arg_359_1.time_ and arg_359_1.time_ <= var_362_7 + arg_362_0 then
				arg_359_1.allBtn_.enabled = false
			end

			if arg_359_1.time_ >= var_362_7 + 1.71666666666667 and arg_359_1.time_ < var_362_7 + 1.71666666666667 + arg_362_0 then
				arg_359_1.allBtn_.enabled = true
			end

			local var_362_8 = 0
			local var_362_9 = 0.175

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_8 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_10 = arg_359_1:GetWordFromCfg(412102086)
				local var_362_11 = arg_359_1:FormatText(var_362_10.content)

				arg_359_1.text_.text = var_362_11

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_13 = 7 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 7)

				if (7 <= 0 and var_362_9 or var_362_9 * (utf8.len(var_362_11) / 7)) > 0 and var_362_9 < var_362_13 then
					arg_359_1.talkMaxDuration = var_362_13

					if var_362_13 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_13 + var_362_8
					end
				end

				arg_359_1.text_.text = var_362_11
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102086", "story_v_out_412102.awb") ~= 0 then
					local var_362_14 = manager.audio:GetVoiceLength("story_v_out_412102", "412102086", "story_v_out_412102.awb") / 1000

					if var_362_14 + var_362_8 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_14 + var_362_8
					end

					if var_362_10.prefab_name ~= "" and arg_359_1.actors_[var_362_10.prefab_name] ~= nil then
						local var_362_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_10.prefab_name].transform, "story_v_out_412102", "412102086", "story_v_out_412102.awb")

						arg_359_1:RecordAudio("412102086", var_362_15)
						arg_359_1:RecordAudio("412102086", var_362_15)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_412102", "412102086", "story_v_out_412102.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_412102", "412102086", "story_v_out_412102.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_16 = math.max(var_362_9, arg_359_1.talkMaxDuration)

			if var_362_8 <= arg_359_1.time_ and arg_359_1.time_ < var_362_8 + var_362_16 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_8) / var_362_16

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_8 + var_362_16 and arg_359_1.time_ < var_362_8 + var_362_16 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "EN0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "EN0107",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_359_1:InitPlayNodeList()
	end,
	Play412102087 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 412102087
		arg_363_1.duration_ = 5

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play412102088(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				local var_366_0 = arg_363_1.var_.effectxiaokunzhengyan1

				if not arg_363_1.var_.effectxiaokunzhengyan1 then
					var_366_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_366_0.name = "xiaokunzhengyan1"
					arg_363_1.var_.effectxiaokunzhengyan1 = var_366_0
				else
					var_366_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_366_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_366_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_366_2 = 0
			local var_366_3 = 0.425

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_2 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, false)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_4 = arg_363_1:FormatText(arg_363_1:GetWordFromCfg(412102087).content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_6 = 17 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_4) / 17)

				if (17 <= 0 and var_366_3 or var_366_3 * (utf8.len(var_366_4) / 17)) > 0 and var_366_3 < var_366_6 then
					arg_363_1.talkMaxDuration = var_366_6

					if var_366_6 + var_366_2 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_6 + var_366_2
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)
				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_3, arg_363_1.talkMaxDuration)

			if var_366_2 <= arg_363_1.time_ and arg_363_1.time_ < var_366_2 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_2) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_2 + var_366_7 and arg_363_1.time_ < var_366_2 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play412102088 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 412102088
		arg_367_1.duration_ = 5

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play412102089(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.7

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, false)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:FormatText(arg_367_1:GetWordFromCfg(412102088).content)

				arg_367_1.text_.text = var_370_1

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_3 = 28 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 28)

				if (28 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_1) / 28)) > 0 and var_370_0 < var_370_3 then
					arg_367_1.talkMaxDuration = var_370_3

					if var_370_3 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_3 + 0
					end
				end

				arg_367_1.text_.text = var_370_1
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)
				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_4 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_4 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_4

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_4 and arg_367_1.time_ < 0 + var_370_4 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play412102089 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 412102089
		arg_371_1.duration_ = 5

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play412102090(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = 0.425

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, false)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_1 = arg_371_1:FormatText(arg_371_1:GetWordFromCfg(412102089).content)

				arg_371_1.text_.text = var_374_1

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_3 = 17 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 17)

				if (17 <= 0 and var_374_0 or var_374_0 * (utf8.len(var_374_1) / 17)) > 0 and var_374_0 < var_374_3 then
					arg_371_1.talkMaxDuration = var_374_3

					if var_374_3 + 0 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_3 + 0
					end
				end

				arg_371_1.text_.text = var_374_1
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)
				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_4 = math.max(var_374_0, arg_371_1.talkMaxDuration)

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_4 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - 0) / var_374_4

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= 0 + var_374_4 and arg_371_1.time_ < 0 + var_374_4 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play412102090 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 412102090
		arg_375_1.duration_ = 4.23

		local var_375_0 = {
			zh = 4.166,
			ja = 4.233
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play412102091(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = 0.5

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_1 = arg_375_1:GetWordFromCfg(412102090)
				local var_378_2 = arg_375_1:FormatText(var_378_1.content)

				arg_375_1.text_.text = var_378_2

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_4 = 20 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 20)

				if (20 <= 0 and var_378_0 or var_378_0 * (utf8.len(var_378_2) / 20)) > 0 and var_378_0 < var_378_4 then
					arg_375_1.talkMaxDuration = var_378_4

					if var_378_4 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_4 + 0
					end
				end

				arg_375_1.text_.text = var_378_2
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102090", "story_v_out_412102.awb") ~= 0 then
					local var_378_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102090", "story_v_out_412102.awb") / 1000

					if var_378_5 + 0 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_5 + 0
					end

					if var_378_1.prefab_name ~= "" and arg_375_1.actors_[var_378_1.prefab_name] ~= nil then
						local var_378_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_1.prefab_name].transform, "story_v_out_412102", "412102090", "story_v_out_412102.awb")

						arg_375_1:RecordAudio("412102090", var_378_6)
						arg_375_1:RecordAudio("412102090", var_378_6)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_412102", "412102090", "story_v_out_412102.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_412102", "412102090", "story_v_out_412102.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_7 = math.max(var_378_0, arg_375_1.talkMaxDuration)

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_7 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - 0) / var_378_7

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= 0 + var_378_7 and arg_375_1.time_ < 0 + var_378_7 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play412102091 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 412102091
		arg_379_1.duration_ = 8.4

		local var_379_0 = {
			zh = 6.5,
			ja = 8.4
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play412102092(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0.75

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= 0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				arg_379_1.leftNameTxt_.text = arg_379_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_1 = arg_379_1:GetWordFromCfg(412102091)
				local var_382_2 = arg_379_1:FormatText(var_382_1.content)

				arg_379_1.text_.text = var_382_2

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_4 = 30 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 30)

				if (30 <= 0 and var_382_0 or var_382_0 * (utf8.len(var_382_2) / 30)) > 0 and var_382_0 < var_382_4 then
					arg_379_1.talkMaxDuration = var_382_4

					if var_382_4 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_4 + 0
					end
				end

				arg_379_1.text_.text = var_382_2
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102091", "story_v_out_412102.awb") ~= 0 then
					local var_382_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102091", "story_v_out_412102.awb") / 1000

					if var_382_5 + 0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_5 + 0
					end

					if var_382_1.prefab_name ~= "" and arg_379_1.actors_[var_382_1.prefab_name] ~= nil then
						local var_382_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_1.prefab_name].transform, "story_v_out_412102", "412102091", "story_v_out_412102.awb")

						arg_379_1:RecordAudio("412102091", var_382_6)
						arg_379_1:RecordAudio("412102091", var_382_6)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_412102", "412102091", "story_v_out_412102.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_412102", "412102091", "story_v_out_412102.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_7 = math.max(var_382_0, arg_379_1.talkMaxDuration)

			if 0 <= arg_379_1.time_ and arg_379_1.time_ < 0 + var_382_7 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - 0) / var_382_7

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= 0 + var_382_7 and arg_379_1.time_ < 0 + var_382_7 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {}

		arg_379_1:InitPlayNodeList()
	end,
	Play412102092 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 412102092
		arg_383_1.duration_ = 4.1

		local var_383_0 = {
			zh = 3.333,
			ja = 4.1
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play412102093(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			if 0 < arg_383_1.time_ and arg_383_1.time_ <= 0 + arg_386_0 then
				local var_386_0 = arg_383_1.bgs_.ST30a

				arg_383_1.bgs_.ST30a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_386_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_386_1 = var_386_0:GetComponent("SpriteRenderer")

				if var_386_1 and var_386_1.sprite then
					local var_386_2 = 2 * (var_386_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_386_0.transform.localScale = Vector3.New(var_386_2 / var_386_1.sprite.bounds.size.y < var_386_2 * manager.ui.mainCameraCom_.aspect / var_386_1.sprite.bounds.size.x and var_386_2 * manager.ui.mainCameraCom_.aspect / var_386_1.sprite.bounds.size.x or var_386_2 / var_386_1.sprite.bounds.size.y, var_386_2 / var_386_1.sprite.bounds.size.y < var_386_2 * manager.ui.mainCameraCom_.aspect / var_386_1.sprite.bounds.size.x and var_386_2 * manager.ui.mainCameraCom_.aspect / var_386_1.sprite.bounds.size.x or var_386_2 / var_386_1.sprite.bounds.size.y, 0)
				end

				for iter_386_0, iter_386_1 in pairs(arg_383_1.bgs_) do
					if iter_386_0 ~= "ST30a" then
						iter_386_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_386_3 = 1.999999999999

			if 1.999999999999 < arg_383_1.time_ and arg_383_1.time_ <= var_386_3 + arg_386_0 then
				arg_383_1.allBtn_.enabled = false
			end

			if arg_383_1.time_ >= var_386_3 + 0.3 and arg_383_1.time_ < var_386_3 + 0.3 + arg_386_0 then
				arg_383_1.allBtn_.enabled = true
			end

			local var_386_4 = 0

			if 0 < arg_383_1.time_ and arg_383_1.time_ <= var_386_4 + arg_386_0 then
				arg_383_1.mask_.enabled = true
				arg_383_1.mask_.raycastTarget = true

				arg_383_1:SetGaussion(false)
			end

			local var_386_5 = 2

			if var_386_4 <= arg_383_1.time_ and arg_383_1.time_ < var_386_4 + var_386_5 then
				local var_386_6 = Color.New(1, 1, 1)

				var_386_6.a = Mathf.Lerp(1, 0, (arg_383_1.time_ - var_386_4) / var_386_5)
				arg_383_1.mask_.color = var_386_6
			end

			if arg_383_1.time_ >= var_386_4 + var_386_5 and arg_383_1.time_ < var_386_4 + var_386_5 + arg_386_0 then
				local var_386_7 = Color.New(1, 1, 1)

				arg_383_1.mask_.enabled = false
				var_386_7.a = 0
				arg_383_1.mask_.color = var_386_7
			end

			if arg_383_1.frameCnt_ <= 1 then
				arg_383_1.dialog_:SetActive(false)
			end

			local var_386_8 = 2
			local var_386_9 = 0.35

			if 2 < arg_383_1.time_ and arg_383_1.time_ <= var_386_8 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0

				arg_383_1.dialog_:SetActive(true)

				arg_383_1.dialogCg_.alpha = 0

				local var_386_10 = LeanTween.value(arg_383_1.dialog_, 0, 1, 0.3)

				var_386_10:setOnUpdate(LuaHelper.FloatAction(function(arg_387_0)
					arg_383_1.dialogCg_.alpha = arg_387_0
				end))
				var_386_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_383_1.dialog_)
					var_386_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_383_1.duration_ = arg_383_1.duration_ + 0.3

				SetActive(arg_383_1.leftNameGo_, true)

				arg_383_1.leftNameTxt_.text = arg_383_1:FormatText(StoryNameCfg[913].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1097_sheep")

				arg_383_1.callingController_:SetSelectedState("normal")

				arg_383_1.keyicon_.color = Color.New(1, 1, 1)
				arg_383_1.icon_.color = Color.New(1, 1, 1)

				local var_386_11 = arg_383_1:GetWordFromCfg(412102092)
				local var_386_12 = arg_383_1:FormatText(var_386_11.content)

				arg_383_1.text_.text = var_386_12

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_14 = 14 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_12) / 14)

				if (14 <= 0 and var_386_9 or var_386_9 * (utf8.len(var_386_12) / 14)) > 0 and var_386_9 < var_386_14 then
					arg_383_1.talkMaxDuration = var_386_14
					var_386_8 = var_386_8 + 0.3

					if var_386_14 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_8
					end
				end

				arg_383_1.text_.text = var_386_12
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102092", "story_v_out_412102.awb") ~= 0 then
					local var_386_15 = manager.audio:GetVoiceLength("story_v_out_412102", "412102092", "story_v_out_412102.awb") / 1000

					if var_386_15 + var_386_8 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_15 + var_386_8
					end

					if var_386_11.prefab_name ~= "" and arg_383_1.actors_[var_386_11.prefab_name] ~= nil then
						local var_386_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_11.prefab_name].transform, "story_v_out_412102", "412102092", "story_v_out_412102.awb")

						arg_383_1:RecordAudio("412102092", var_386_16)
						arg_383_1:RecordAudio("412102092", var_386_16)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_412102", "412102092", "story_v_out_412102.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_412102", "412102092", "story_v_out_412102.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_17 = var_386_8 + 0.3
			local var_386_18 = math.max(var_386_9, arg_383_1.talkMaxDuration)

			if var_386_8 + 0.3 <= arg_383_1.time_ and arg_383_1.time_ < var_386_17 + var_386_18 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_17) / var_386_18

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_17 + var_386_18 and arg_383_1.time_ < var_386_17 + var_386_18 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end

		arg_383_1.nodeConfigList_ = {}

		arg_383_1:InitPlayNodeList()
	end,
	Play412102093 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 412102093
		arg_389_1.duration_ = 5.73

		local var_389_0 = {
			zh = 3.166,
			ja = 5.733
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play412102094(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.var_.moveOldPos1197ui_story = arg_389_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_392_0 = 0.001

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 then
				arg_389_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_389_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_389_1.time_ - 0) / var_392_0)
				arg_389_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1197ui_story"].transform.position).z)
				arg_389_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1197ui_story"].transform.localEulerAngles = arg_389_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 then
				arg_389_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_389_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_389_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_389_1.actors_["1197ui_story"].transform.position).z)
				arg_389_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_389_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_389_1.actors_["1197ui_story"].transform.localEulerAngles = arg_389_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_392_1 = arg_389_1.actors_["1197ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1197ui_story == nil then
				arg_389_1.var_.characterEffect1197ui_story = var_392_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_2 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_2 and not isNil(var_392_1) then
				if arg_389_1.var_.characterEffect1197ui_story and not isNil(var_392_1) then
					arg_389_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_2 and arg_389_1.time_ < 0 + var_392_2 + arg_392_0 and not isNil(var_392_1) and arg_389_1.var_.characterEffect1197ui_story then
				arg_389_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_392_4 = 0
			local var_392_5 = 0.3

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_6 = arg_389_1:GetWordFromCfg(412102093)
				local var_392_7 = arg_389_1:FormatText(var_392_6.content)

				arg_389_1.text_.text = var_392_7

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_9 = 12 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 12)

				if (12 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_7) / 12)) > 0 and var_392_5 < var_392_9 then
					arg_389_1.talkMaxDuration = var_392_9

					if var_392_9 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_9 + var_392_4
					end
				end

				arg_389_1.text_.text = var_392_7
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102093", "story_v_out_412102.awb") ~= 0 then
					local var_392_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102093", "story_v_out_412102.awb") / 1000

					if var_392_10 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_4
					end

					if var_392_6.prefab_name ~= "" and arg_389_1.actors_[var_392_6.prefab_name] ~= nil then
						local var_392_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_6.prefab_name].transform, "story_v_out_412102", "412102093", "story_v_out_412102.awb")

						arg_389_1:RecordAudio("412102093", var_392_11)
						arg_389_1:RecordAudio("412102093", var_392_11)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_412102", "412102093", "story_v_out_412102.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_412102", "412102093", "story_v_out_412102.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_12 = math.max(var_392_5, arg_389_1.talkMaxDuration)

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_12 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_4) / var_392_12

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_4 + var_392_12 and arg_389_1.time_ < var_392_4 + var_392_12 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_389_1:InitPlayNodeList()
	end,
	Play412102094 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 412102094
		arg_393_1.duration_ = 10

		local var_393_0 = {
			zh = 8.1,
			ja = 10
		}
		local var_393_1 = manager.audio:GetLocalizationFlag()

		if var_393_0[var_393_1] ~= nil then
			arg_393_1.duration_ = var_393_0[var_393_1]
		end

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play412102095(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			local var_396_0 = 0.85

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_1 = arg_393_1:GetWordFromCfg(412102094)
				local var_396_2 = arg_393_1:FormatText(var_396_1.content)

				arg_393_1.text_.text = var_396_2

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_4 = 34 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 34)

				if (34 <= 0 and var_396_0 or var_396_0 * (utf8.len(var_396_2) / 34)) > 0 and var_396_0 < var_396_4 then
					arg_393_1.talkMaxDuration = var_396_4

					if var_396_4 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_4 + 0
					end
				end

				arg_393_1.text_.text = var_396_2
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102094", "story_v_out_412102.awb") ~= 0 then
					local var_396_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102094", "story_v_out_412102.awb") / 1000

					if var_396_5 + 0 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + 0
					end

					if var_396_1.prefab_name ~= "" and arg_393_1.actors_[var_396_1.prefab_name] ~= nil then
						local var_396_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_1.prefab_name].transform, "story_v_out_412102", "412102094", "story_v_out_412102.awb")

						arg_393_1:RecordAudio("412102094", var_396_6)
						arg_393_1:RecordAudio("412102094", var_396_6)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_412102", "412102094", "story_v_out_412102.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_412102", "412102094", "story_v_out_412102.awb")
				end

				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_7 = math.max(var_396_0, arg_393_1.talkMaxDuration)

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_7 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - 0) / var_396_7

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= 0 + var_396_7 and arg_393_1.time_ < 0 + var_396_7 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play412102095 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 412102095
		arg_397_1.duration_ = 11.57

		local var_397_0 = {
			zh = 6.566,
			ja = 11.566
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play412102096(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1197ui_story = arg_397_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_400_0 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 then
				arg_397_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_397_1.time_ - 0) / var_400_0)
				arg_397_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1197ui_story"].transform.position).z)
				arg_397_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1197ui_story"].transform.localEulerAngles = arg_397_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 then
				arg_397_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, -0.545, -6.3)
				arg_397_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1197ui_story"].transform.position).z)
				arg_397_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1197ui_story"].transform.localEulerAngles = arg_397_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_400_1 = arg_397_1.actors_["1197ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1197ui_story == nil then
				arg_397_1.var_.characterEffect1197ui_story = var_400_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 and not isNil(var_400_1) then
				if arg_397_1.var_.characterEffect1197ui_story and not isNil(var_400_1) then
					arg_397_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1197ui_story then
				arg_397_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_2")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_4 = 0
			local var_400_5 = 0.725

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_4 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_6 = arg_397_1:GetWordFromCfg(412102095)
				local var_400_7 = arg_397_1:FormatText(var_400_6.content)

				arg_397_1.text_.text = var_400_7

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_9 = 29 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 29)

				if (29 <= 0 and var_400_5 or var_400_5 * (utf8.len(var_400_7) / 29)) > 0 and var_400_5 < var_400_9 then
					arg_397_1.talkMaxDuration = var_400_9

					if var_400_9 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_9 + var_400_4
					end
				end

				arg_397_1.text_.text = var_400_7
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102095", "story_v_out_412102.awb") ~= 0 then
					local var_400_10 = manager.audio:GetVoiceLength("story_v_out_412102", "412102095", "story_v_out_412102.awb") / 1000

					if var_400_10 + var_400_4 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_10 + var_400_4
					end

					if var_400_6.prefab_name ~= "" and arg_397_1.actors_[var_400_6.prefab_name] ~= nil then
						local var_400_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_6.prefab_name].transform, "story_v_out_412102", "412102095", "story_v_out_412102.awb")

						arg_397_1:RecordAudio("412102095", var_400_11)
						arg_397_1:RecordAudio("412102095", var_400_11)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_412102", "412102095", "story_v_out_412102.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_412102", "412102095", "story_v_out_412102.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_12 = math.max(var_400_5, arg_397_1.talkMaxDuration)

			if var_400_4 <= arg_397_1.time_ and arg_397_1.time_ < var_400_4 + var_400_12 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_4) / var_400_12

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_4 + var_400_12 and arg_397_1.time_ < var_400_4 + var_400_12 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play412102096 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 412102096
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play412102097(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.moveOldPos1197ui_story = arg_401_1.actors_["1197ui_story"].transform.localPosition
			end

			local var_404_0 = 0.001

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_0 then
				arg_401_1.actors_["1197ui_story"].transform.localPosition = Vector3.Lerp(arg_401_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_401_1.time_ - 0) / var_404_0)
				arg_401_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).z)
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles = arg_401_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			if arg_401_1.time_ >= 0 + var_404_0 and arg_401_1.time_ < 0 + var_404_0 + arg_404_0 then
				arg_401_1.actors_["1197ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_401_1.actors_["1197ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_401_1.actors_["1197ui_story"].transform.position).z)
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.z = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles.x = 0
				arg_401_1.actors_["1197ui_story"].transform.localEulerAngles = arg_401_1.actors_["1197ui_story"].transform.localEulerAngles
			end

			local var_404_1 = arg_401_1.actors_["1197ui_story"]

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1197ui_story == nil then
				arg_401_1.var_.characterEffect1197ui_story = var_404_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_404_2 = 0.200000002980232

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_2 and not isNil(var_404_1) then
				if arg_401_1.var_.characterEffect1197ui_story and not isNil(var_404_1) then
					arg_401_1.var_.characterEffect1197ui_story.fillFlat = true
					arg_401_1.var_.characterEffect1197ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_401_1.time_ - 0) / var_404_2)
				end
			end

			if arg_401_1.time_ >= 0 + var_404_2 and arg_401_1.time_ < 0 + var_404_2 + arg_404_0 and not isNil(var_404_1) and arg_401_1.var_.characterEffect1197ui_story then
				arg_401_1.var_.characterEffect1197ui_story.fillFlat = true
				arg_401_1.var_.characterEffect1197ui_story.fillRatio = 0.5
			end

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door_break02", "")
			end

			local var_404_4 = manager.ui.mainCamera.transform

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.var_.shakeOldPos = var_404_4.localPosition
			end

			local var_404_5 = 0.6

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_5 then
				local var_404_6, var_404_7 = math.modf((arg_401_1.time_ - 0) / 0.066)

				var_404_4.localPosition = Vector3.New(var_404_7 * 0.13, var_404_7 * 0.13, var_404_7 * 0.13) + arg_401_1.var_.shakeOldPos
			end

			if arg_401_1.time_ >= 0 + var_404_5 and arg_401_1.time_ < 0 + var_404_5 + arg_404_0 then
				var_404_4.localPosition = arg_401_1.var_.shakeOldPos
			end

			local var_404_8 = 0

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_8 + arg_404_0 then
				arg_401_1.allBtn_.enabled = false
			end

			if arg_401_1.time_ >= var_404_8 + 0.6 and arg_401_1.time_ < var_404_8 + 0.6 + arg_404_0 then
				arg_401_1.allBtn_.enabled = true
			end

			local var_404_9 = 0
			local var_404_10 = 0.9

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_9 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, false)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_11 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(412102096).content)

				arg_401_1.text_.text = var_404_11

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_13 = 36 <= 0 and var_404_10 or var_404_10 * (utf8.len(var_404_11) / 36)

				if (36 <= 0 and var_404_10 or var_404_10 * (utf8.len(var_404_11) / 36)) > 0 and var_404_10 < var_404_13 then
					arg_401_1.talkMaxDuration = var_404_13

					if var_404_13 + var_404_9 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_13 + var_404_9
					end
				end

				arg_401_1.text_.text = var_404_11
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_14 = math.max(var_404_10, arg_401_1.talkMaxDuration)

			if var_404_9 <= arg_401_1.time_ and arg_401_1.time_ < var_404_9 + var_404_14 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_9) / var_404_14

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_9 + var_404_14 and arg_401_1.time_ < var_404_9 + var_404_14 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_401_1:InitPlayNodeList()
	end,
	Play412102097 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 412102097
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play412102098(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 0.75

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, false)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(412102097).content)

				arg_405_1.text_.text = var_408_1

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_3 = 30 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 30)

				if (30 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_1) / 30)) > 0 and var_408_0 < var_408_3 then
					arg_405_1.talkMaxDuration = var_408_3

					if var_408_3 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_3 + 0
					end
				end

				arg_405_1.text_.text = var_408_1
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_4 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_4 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_4

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_4 and arg_405_1.time_ < 0 + var_408_4 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play412102098 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 412102098
		arg_409_1.duration_ = 12

		local var_409_0 = {
			zh = 8.5,
			ja = 12
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play412102099(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 2 < arg_409_1.time_ and arg_409_1.time_ <= 2 + arg_412_0 then
				local var_412_0 = arg_409_1.bgs_.STwhite

				arg_409_1.bgs_.STwhite.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_412_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_412_1 = var_412_0:GetComponent("SpriteRenderer")

				if var_412_1 and var_412_1.sprite then
					local var_412_2 = 2 * (var_412_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_412_0.transform.localScale = Vector3.New(var_412_2 / var_412_1.sprite.bounds.size.y < var_412_2 * manager.ui.mainCameraCom_.aspect / var_412_1.sprite.bounds.size.x and var_412_2 * manager.ui.mainCameraCom_.aspect / var_412_1.sprite.bounds.size.x or var_412_2 / var_412_1.sprite.bounds.size.y, var_412_2 / var_412_1.sprite.bounds.size.y < var_412_2 * manager.ui.mainCameraCom_.aspect / var_412_1.sprite.bounds.size.x and var_412_2 * manager.ui.mainCameraCom_.aspect / var_412_1.sprite.bounds.size.x or var_412_2 / var_412_1.sprite.bounds.size.y, 0)
				end

				for iter_412_0, iter_412_1 in pairs(arg_409_1.bgs_) do
					if iter_412_0 ~= "STwhite" then
						iter_412_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_412_3 = 4

			if 4 < arg_409_1.time_ and arg_409_1.time_ <= var_412_3 + arg_412_0 then
				arg_409_1.allBtn_.enabled = false
			end

			if arg_409_1.time_ >= var_412_3 + 0.3 and arg_409_1.time_ < var_412_3 + 0.3 + arg_412_0 then
				arg_409_1.allBtn_.enabled = true
			end

			local var_412_4 = 0

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_5 = 2

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_5 then
				local var_412_6 = Color.New(0, 0, 0)

				var_412_6.a = Mathf.Lerp(0, 1, (arg_409_1.time_ - var_412_4) / var_412_5)
				arg_409_1.mask_.color = var_412_6
			end

			if arg_409_1.time_ >= var_412_4 + var_412_5 and arg_409_1.time_ < var_412_4 + var_412_5 + arg_412_0 then
				local var_412_7 = Color.New(0, 0, 0)

				var_412_7.a = 1
				arg_409_1.mask_.color = var_412_7
			end

			local var_412_8 = 2

			if 2 < arg_409_1.time_ and arg_409_1.time_ <= var_412_8 + arg_412_0 then
				arg_409_1.mask_.enabled = true
				arg_409_1.mask_.raycastTarget = true

				arg_409_1:SetGaussion(false)
			end

			local var_412_9 = 2

			if var_412_8 <= arg_409_1.time_ and arg_409_1.time_ < var_412_8 + var_412_9 then
				local var_412_10 = Color.New(0, 0, 0)

				var_412_10.a = Mathf.Lerp(1, 0, (arg_409_1.time_ - var_412_8) / var_412_9)
				arg_409_1.mask_.color = var_412_10
			end

			if arg_409_1.time_ >= var_412_8 + var_412_9 and arg_409_1.time_ < var_412_8 + var_412_9 + arg_412_0 then
				local var_412_11 = Color.New(0, 0, 0)

				arg_409_1.mask_.enabled = false
				var_412_11.a = 0
				arg_409_1.mask_.color = var_412_11
			end

			local var_412_12 = arg_409_1.actors_["1197ui_story"].transform

			if 3.8 < arg_409_1.time_ and arg_409_1.time_ <= 3.8 + arg_412_0 then
				arg_409_1.var_.moveOldPos1197ui_story = var_412_12.localPosition
			end

			local var_412_13 = 0.001

			if 3.8 <= arg_409_1.time_ and arg_409_1.time_ < 3.8 + var_412_13 then
				var_412_12.localPosition = Vector3.Lerp(arg_409_1.var_.moveOldPos1197ui_story, Vector3.New(0, -0.545, -6.3), (arg_409_1.time_ - 3.8) / var_412_13)
				var_412_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_12.position).x, (manager.ui.mainCamera.transform.position - var_412_12.position).y, (manager.ui.mainCamera.transform.position - var_412_12.position).z)
				var_412_12.localEulerAngles.z = 0
				var_412_12.localEulerAngles.x = 0
				var_412_12.localEulerAngles = var_412_12.localEulerAngles
			end

			if arg_409_1.time_ >= 3.8 + var_412_13 and arg_409_1.time_ < 3.8 + var_412_13 + arg_412_0 then
				var_412_12.localPosition = Vector3.New(0, -0.545, -6.3)
				var_412_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_412_12.position).x, (manager.ui.mainCamera.transform.position - var_412_12.position).y, (manager.ui.mainCamera.transform.position - var_412_12.position).z)
				var_412_12.localEulerAngles.z = 0
				var_412_12.localEulerAngles.x = 0
				var_412_12.localEulerAngles = var_412_12.localEulerAngles
			end

			local var_412_14 = arg_409_1.actors_["1197ui_story"]

			if 3.8 < arg_409_1.time_ and arg_409_1.time_ <= 3.8 + arg_412_0 and not isNil(var_412_14) and arg_409_1.var_.characterEffect1197ui_story == nil then
				arg_409_1.var_.characterEffect1197ui_story = var_412_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_15 = 0.200000002980232

			if 3.8 <= arg_409_1.time_ and arg_409_1.time_ < 3.8 + var_412_15 and not isNil(var_412_14) then
				if arg_409_1.var_.characterEffect1197ui_story and not isNil(var_412_14) then
					arg_409_1.var_.characterEffect1197ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 3.8 + var_412_15 and arg_409_1.time_ < 3.8 + var_412_15 + arg_412_0 and not isNil(var_412_14) and arg_409_1.var_.characterEffect1197ui_story then
				arg_409_1.var_.characterEffect1197ui_story.fillFlat = false
			end

			if 3.8 < arg_409_1.time_ and arg_409_1.time_ <= 3.8 + arg_412_0 then
				arg_409_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/story1197/story1197action/1197action6_1")
			end

			if 3.8 < arg_409_1.time_ and arg_409_1.time_ <= 3.8 + arg_412_0 then
				arg_409_1:PlayTimeline("1197ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			if arg_409_1.frameCnt_ <= 1 then
				arg_409_1.dialog_:SetActive(false)
			end

			local var_412_17 = 4
			local var_412_18 = 0.45

			if 4 < arg_409_1.time_ and arg_409_1.time_ <= var_412_17 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0

				arg_409_1.dialog_:SetActive(true)

				arg_409_1.dialogCg_.alpha = 0

				local var_412_19 = LeanTween.value(arg_409_1.dialog_, 0, 1, 0.3)

				var_412_19:setOnUpdate(LuaHelper.FloatAction(function(arg_413_0)
					arg_409_1.dialogCg_.alpha = arg_413_0
				end))
				var_412_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_409_1.dialog_)
					var_412_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_409_1.duration_ = arg_409_1.duration_ + 0.3

				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_20 = arg_409_1:GetWordFromCfg(412102098)
				local var_412_21 = arg_409_1:FormatText(var_412_20.content)

				arg_409_1.text_.text = var_412_21

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_23 = 18 <= 0 and var_412_18 or var_412_18 * (utf8.len(var_412_21) / 18)

				if (18 <= 0 and var_412_18 or var_412_18 * (utf8.len(var_412_21) / 18)) > 0 and var_412_18 < var_412_23 then
					arg_409_1.talkMaxDuration = var_412_23
					var_412_17 = var_412_17 + 0.3

					if var_412_23 + var_412_17 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_23 + var_412_17
					end
				end

				arg_409_1.text_.text = var_412_21
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102098", "story_v_out_412102.awb") ~= 0 then
					local var_412_24 = manager.audio:GetVoiceLength("story_v_out_412102", "412102098", "story_v_out_412102.awb") / 1000

					if var_412_24 + var_412_17 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_24 + var_412_17
					end

					if var_412_20.prefab_name ~= "" and arg_409_1.actors_[var_412_20.prefab_name] ~= nil then
						local var_412_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_20.prefab_name].transform, "story_v_out_412102", "412102098", "story_v_out_412102.awb")

						arg_409_1:RecordAudio("412102098", var_412_25)
						arg_409_1:RecordAudio("412102098", var_412_25)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_412102", "412102098", "story_v_out_412102.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_412102", "412102098", "story_v_out_412102.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_26 = var_412_17 + 0.3
			local var_412_27 = math.max(var_412_18, arg_409_1.talkMaxDuration)

			if var_412_17 + 0.3 <= arg_409_1.time_ and arg_409_1.time_ < var_412_26 + var_412_27 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_26) / var_412_27

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_26 + var_412_27 and arg_409_1.time_ < var_412_26 + var_412_27 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_409_1:InitPlayNodeList()
	end,
	Play412102099 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 412102099
		arg_415_1.duration_ = 6.33

		local var_415_0 = {
			zh = 3.066,
			ja = 6.333
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play412102100(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.325

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_1 = arg_415_1:GetWordFromCfg(412102099)
				local var_418_2 = arg_415_1:FormatText(var_418_1.content)

				arg_415_1.text_.text = var_418_2

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_4 = 13 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 13)

				if (13 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_2) / 13)) > 0 and var_418_0 < var_418_4 then
					arg_415_1.talkMaxDuration = var_418_4

					if var_418_4 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_4 + 0
					end
				end

				arg_415_1.text_.text = var_418_2
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_412102", "412102099", "story_v_out_412102.awb") ~= 0 then
					local var_418_5 = manager.audio:GetVoiceLength("story_v_out_412102", "412102099", "story_v_out_412102.awb") / 1000

					if var_418_5 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_5 + 0
					end

					if var_418_1.prefab_name ~= "" and arg_415_1.actors_[var_418_1.prefab_name] ~= nil then
						local var_418_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_1.prefab_name].transform, "story_v_out_412102", "412102099", "story_v_out_412102.awb")

						arg_415_1:RecordAudio("412102099", var_418_6)
						arg_415_1:RecordAudio("412102099", var_418_6)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_412102", "412102099", "story_v_out_412102.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_412102", "412102099", "story_v_out_412102.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_7 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_7 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_7

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_7 and arg_415_1.time_ < 0 + var_418_7 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play412102100 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 412102100
		arg_419_1.duration_ = 5.5

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
			arg_419_1.auto_ = false
		end

		function arg_419_1.playNext_(arg_421_0)
			arg_419_1.onStoryFinished_()
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1:AudioAction("play", "effect", "se_story_side_1199", "se_story_1199_collapse", "")
			end

			local var_422_1 = 0

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_1 + arg_422_0 then
				arg_419_1.mask_.enabled = true
				arg_419_1.mask_.raycastTarget = true

				arg_419_1:SetGaussion(false)
			end

			local var_422_2 = 0.5

			if var_422_1 <= arg_419_1.time_ and arg_419_1.time_ < var_422_1 + var_422_2 then
				local var_422_3 = Color.New(1, 1, 1)

				var_422_3.a = Mathf.Lerp(1, 0, (arg_419_1.time_ - var_422_1) / var_422_2)
				arg_419_1.mask_.color = var_422_3
			end

			if arg_419_1.time_ >= var_422_1 + var_422_2 and arg_419_1.time_ < var_422_1 + var_422_2 + arg_422_0 then
				local var_422_4 = Color.New(1, 1, 1)

				arg_419_1.mask_.enabled = false
				var_422_4.a = 0
				arg_419_1.mask_.color = var_422_4
			end

			local var_422_5 = arg_419_1.actors_["1197ui_story"].transform

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 then
				arg_419_1.var_.moveOldPos1197ui_story = var_422_5.localPosition
			end

			local var_422_6 = 0.001

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_6 then
				var_422_5.localPosition = Vector3.Lerp(arg_419_1.var_.moveOldPos1197ui_story, Vector3.New(0, 100, 0), (arg_419_1.time_ - 0) / var_422_6)
				var_422_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_5.position).x, (manager.ui.mainCamera.transform.position - var_422_5.position).y, (manager.ui.mainCamera.transform.position - var_422_5.position).z)
				var_422_5.localEulerAngles.z = 0
				var_422_5.localEulerAngles.x = 0
				var_422_5.localEulerAngles = var_422_5.localEulerAngles
			end

			if arg_419_1.time_ >= 0 + var_422_6 and arg_419_1.time_ < 0 + var_422_6 + arg_422_0 then
				var_422_5.localPosition = Vector3.New(0, 100, 0)
				var_422_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_422_5.position).x, (manager.ui.mainCamera.transform.position - var_422_5.position).y, (manager.ui.mainCamera.transform.position - var_422_5.position).z)
				var_422_5.localEulerAngles.z = 0
				var_422_5.localEulerAngles.x = 0
				var_422_5.localEulerAngles = var_422_5.localEulerAngles
			end

			if arg_419_1.frameCnt_ <= 1 then
				arg_419_1.dialog_:SetActive(false)
			end

			local var_422_7 = 0.5
			local var_422_8 = 0.6

			if 0.5 < arg_419_1.time_ and arg_419_1.time_ <= var_422_7 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0

				arg_419_1.dialog_:SetActive(true)

				arg_419_1.dialogCg_.alpha = 0

				local var_422_9 = LeanTween.value(arg_419_1.dialog_, 0, 1, 0.3)

				var_422_9:setOnUpdate(LuaHelper.FloatAction(function(arg_423_0)
					arg_419_1.dialogCg_.alpha = arg_423_0
				end))
				var_422_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_419_1.dialog_)
					var_422_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_419_1.duration_ = arg_419_1.duration_ + 0.3

				SetActive(arg_419_1.leftNameGo_, false)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_10 = arg_419_1:FormatText(arg_419_1:GetWordFromCfg(412102100).content)

				arg_419_1.text_.text = var_422_10

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_12 = 24 <= 0 and var_422_8 or var_422_8 * (utf8.len(var_422_10) / 24)

				if (24 <= 0 and var_422_8 or var_422_8 * (utf8.len(var_422_10) / 24)) > 0 and var_422_8 < var_422_12 then
					arg_419_1.talkMaxDuration = var_422_12
					var_422_7 = var_422_7 + 0.3

					if var_422_12 + var_422_7 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_12 + var_422_7
					end
				end

				arg_419_1.text_.text = var_422_10
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)
				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_13 = var_422_7 + 0.3
			local var_422_14 = math.max(var_422_8, arg_419_1.talkMaxDuration)

			if var_422_7 + 0.3 <= arg_419_1.time_ and arg_419_1.time_ < var_422_13 + var_422_14 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_13) / var_422_14

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_13 + var_422_14 and arg_419_1.time_ < var_422_13 + var_422_14 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1197ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_419_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST85b",
		"TextureConfig/Background/ST30a",
		"TextureConfig/Background/STwhite",
		"TextureConfig/Background/EN0107"
	},
	voices = {
		"story_v_out_412102.awb"
	}
}
