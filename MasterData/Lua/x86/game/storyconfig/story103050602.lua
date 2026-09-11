return {
	Play305062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 305062001
		arg_1_1.duration_ = 9.8

		local var_1_0 = {
			zh = 8.6,
			ja = 9.8
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
				arg_1_0:Play305062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.B12 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B12")
				var_4_0.name = "B12"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B12 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B12

				arg_1_1.bgs_.B12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B12" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1111ui_story"

			if arg_1_1.actors_["1111ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1111ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1111ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1111ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1111ui_story == nil then
				arg_1_1.var_.characterEffect1111ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1111ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1111ui_story then
				arg_1_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				local var_4_16 = arg_1_1.var_.effectQWE

				if not arg_1_1.var_.effectQWE then
					var_4_16 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_4_16.name = "QWE"
					arg_1_1.var_.effectQWE = var_4_16
				else
					var_4_16.transform:SetParent(var_4_9000)
				end

				var_4_16.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_16.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_4_16.transform.localScale = Vector3.New(var_4_16.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_4_16.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_4_16.transform.localScale.z)
			end

			if 2.75 < arg_1_1.time_ and arg_1_1.time_ <= 2.75 + arg_4_0 then
				if arg_1_1.var_.effectQWE then
					Object.Destroy(arg_1_1.var_.effectQWE)

					arg_1_1.var_.effectQWE = nil
				end
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_drone_haizhen", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.45

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_27 = arg_1_1:GetWordFromCfg(305062001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 18 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 18)

				if (18 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 18)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062001", "story_v_out_305062.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_305062", "305062001", "story_v_out_305062.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_305062", "305062001", "story_v_out_305062.awb")

						arg_1_1:RecordAudio("305062001", var_4_32)
						arg_1_1:RecordAudio("305062001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_305062", "305062001", "story_v_out_305062.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_305062", "305062001", "story_v_out_305062.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play305062002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 305062002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play305062003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(arg_8_1.actors_["1111ui_story"]) and arg_8_1.var_.characterEffect1111ui_story == nil then
				arg_8_1.var_.characterEffect1111ui_story = arg_8_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_0 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 and not isNil(arg_8_1.actors_["1111ui_story"]) then
				if arg_8_1.var_.characterEffect1111ui_story and not isNil(arg_8_1.actors_["1111ui_story"]) then
					arg_8_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_0)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 and not isNil(arg_8_1.actors_["1111ui_story"]) and arg_8_1.var_.characterEffect1111ui_story then
				arg_8_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_11_1 = 0
			local var_11_2 = 1.275

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(305062002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 51 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 51)

				if (51 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 51)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play305062003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 305062003
		arg_12_1.duration_ = 4.47

		local var_12_0 = {
			zh = 4.466,
			ja = 1.333
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
				arg_12_0:Play305062004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "1084ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["1084ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["1084ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_15_6 = 0
			local var_15_7 = 0.45

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_8 = arg_12_1:GetWordFromCfg(305062003)
				local var_15_9 = arg_12_1:FormatText(var_15_8.content)

				arg_12_1.text_.text = var_15_9

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_11 = 19 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 19)

				if (19 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_9) / 19)) > 0 and var_15_7 < var_15_11 then
					arg_12_1.talkMaxDuration = var_15_11

					if var_15_11 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_9
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062003", "story_v_out_305062.awb") ~= 0 then
					local var_15_12 = manager.audio:GetVoiceLength("story_v_out_305062", "305062003", "story_v_out_305062.awb") / 1000

					if var_15_12 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_12 + var_15_6
					end

					if var_15_8.prefab_name ~= "" and arg_12_1.actors_[var_15_8.prefab_name] ~= nil then
						local var_15_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_8.prefab_name].transform, "story_v_out_305062", "305062003", "story_v_out_305062.awb")

						arg_12_1:RecordAudio("305062003", var_15_13)
						arg_12_1:RecordAudio("305062003", var_15_13)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_305062", "305062003", "story_v_out_305062.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_305062", "305062003", "story_v_out_305062.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_14 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_14 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_14

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_14 and arg_12_1.time_ < var_15_6 + var_15_14 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play305062004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 305062004
		arg_16_1.duration_ = 12.43

		local var_16_0 = {
			zh = 9.5,
			ja = 12.433
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
				arg_16_0:Play305062005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1011ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1011ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1011ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1011ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1011ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_19_8 = 0
			local var_19_9 = 0.925

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_10 = arg_16_1:GetWordFromCfg(305062004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 37 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 37)

				if (37 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 37)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062004", "story_v_out_305062.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_305062", "305062004", "story_v_out_305062.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_305062", "305062004", "story_v_out_305062.awb")

						arg_16_1:RecordAudio("305062004", var_19_15)
						arg_16_1:RecordAudio("305062004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_305062", "305062004", "story_v_out_305062.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_305062", "305062004", "story_v_out_305062.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play305062005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 305062005
		arg_20_1.duration_ = 9.57

		local var_20_0 = {
			zh = 7.733,
			ja = 9.566
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
				arg_20_0:Play305062006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1111ui_story"]) and arg_20_1.var_.characterEffect1111ui_story == nil then
				arg_20_1.var_.characterEffect1111ui_story = arg_20_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1111ui_story"]) then
				if arg_20_1.var_.characterEffect1111ui_story and not isNil(arg_20_1.actors_["1111ui_story"]) then
					arg_20_1.var_.characterEffect1111ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1111ui_story"]) and arg_20_1.var_.characterEffect1111ui_story then
				arg_20_1.var_.characterEffect1111ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1011ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1011ui_story then
				arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_23_4 = 0
			local var_23_5 = 0.5

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_4 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_6 = arg_20_1:GetWordFromCfg(305062005)
				local var_23_7 = arg_20_1:FormatText(var_23_6.content)

				arg_20_1.text_.text = var_23_7

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_9 = 20 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 20)

				if (20 <= 0 and var_23_5 or var_23_5 * (utf8.len(var_23_7) / 20)) > 0 and var_23_5 < var_23_9 then
					arg_20_1.talkMaxDuration = var_23_9

					if var_23_9 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_9 + var_23_4
					end
				end

				arg_20_1.text_.text = var_23_7
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062005", "story_v_out_305062.awb") ~= 0 then
					local var_23_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062005", "story_v_out_305062.awb") / 1000

					if var_23_10 + var_23_4 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_10 + var_23_4
					end

					if var_23_6.prefab_name ~= "" and arg_20_1.actors_[var_23_6.prefab_name] ~= nil then
						local var_23_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_6.prefab_name].transform, "story_v_out_305062", "305062005", "story_v_out_305062.awb")

						arg_20_1:RecordAudio("305062005", var_23_11)
						arg_20_1:RecordAudio("305062005", var_23_11)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_305062", "305062005", "story_v_out_305062.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_305062", "305062005", "story_v_out_305062.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_5, arg_20_1.talkMaxDuration)

			if var_23_4 <= arg_20_1.time_ and arg_20_1.time_ < var_23_4 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_4) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_4 + var_23_12 and arg_20_1.time_ < var_23_4 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "",
				frequency = 8,
				className = "StoryShakeNode",
				duration = 0.833333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.None,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.DIALOG_HEAD,
				offset = Vector3.New(4, 1, 0.1)
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play305062006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 305062006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play305062007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1111ui_story"]) and arg_24_1.var_.characterEffect1111ui_story == nil then
				arg_24_1.var_.characterEffect1111ui_story = arg_24_1.actors_["1111ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1111ui_story"]) then
				if arg_24_1.var_.characterEffect1111ui_story and not isNil(arg_24_1.actors_["1111ui_story"]) then
					arg_24_1.var_.characterEffect1111ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1111ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1111ui_story"]) and arg_24_1.var_.characterEffect1111ui_story then
				arg_24_1.var_.characterEffect1111ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1111ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 1.025

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(305062006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 41 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 41)

				if (41 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 41)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play305062007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 305062007
		arg_28_1.duration_ = 6.75

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play305062008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				local var_31_0 = arg_28_1.var_.effect12333122

				if not arg_28_1.var_.effect12333122 then
					var_31_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_glowmask_white"), manager.ui.mainCamera.transform)
					var_31_0.name = "12333122"
					arg_28_1.var_.effect12333122 = var_31_0
				else
					var_31_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_31_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_31_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_31_0.transform.localScale = Vector3.New(var_31_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_31_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_31_0.transform.localScale.z)
			end

			local var_31_2 = 0

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.allBtn_.enabled = false
			end

			if arg_28_1.time_ >= var_31_2 + 1.96666666666667 and arg_28_1.time_ < var_31_2 + 1.96666666666667 + arg_31_0 then
				arg_28_1.allBtn_.enabled = true
			end

			if arg_28_1.frameCnt_ <= 1 then
				arg_28_1.dialog_:SetActive(false)
			end

			local var_31_3 = 1.75
			local var_31_4 = 0.825

			if 1.75 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0

				arg_28_1.dialog_:SetActive(true)

				arg_28_1.dialogCg_.alpha = 0

				local var_31_5 = LeanTween.value(arg_28_1.dialog_, 0, 1, 0.3)

				var_31_5:setOnUpdate(LuaHelper.FloatAction(function(arg_32_0)
					arg_28_1.dialogCg_.alpha = arg_32_0
				end))
				var_31_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_28_1.dialog_)
					var_31_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_28_1.duration_ = arg_28_1.duration_ + 0.3

				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(305062007).content)

				arg_28_1.text_.text = var_31_6

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_8 = 33 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 33)

				if (33 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_6) / 33)) > 0 and var_31_4 < var_31_8 then
					arg_28_1.talkMaxDuration = var_31_8
					var_31_3 = var_31_3 + 0.3

					if var_31_8 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_6
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_9 = var_31_3 + 0.3
			local var_31_10 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 + 0.3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_9 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_9) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_9 + var_31_10 and arg_28_1.time_ < var_31_9 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play305062008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 305062008
		arg_34_1.duration_ = 1.4

		local var_34_0 = {
			zh = 1.4,
			ja = 1.233
		}
		local var_34_1 = manager.audio:GetLocalizationFlag()

		if var_34_0[var_34_1] ~= nil then
			arg_34_1.duration_ = var_34_0[var_34_1]
		end

		SetActive(arg_34_1.tipsGo_, false)

		function arg_34_1.onSingleLineFinish_()
			arg_34_1.onSingleLineUpdate_ = nil
			arg_34_1.onSingleLineFinish_ = nil
			arg_34_1.state_ = "waiting"
		end

		function arg_34_1.playNext_(arg_36_0)
			if arg_36_0 == 1 then
				arg_34_0:Play305062009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if arg_34_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_37_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_34_1.stage_.transform)

				var_37_0.name = "1019ui_story"
				var_37_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_34_1.actors_["1019ui_story"] = var_37_0

				local var_37_1 = var_37_0:GetComponentInChildren(typeof(CharacterEffect))

				var_37_1.enabled = true

				local var_37_2 = GameObjectTools.GetOrAddComponent(var_37_0, typeof(DynamicBoneHelper))

				if var_37_2 then
					var_37_2:EnableDynamicBone(false)
				end

				arg_34_1:ShowWeapon(var_37_1.transform, false)

				arg_34_1.var_["1019ui_story" .. "Animator"] = var_37_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_34_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_34_1.var_["1019ui_story" .. "LipSync"] = var_37_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_37_3 = arg_34_1.actors_["1019ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1019ui_story == nil then
				arg_34_1.var_.characterEffect1019ui_story = var_37_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_4 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_4 and not isNil(var_37_3) then
				if arg_34_1.var_.characterEffect1019ui_story and not isNil(var_37_3) then
					arg_34_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_4 and arg_34_1.time_ < 0 + var_37_4 + arg_37_0 and not isNil(var_37_3) and arg_34_1.var_.characterEffect1019ui_story then
				arg_34_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_37_6 = 0
			local var_37_7 = 0.15

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_6 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, true)
				arg_34_1.iconController_:SetSelectedState("hero")

				arg_34_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_34_1.callingController_:SetSelectedState("normal")

				arg_34_1.keyicon_.color = Color.New(1, 1, 1)
				arg_34_1.icon_.color = Color.New(1, 1, 1)

				local var_37_8 = arg_34_1:GetWordFromCfg(305062008)
				local var_37_9 = arg_34_1:FormatText(var_37_8.content)

				arg_34_1.text_.text = var_37_9

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_11 = 6 <= 0 and var_37_7 or var_37_7 * (utf8.len(var_37_9) / 6)

				if (6 <= 0 and var_37_7 or var_37_7 * (utf8.len(var_37_9) / 6)) > 0 and var_37_7 < var_37_11 then
					arg_34_1.talkMaxDuration = var_37_11

					if var_37_11 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_11 + var_37_6
					end
				end

				arg_34_1.text_.text = var_37_9
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062008", "story_v_out_305062.awb") ~= 0 then
					local var_37_12 = manager.audio:GetVoiceLength("story_v_out_305062", "305062008", "story_v_out_305062.awb") / 1000

					if var_37_12 + var_37_6 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_12 + var_37_6
					end

					if var_37_8.prefab_name ~= "" and arg_34_1.actors_[var_37_8.prefab_name] ~= nil then
						local var_37_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_8.prefab_name].transform, "story_v_out_305062", "305062008", "story_v_out_305062.awb")

						arg_34_1:RecordAudio("305062008", var_37_13)
						arg_34_1:RecordAudio("305062008", var_37_13)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_305062", "305062008", "story_v_out_305062.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_305062", "305062008", "story_v_out_305062.awb")
				end

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
	Play305062009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 305062009
		arg_38_1.duration_ = 5

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play305062010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1019ui_story"]) and arg_38_1.var_.characterEffect1019ui_story == nil then
				arg_38_1.var_.characterEffect1019ui_story = arg_38_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1019ui_story"]) then
				if arg_38_1.var_.characterEffect1019ui_story and not isNil(arg_38_1.actors_["1019ui_story"]) then
					arg_38_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_0)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1019ui_story"]) and arg_38_1.var_.characterEffect1019ui_story then
				arg_38_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_41_1 = 0
			local var_41_2 = 0.925

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_1 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, false)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_3 = arg_38_1:FormatText(arg_38_1:GetWordFromCfg(305062009).content)

				arg_38_1.text_.text = var_41_3

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_5 = 37 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 37)

				if (37 <= 0 and var_41_2 or var_41_2 * (utf8.len(var_41_3) / 37)) > 0 and var_41_2 < var_41_5 then
					arg_38_1.talkMaxDuration = var_41_5

					if var_41_5 + var_41_1 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + var_41_1
					end
				end

				arg_38_1.text_.text = var_41_3
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)
				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_6 = math.max(var_41_2, arg_38_1.talkMaxDuration)

			if var_41_1 <= arg_38_1.time_ and arg_38_1.time_ < var_41_1 + var_41_6 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_1) / var_41_6

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_1 + var_41_6 and arg_38_1.time_ < var_41_1 + var_41_6 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play305062010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 305062010
		arg_42_1.duration_ = 8.57

		SetActive(arg_42_1.tipsGo_, false)

		function arg_42_1.onSingleLineFinish_()
			arg_42_1.onSingleLineUpdate_ = nil
			arg_42_1.onSingleLineFinish_ = nil
			arg_42_1.state_ = "waiting"
		end

		function arg_42_1.playNext_(arg_44_0)
			if arg_44_0 == 1 then
				arg_42_0:Play305062011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 1.999999999999 < arg_42_1.time_ and arg_42_1.time_ <= 1.999999999999 + arg_45_0 then
				local var_45_0 = arg_42_1.bgs_.B12

				arg_42_1.bgs_.B12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_45_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_45_1 = var_45_0:GetComponent("SpriteRenderer")

				if var_45_1 and var_45_1.sprite then
					local var_45_2 = 2 * (var_45_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_45_0.transform.localScale = Vector3.New(var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, var_45_2 / var_45_1.sprite.bounds.size.y < var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x and var_45_2 * manager.ui.mainCameraCom_.aspect / var_45_1.sprite.bounds.size.x or var_45_2 / var_45_1.sprite.bounds.size.y, 0)
				end

				for iter_45_0, iter_45_1 in pairs(arg_42_1.bgs_) do
					if iter_45_0 ~= "B12" then
						iter_45_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_45_3 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = false
			end

			if arg_42_1.time_ >= var_45_3 + 0.3 and arg_42_1.time_ < var_45_3 + 0.3 + arg_45_0 then
				arg_42_1.allBtn_.enabled = true
			end

			local var_45_4 = 0

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_5 = 2

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_5 then
				local var_45_6 = Color.New(0, 0, 0)

				var_45_6.a = Mathf.Lerp(0, 1, (arg_42_1.time_ - var_45_4) / var_45_5)
				arg_42_1.mask_.color = var_45_6
			end

			if arg_42_1.time_ >= var_45_4 + var_45_5 and arg_42_1.time_ < var_45_4 + var_45_5 + arg_45_0 then
				local var_45_7 = Color.New(0, 0, 0)

				var_45_7.a = 1
				arg_42_1.mask_.color = var_45_7
			end

			local var_45_8 = 2

			if 2 < arg_42_1.time_ and arg_42_1.time_ <= var_45_8 + arg_45_0 then
				arg_42_1.mask_.enabled = true
				arg_42_1.mask_.raycastTarget = true

				arg_42_1:SetGaussion(false)
			end

			local var_45_9 = 2

			if var_45_8 <= arg_42_1.time_ and arg_42_1.time_ < var_45_8 + var_45_9 then
				local var_45_10 = Color.New(0, 0, 0)

				var_45_10.a = Mathf.Lerp(1, 0, (arg_42_1.time_ - var_45_8) / var_45_9)
				arg_42_1.mask_.color = var_45_10
			end

			if arg_42_1.time_ >= var_45_8 + var_45_9 and arg_42_1.time_ < var_45_8 + var_45_9 + arg_45_0 then
				local var_45_11 = Color.New(0, 0, 0)

				arg_42_1.mask_.enabled = false
				var_45_11.a = 0
				arg_42_1.mask_.color = var_45_11
			end

			if 1.999999999999 < arg_42_1.time_ and arg_42_1.time_ <= 1.999999999999 + arg_45_0 then
				if arg_42_1.var_.effect12333122 then
					Object.Destroy(arg_42_1.var_.effect12333122)

					arg_42_1.var_.effect12333122 = nil
				end
			end

			if arg_42_1.frameCnt_ <= 1 then
				arg_42_1.dialog_:SetActive(false)
			end

			local var_45_13 = 3.56666666666667
			local var_45_14 = 1.75

			if 3.56666666666667 < arg_42_1.time_ and arg_42_1.time_ <= var_45_13 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0

				arg_42_1.dialog_:SetActive(true)

				arg_42_1.dialogCg_.alpha = 0

				local var_45_15 = LeanTween.value(arg_42_1.dialog_, 0, 1, 0.3)

				var_45_15:setOnUpdate(LuaHelper.FloatAction(function(arg_46_0)
					arg_42_1.dialogCg_.alpha = arg_46_0
				end))
				var_45_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_42_1.dialog_)
					var_45_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_42_1.duration_ = arg_42_1.duration_ + 0.3

				SetActive(arg_42_1.leftNameGo_, false)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_16 = arg_42_1:FormatText(arg_42_1:GetWordFromCfg(305062010).content)

				arg_42_1.text_.text = var_45_16

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_18 = 70 <= 0 and var_45_14 or var_45_14 * (utf8.len(var_45_16) / 70)

				if (70 <= 0 and var_45_14 or var_45_14 * (utf8.len(var_45_16) / 70)) > 0 and var_45_14 < var_45_18 then
					arg_42_1.talkMaxDuration = var_45_18
					var_45_13 = var_45_13 + 0.3

					if var_45_18 + var_45_13 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_18 + var_45_13
					end
				end

				arg_42_1.text_.text = var_45_16
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)
				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_19 = var_45_13 + 0.3
			local var_45_20 = math.max(var_45_14, arg_42_1.talkMaxDuration)

			if var_45_13 + 0.3 <= arg_42_1.time_ and arg_42_1.time_ < var_45_19 + var_45_20 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_19) / var_45_20

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_19 + var_45_20 and arg_42_1.time_ < var_45_19 + var_45_20 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play305062011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 305062011
		arg_48_1.duration_ = 5.43

		local var_48_0 = {
			zh = 4.966,
			ja = 5.433
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
				arg_48_0:Play305062012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1011ui_story"]) and arg_48_1.var_.characterEffect1011ui_story == nil then
				arg_48_1.var_.characterEffect1011ui_story = arg_48_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1011ui_story"]) then
				if arg_48_1.var_.characterEffect1011ui_story and not isNil(arg_48_1.actors_["1011ui_story"]) then
					arg_48_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1011ui_story"]) and arg_48_1.var_.characterEffect1011ui_story then
				arg_48_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1011ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_2.localPosition
			end

			local var_51_3 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_48_1.time_ - 0) / var_51_3)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(0, -0.71, -6)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action9_2")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0
			local var_51_5 = 0.275

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(305062011)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 10 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 10)

				if (10 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 10)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062011", "story_v_out_305062.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062011", "story_v_out_305062.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_305062", "305062011", "story_v_out_305062.awb")

						arg_48_1:RecordAudio("305062011", var_51_11)
						arg_48_1:RecordAudio("305062011", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_305062", "305062011", "story_v_out_305062.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_305062", "305062011", "story_v_out_305062.awb")
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

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play305062012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 305062012
		arg_52_1.duration_ = 7.3

		local var_52_0 = {
			zh = 4.366,
			ja = 7.3
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
				arg_52_0:Play305062013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.275

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:GetWordFromCfg(305062012)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 11 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 11)

				if (11 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 11)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062012", "story_v_out_305062.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_305062", "305062012", "story_v_out_305062.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_305062", "305062012", "story_v_out_305062.awb")

						arg_52_1:RecordAudio("305062012", var_55_6)
						arg_52_1:RecordAudio("305062012", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_305062", "305062012", "story_v_out_305062.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_305062", "305062012", "story_v_out_305062.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play305062013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 305062013
		arg_56_1.duration_ = 7.13

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play305062014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_9001
			local var_59_9000

			if arg_56_1.bgs_.S0503 == nil then
				local var_59_0 = Object.Instantiate(arg_56_1.paintGo_)

				var_59_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0503")
				var_59_0.name = "S0503"
				var_59_0.transform.parent = arg_56_1.stage_.transform
				var_59_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_56_1.bgs_.S0503 = var_59_0
			end

			if 1.18333333333333 < arg_56_1.time_ and arg_56_1.time_ <= 1.18333333333333 + arg_59_0 then
				local var_59_1 = arg_56_1.bgs_.S0503

				arg_56_1.bgs_.S0503.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_59_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_59_2 = var_59_1:GetComponent("SpriteRenderer")

				if var_59_2 and var_59_2.sprite then
					local var_59_3 = 2 * (var_59_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_59_1.transform.localScale = Vector3.New(var_59_3 / var_59_2.sprite.bounds.size.y < var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x and var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x or var_59_3 / var_59_2.sprite.bounds.size.y, var_59_3 / var_59_2.sprite.bounds.size.y < var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x and var_59_3 * manager.ui.mainCameraCom_.aspect / var_59_2.sprite.bounds.size.x or var_59_3 / var_59_2.sprite.bounds.size.y, 0)
				end

				for iter_59_0, iter_59_1 in pairs(arg_56_1.bgs_) do
					if iter_59_0 ~= "S0503" then
						iter_59_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_59_4 = arg_56_1.actors_["1011ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1011ui_story == nil then
				arg_56_1.var_.characterEffect1011ui_story = var_59_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_5 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_5 and not isNil(var_59_4) then
				if arg_56_1.var_.characterEffect1011ui_story and not isNil(var_59_4) then
					arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_5)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_5 and arg_56_1.time_ < 0 + var_59_5 + arg_59_0 and not isNil(var_59_4) and arg_56_1.var_.characterEffect1011ui_story then
				arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_59_6 = arg_56_1.actors_["1011ui_story"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1011ui_story = var_59_6.localPosition
			end

			local var_59_7 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				var_59_6.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_56_1.time_ - 0) / var_59_7)
				var_59_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_6.position).x, (manager.ui.mainCamera.transform.position - var_59_6.position).y, (manager.ui.mainCamera.transform.position - var_59_6.position).z)
				var_59_6.localEulerAngles.z = 0
				var_59_6.localEulerAngles.x = 0
				var_59_6.localEulerAngles = var_59_6.localEulerAngles
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				var_59_6.localPosition = Vector3.New(0, 100, 0)
				var_59_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_59_6.position).x, (manager.ui.mainCamera.transform.position - var_59_6.position).y, (manager.ui.mainCamera.transform.position - var_59_6.position).z)
				var_59_6.localEulerAngles.z = 0
				var_59_6.localEulerAngles.x = 0
				var_59_6.localEulerAngles = var_59_6.localEulerAngles
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				local var_59_8 = arg_56_1.var_.effectxuanguang1232113

				if not arg_56_1.var_.effectxuanguang1232113 then
					var_59_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_in_keep"), manager.ui.mainCamera.transform)
					var_59_8.name = "xuanguang1232113"
					arg_56_1.var_.effectxuanguang1232113 = var_59_8
				else
					var_59_8.transform:SetParent(var_59_9001)
				end

				var_59_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_8.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.2 < arg_56_1.time_ and arg_56_1.time_ <= 1.2 + arg_59_0 then
				if arg_56_1.var_.effectxuanguang1232113 then
					Object.Destroy(arg_56_1.var_.effectxuanguang1232113)

					arg_56_1.var_.effectxuanguang1232113 = nil
				end
			end

			if 1.2 < arg_56_1.time_ and arg_56_1.time_ <= 1.2 + arg_59_0 then
				local var_59_11 = arg_56_1.var_.effectxuanguang122222222

				if not arg_56_1.var_.effectxuanguang122222222 then
					var_59_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zxuanguang_memory_out"), manager.ui.mainCamera.transform)
					var_59_11.name = "xuanguang122222222"
					arg_56_1.var_.effectxuanguang122222222 = var_59_11
				else
					var_59_11.transform:SetParent(var_59_9000)
				end

				var_59_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_59_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.7 < arg_56_1.time_ and arg_56_1.time_ <= 2.7 + arg_59_0 then
				if arg_56_1.var_.effectxuanguang1232113 then
					Object.Destroy(arg_56_1.var_.effectxuanguang1232113)

					arg_56_1.var_.effectxuanguang1232113 = nil
				end
			end

			local var_59_14 = arg_56_1.bgs_.S0503.transform

			if 1.2 < arg_56_1.time_ and arg_56_1.time_ <= 1.2 + arg_59_0 then
				arg_56_1.var_.moveOldPosS0503 = var_59_14.localPosition
			end

			local var_59_15 = 1.5

			if 1.2 <= arg_56_1.time_ and arg_56_1.time_ < 1.2 + var_59_15 then
				var_59_14.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPosS0503, Vector3.New(0, 1, 9.2), (arg_56_1.time_ - 1.2) / var_59_15)
			end

			if arg_56_1.time_ >= 1.2 + var_59_15 and arg_56_1.time_ < 1.2 + var_59_15 + arg_59_0 then
				var_59_14.localPosition = Vector3.New(0, 1, 9.2)
			end

			local var_59_16 = 0

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_16 + arg_59_0 then
				arg_56_1.allBtn_.enabled = false
			end

			if arg_56_1.time_ >= var_59_16 + 2.7 and arg_56_1.time_ < var_59_16 + 2.7 + arg_59_0 then
				arg_56_1.allBtn_.enabled = true
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_17 = 2.13333333333333
			local var_59_18 = 1.05

			if 2.13333333333333 < arg_56_1.time_ and arg_56_1.time_ <= var_59_17 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_19 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_19:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_20 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(305062013).content)

				arg_56_1.text_.text = var_59_20

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_22 = 42 <= 0 and var_59_18 or var_59_18 * (utf8.len(var_59_20) / 42)

				if (42 <= 0 and var_59_18 or var_59_18 * (utf8.len(var_59_20) / 42)) > 0 and var_59_18 < var_59_22 then
					arg_56_1.talkMaxDuration = var_59_22
					var_59_17 = var_59_17 + 0.3

					if var_59_22 + var_59_17 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_22 + var_59_17
					end
				end

				arg_56_1.text_.text = var_59_20
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_23 = var_59_17 + 0.3
			local var_59_24 = math.max(var_59_18, arg_56_1.talkMaxDuration)

			if var_59_17 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_23 + var_59_24 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_23) / var_59_24

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_23 + var_59_24 and arg_56_1.time_ < var_59_23 + var_59_24 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333333,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "S0503",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.5,
				startTime = 1.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 9),
					endPos = Vector3.New(0, 1, 9.2),
					easeType = LeanTweenType.linear
				}
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play305062014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 305062014
		arg_62_1.duration_ = 2.3

		local var_62_0 = {
			zh = 1.333,
			ja = 2.3
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play305062015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) and arg_62_1.var_.characterEffect1019ui_story == nil then
				arg_62_1.var_.characterEffect1019ui_story = arg_62_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) then
				if arg_62_1.var_.characterEffect1019ui_story and not isNil(arg_62_1.actors_["1019ui_story"]) then
					arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1019ui_story"]) and arg_62_1.var_.characterEffect1019ui_story then
				arg_62_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_65_2 = 0
			local var_65_3 = 0.125

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_2 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_4 = arg_62_1:GetWordFromCfg(305062014)
				local var_65_5 = arg_62_1:FormatText(var_65_4.content)

				arg_62_1.text_.text = var_65_5

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_7 = 5 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 5)

				if (5 <= 0 and var_65_3 or var_65_3 * (utf8.len(var_65_5) / 5)) > 0 and var_65_3 < var_65_7 then
					arg_62_1.talkMaxDuration = var_65_7

					if var_65_7 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_7 + var_65_2
					end
				end

				arg_62_1.text_.text = var_65_5
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062014", "story_v_out_305062.awb") ~= 0 then
					local var_65_8 = manager.audio:GetVoiceLength("story_v_out_305062", "305062014", "story_v_out_305062.awb") / 1000

					if var_65_8 + var_65_2 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_8 + var_65_2
					end

					if var_65_4.prefab_name ~= "" and arg_62_1.actors_[var_65_4.prefab_name] ~= nil then
						local var_65_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_4.prefab_name].transform, "story_v_out_305062", "305062014", "story_v_out_305062.awb")

						arg_62_1:RecordAudio("305062014", var_65_9)
						arg_62_1:RecordAudio("305062014", var_65_9)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_305062", "305062014", "story_v_out_305062.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_305062", "305062014", "story_v_out_305062.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_10 = math.max(var_65_3, arg_62_1.talkMaxDuration)

			if var_65_2 <= arg_62_1.time_ and arg_62_1.time_ < var_65_2 + var_65_10 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_2) / var_65_10

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_2 + var_65_10 and arg_62_1.time_ < var_65_2 + var_65_10 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play305062015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 305062015
		arg_66_1.duration_ = 5.47

		local var_66_0 = {
			zh = 4,
			ja = 5.466
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
				arg_66_0:Play305062016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.5

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:GetWordFromCfg(305062015)
				local var_69_2 = arg_66_1:FormatText(var_69_1.content)

				arg_66_1.text_.text = var_69_2

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_4 = 20 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 20)

				if (20 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_2) / 20)) > 0 and var_69_0 < var_69_4 then
					arg_66_1.talkMaxDuration = var_69_4

					if var_69_4 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_4 + 0
					end
				end

				arg_66_1.text_.text = var_69_2
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062015", "story_v_out_305062.awb") ~= 0 then
					local var_69_5 = manager.audio:GetVoiceLength("story_v_out_305062", "305062015", "story_v_out_305062.awb") / 1000

					if var_69_5 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + 0
					end

					if var_69_1.prefab_name ~= "" and arg_66_1.actors_[var_69_1.prefab_name] ~= nil then
						local var_69_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_1.prefab_name].transform, "story_v_out_305062", "305062015", "story_v_out_305062.awb")

						arg_66_1:RecordAudio("305062015", var_69_6)
						arg_66_1:RecordAudio("305062015", var_69_6)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_305062", "305062015", "story_v_out_305062.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_305062", "305062015", "story_v_out_305062.awb")
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
	Play305062016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 305062016
		arg_70_1.duration_ = 14.43

		local var_70_0 = {
			zh = 7.733,
			ja = 14.433
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
				arg_70_0:Play305062017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1011ui_story"]) and arg_70_1.var_.characterEffect1011ui_story == nil then
				arg_70_1.var_.characterEffect1011ui_story = arg_70_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1011ui_story"]) then
				if arg_70_1.var_.characterEffect1011ui_story and not isNil(arg_70_1.actors_["1011ui_story"]) then
					arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1011ui_story"]) and arg_70_1.var_.characterEffect1011ui_story then
				arg_70_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1019ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1019ui_story == nil then
				arg_70_1.var_.characterEffect1019ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect1019ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1019ui_story then
				arg_70_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_73_4 = 0
			local var_73_5 = 0.6

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(305062016)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 24 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 24)

				if (24 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 24)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062016", "story_v_out_305062.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062016", "story_v_out_305062.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_305062", "305062016", "story_v_out_305062.awb")

						arg_70_1:RecordAudio("305062016", var_73_11)
						arg_70_1:RecordAudio("305062016", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_305062", "305062016", "story_v_out_305062.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_305062", "305062016", "story_v_out_305062.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play305062017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 305062017
		arg_74_1.duration_ = 10.23

		local var_74_0 = {
			zh = 6.3,
			ja = 10.233
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play305062018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1019ui_story"]) and arg_74_1.var_.characterEffect1019ui_story == nil then
				arg_74_1.var_.characterEffect1019ui_story = arg_74_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1019ui_story"]) then
				if arg_74_1.var_.characterEffect1019ui_story and not isNil(arg_74_1.actors_["1019ui_story"]) then
					arg_74_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1019ui_story"]) and arg_74_1.var_.characterEffect1019ui_story then
				arg_74_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["1011ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1011ui_story == nil then
				arg_74_1.var_.characterEffect1011ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect1011ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1011ui_story then
				arg_74_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_77_4 = 0
			local var_77_5 = 0.825

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(305062017)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 33 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 33)

				if (33 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 33)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062017", "story_v_out_305062.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062017", "story_v_out_305062.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_305062", "305062017", "story_v_out_305062.awb")

						arg_74_1:RecordAudio("305062017", var_77_11)
						arg_74_1:RecordAudio("305062017", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_305062", "305062017", "story_v_out_305062.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_305062", "305062017", "story_v_out_305062.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play305062018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 305062018
		arg_78_1.duration_ = 6.63

		local var_78_0 = {
			zh = 4.566,
			ja = 6.633
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
				arg_78_0:Play305062019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if arg_78_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_81_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_78_1.stage_.transform)

				var_81_0.name = "1036ui_story"
				var_81_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["1036ui_story"] = var_81_0

				local var_81_1 = var_81_0:GetComponentInChildren(typeof(CharacterEffect))

				var_81_1.enabled = true

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end

				arg_78_1:ShowWeapon(var_81_1.transform, false)

				arg_78_1.var_["1036ui_story" .. "Animator"] = var_81_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_78_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_78_1.var_["1036ui_story" .. "LipSync"] = var_81_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_81_3 = arg_78_1.actors_["1036ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1036ui_story == nil then
				arg_78_1.var_.characterEffect1036ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect1036ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1036ui_story then
				arg_78_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_81_6 = arg_78_1.actors_["1019ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect1019ui_story == nil then
				arg_78_1.var_.characterEffect1019ui_story = var_81_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_7 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_7 and not isNil(var_81_6) then
				if arg_78_1.var_.characterEffect1019ui_story and not isNil(var_81_6) then
					arg_78_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_7)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_7 and arg_78_1.time_ < 0 + var_81_7 + arg_81_0 and not isNil(var_81_6) and arg_78_1.var_.characterEffect1019ui_story then
				arg_78_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_81_8 = 0
			local var_81_9 = 0.575

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_8 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_10 = arg_78_1:GetWordFromCfg(305062018)
				local var_81_11 = arg_78_1:FormatText(var_81_10.content)

				arg_78_1.text_.text = var_81_11

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_13 = 23 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 23)

				if (23 <= 0 and var_81_9 or var_81_9 * (utf8.len(var_81_11) / 23)) > 0 and var_81_9 < var_81_13 then
					arg_78_1.talkMaxDuration = var_81_13

					if var_81_13 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_13 + var_81_8
					end
				end

				arg_78_1.text_.text = var_81_11
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062018", "story_v_out_305062.awb") ~= 0 then
					local var_81_14 = manager.audio:GetVoiceLength("story_v_out_305062", "305062018", "story_v_out_305062.awb") / 1000

					if var_81_14 + var_81_8 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_14 + var_81_8
					end

					if var_81_10.prefab_name ~= "" and arg_78_1.actors_[var_81_10.prefab_name] ~= nil then
						local var_81_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_10.prefab_name].transform, "story_v_out_305062", "305062018", "story_v_out_305062.awb")

						arg_78_1:RecordAudio("305062018", var_81_15)
						arg_78_1:RecordAudio("305062018", var_81_15)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_305062", "305062018", "story_v_out_305062.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_305062", "305062018", "story_v_out_305062.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_16 = math.max(var_81_9, arg_78_1.talkMaxDuration)

			if var_81_8 <= arg_78_1.time_ and arg_78_1.time_ < var_81_8 + var_81_16 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_8) / var_81_16

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_8 + var_81_16 and arg_78_1.time_ < var_81_8 + var_81_16 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play305062019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 305062019
		arg_82_1.duration_ = 9.93

		local var_82_0 = {
			zh = 5.466,
			ja = 9.933
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play305062020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["1019ui_story"]) and arg_82_1.var_.characterEffect1019ui_story == nil then
				arg_82_1.var_.characterEffect1019ui_story = arg_82_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["1019ui_story"]) then
				if arg_82_1.var_.characterEffect1019ui_story and not isNil(arg_82_1.actors_["1019ui_story"]) then
					arg_82_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["1019ui_story"]) and arg_82_1.var_.characterEffect1019ui_story then
				arg_82_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1036ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1036ui_story == nil then
				arg_82_1.var_.characterEffect1036ui_story = var_85_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_3 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.characterEffect1036ui_story and not isNil(var_85_2) then
					arg_82_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_3)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1036ui_story then
				arg_82_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_85_4 = 0
			local var_85_5 = 0.75

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(305062019)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 30 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 30)

				if (30 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 30)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062019", "story_v_out_305062.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062019", "story_v_out_305062.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_305062", "305062019", "story_v_out_305062.awb")

						arg_82_1:RecordAudio("305062019", var_85_11)
						arg_82_1:RecordAudio("305062019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_305062", "305062019", "story_v_out_305062.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_305062", "305062019", "story_v_out_305062.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play305062020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 305062020
		arg_86_1.duration_ = 4.63

		local var_86_0 = {
			zh = 4.633,
			ja = 1.333
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
				arg_86_0:Play305062021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = arg_86_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) then
				if arg_86_1.var_.characterEffect1084ui_story and not isNil(arg_86_1.actors_["1084ui_story"]) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["1019ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1019ui_story == nil then
				arg_86_1.var_.characterEffect1019ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect1019ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect1019ui_story then
				arg_86_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_89_4 = 0
			local var_89_5 = 0.55

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_6 = arg_86_1:GetWordFromCfg(305062020)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 22 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 22)

				if (22 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 22)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062020", "story_v_out_305062.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062020", "story_v_out_305062.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_305062", "305062020", "story_v_out_305062.awb")

						arg_86_1:RecordAudio("305062020", var_89_11)
						arg_86_1:RecordAudio("305062020", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_305062", "305062020", "story_v_out_305062.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_305062", "305062020", "story_v_out_305062.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play305062021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 305062021
		arg_90_1.duration_ = 7.1

		local var_90_0 = {
			zh = 5,
			ja = 7.1
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play305062022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1019ui_story"]) and arg_90_1.var_.characterEffect1019ui_story == nil then
				arg_90_1.var_.characterEffect1019ui_story = arg_90_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1019ui_story"]) then
				if arg_90_1.var_.characterEffect1019ui_story and not isNil(arg_90_1.actors_["1019ui_story"]) then
					arg_90_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1019ui_story"]) and arg_90_1.var_.characterEffect1019ui_story then
				arg_90_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_93_2 = arg_90_1.actors_["1084ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1084ui_story == nil then
				arg_90_1.var_.characterEffect1084ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect1084ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect1084ui_story then
				arg_90_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_93_4 = 0
			local var_93_5 = 0.6

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(305062021)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 24 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 24)

				if (24 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 24)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062021", "story_v_out_305062.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062021", "story_v_out_305062.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_305062", "305062021", "story_v_out_305062.awb")

						arg_90_1:RecordAudio("305062021", var_93_11)
						arg_90_1:RecordAudio("305062021", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_305062", "305062021", "story_v_out_305062.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_305062", "305062021", "story_v_out_305062.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play305062022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 305062022
		arg_94_1.duration_ = 8.37

		local var_94_0 = {
			zh = 4.166,
			ja = 8.366
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
				arg_94_0:Play305062023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.425

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(305062022)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 17 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 17)

				if (17 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 17)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062022", "story_v_out_305062.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_305062", "305062022", "story_v_out_305062.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_305062", "305062022", "story_v_out_305062.awb")

						arg_94_1:RecordAudio("305062022", var_97_6)
						arg_94_1:RecordAudio("305062022", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_305062", "305062022", "story_v_out_305062.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_305062", "305062022", "story_v_out_305062.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play305062023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 305062023
		arg_98_1.duration_ = 11.3

		local var_98_0 = {
			zh = 9.6,
			ja = 11.3
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play305062024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 2 < arg_98_1.time_ and arg_98_1.time_ <= 2 + arg_101_0 then
				local var_101_0 = arg_98_1.bgs_.B12

				arg_98_1.bgs_.B12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_101_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_101_1 = var_101_0:GetComponent("SpriteRenderer")

				if var_101_1 and var_101_1.sprite then
					local var_101_2 = 2 * (var_101_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_101_0.transform.localScale = Vector3.New(var_101_2 / var_101_1.sprite.bounds.size.y < var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x and var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x or var_101_2 / var_101_1.sprite.bounds.size.y, var_101_2 / var_101_1.sprite.bounds.size.y < var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x and var_101_2 * manager.ui.mainCameraCom_.aspect / var_101_1.sprite.bounds.size.x or var_101_2 / var_101_1.sprite.bounds.size.y, 0)
				end

				for iter_101_0, iter_101_1 in pairs(arg_98_1.bgs_) do
					if iter_101_0 ~= "B12" then
						iter_101_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_101_3 = 0

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_3 + arg_101_0 then
				arg_98_1.allBtn_.enabled = false
			end

			if arg_98_1.time_ >= var_101_3 + 0.3 and arg_98_1.time_ < var_101_3 + 0.3 + arg_101_0 then
				arg_98_1.allBtn_.enabled = true
			end

			local var_101_4 = 0

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_5 = 2

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_5 then
				local var_101_6 = Color.New(0, 0, 0)

				var_101_6.a = Mathf.Lerp(0, 1, (arg_98_1.time_ - var_101_4) / var_101_5)
				arg_98_1.mask_.color = var_101_6
			end

			if arg_98_1.time_ >= var_101_4 + var_101_5 and arg_98_1.time_ < var_101_4 + var_101_5 + arg_101_0 then
				local var_101_7 = Color.New(0, 0, 0)

				var_101_7.a = 1
				arg_98_1.mask_.color = var_101_7
			end

			local var_101_8 = 2

			if 2 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.mask_.enabled = true
				arg_98_1.mask_.raycastTarget = true

				arg_98_1:SetGaussion(false)
			end

			local var_101_9 = 2

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_9 then
				local var_101_10 = Color.New(0, 0, 0)

				var_101_10.a = Mathf.Lerp(1, 0, (arg_98_1.time_ - var_101_8) / var_101_9)
				arg_98_1.mask_.color = var_101_10
			end

			if arg_98_1.time_ >= var_101_8 + var_101_9 and arg_98_1.time_ < var_101_8 + var_101_9 + arg_101_0 then
				local var_101_11 = Color.New(0, 0, 0)

				arg_98_1.mask_.enabled = false
				var_101_11.a = 0
				arg_98_1.mask_.color = var_101_11
			end

			local var_101_12 = arg_98_1.actors_["1019ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_12) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = var_101_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_13 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_13 and not isNil(var_101_12) then
				if arg_98_1.var_.characterEffect1019ui_story and not isNil(var_101_12) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_13)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_13 and arg_98_1.time_ < 0 + var_101_13 + arg_101_0 and not isNil(var_101_12) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if arg_98_1.frameCnt_ <= 1 then
				arg_98_1.dialog_:SetActive(false)
			end

			local var_101_14 = 3.5
			local var_101_15 = 0.5

			if 3.5 < arg_98_1.time_ and arg_98_1.time_ <= var_101_14 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0

				arg_98_1.dialog_:SetActive(true)

				arg_98_1.dialogCg_.alpha = 0

				local var_101_16 = LeanTween.value(arg_98_1.dialog_, 0, 1, 0.3)

				var_101_16:setOnUpdate(LuaHelper.FloatAction(function(arg_102_0)
					arg_98_1.dialogCg_.alpha = arg_102_0
				end))
				var_101_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_98_1.dialog_)
					var_101_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_98_1.duration_ = arg_98_1.duration_ + 0.3

				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_17 = arg_98_1:GetWordFromCfg(305062023)
				local var_101_18 = arg_98_1:FormatText(var_101_17.content)

				arg_98_1.text_.text = var_101_18

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_20 = 20 <= 0 and var_101_15 or var_101_15 * (utf8.len(var_101_18) / 20)

				if (20 <= 0 and var_101_15 or var_101_15 * (utf8.len(var_101_18) / 20)) > 0 and var_101_15 < var_101_20 then
					arg_98_1.talkMaxDuration = var_101_20
					var_101_14 = var_101_14 + 0.3

					if var_101_20 + var_101_14 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_20 + var_101_14
					end
				end

				arg_98_1.text_.text = var_101_18
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062023", "story_v_out_305062.awb") ~= 0 then
					local var_101_21 = manager.audio:GetVoiceLength("story_v_out_305062", "305062023", "story_v_out_305062.awb") / 1000

					if var_101_21 + var_101_14 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_21 + var_101_14
					end

					if var_101_17.prefab_name ~= "" and arg_98_1.actors_[var_101_17.prefab_name] ~= nil then
						local var_101_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_17.prefab_name].transform, "story_v_out_305062", "305062023", "story_v_out_305062.awb")

						arg_98_1:RecordAudio("305062023", var_101_22)
						arg_98_1:RecordAudio("305062023", var_101_22)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_305062", "305062023", "story_v_out_305062.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_305062", "305062023", "story_v_out_305062.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_23 = var_101_14 + 0.3
			local var_101_24 = math.max(var_101_15, arg_98_1.talkMaxDuration)

			if var_101_14 + 0.3 <= arg_98_1.time_ and arg_98_1.time_ < var_101_23 + var_101_24 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_23) / var_101_24

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_23 + var_101_24 and arg_98_1.time_ < var_101_23 + var_101_24 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play305062024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 305062024
		arg_104_1.duration_ = 12.97

		local var_104_0 = {
			zh = 10,
			ja = 12.966
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
				arg_104_0:Play305062025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.725

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4013")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:GetWordFromCfg(305062024)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 29 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 29)

				if (29 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 29)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062024", "story_v_out_305062.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_305062", "305062024", "story_v_out_305062.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_305062", "305062024", "story_v_out_305062.awb")

						arg_104_1:RecordAudio("305062024", var_107_6)
						arg_104_1:RecordAudio("305062024", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_305062", "305062024", "story_v_out_305062.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_305062", "305062024", "story_v_out_305062.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play305062025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 305062025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play305062026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0.1 < arg_108_1.time_ and arg_108_1.time_ <= 0.1 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_148", "se_story_148_earthquake03", "")
			end

			local var_111_1 = 0
			local var_111_2 = 1.575

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(305062025).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 63 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 63)

				if (63 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 63)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play305062026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 305062026
		arg_112_1.duration_ = 2

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
			arg_112_1.auto_ = false
		end

		function arg_112_1.playNext_(arg_114_0)
			arg_112_1.onStoryFinished_()
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1084ui_story = arg_112_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_115_0 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				arg_112_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_112_1.time_ - 0) / var_115_0)
				arg_112_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).z)
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles = arg_112_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				arg_112_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_112_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["1084ui_story"].transform.position).z)
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["1084ui_story"].transform.localEulerAngles = arg_112_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_115_1 = arg_112_1.actors_["1084ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1084ui_story == nil then
				arg_112_1.var_.characterEffect1084ui_story = var_115_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_2 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_2 and not isNil(var_115_1) then
				if arg_112_1.var_.characterEffect1084ui_story and not isNil(var_115_1) then
					arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_2 and arg_112_1.time_ < 0 + var_115_2 + arg_115_0 and not isNil(var_115_1) and arg_112_1.var_.characterEffect1084ui_story then
				arg_112_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_115_4 = 0
			local var_115_5 = 0.15

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(305062026)
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

				if manager.audio:GetVoiceLength("story_v_out_305062", "305062026", "story_v_out_305062.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_305062", "305062026", "story_v_out_305062.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_305062", "305062026", "story_v_out_305062.awb")

						arg_112_1:RecordAudio("305062026", var_115_11)
						arg_112_1:RecordAudio("305062026", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_305062", "305062026", "story_v_out_305062.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_305062", "305062026", "story_v_out_305062.awb")
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
				actorName = "1084ui_story",
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
	assets = {
		"TextureConfig/Background/B12",
		"TextureConfig/Background/S0503"
	},
	voices = {
		"story_v_out_305062.awb"
	}
}
