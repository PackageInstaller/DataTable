return {
	Play416051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 416051001
		arg_1_1.duration_ = 6.4

		local var_1_0 = {
			zh = 5.133,
			ja = 6.4
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
				arg_1_0:Play416051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 0.166666666666667 and arg_1_1.time_ < 2 + 0.166666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "SS1602"

			if arg_1_1.bgs_.SS1602 == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_2 = arg_1_1.bgs_.SS1602

				arg_1_1.bgs_.SS1602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_3 = var_4_2:GetComponent("SpriteRenderer")

				if var_4_3 and var_4_3.sprite then
					local var_4_4 = 2 * (var_4_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_2.transform.localScale = Vector3.New(var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, var_4_4 / var_4_3.sprite.bounds.size.y < var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x and var_4_4 * manager.ui.mainCameraCom_.aspect / var_4_3.sprite.bounds.size.x or var_4_4 / var_4_3.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "SS1602" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_9 = arg_1_1.var_.effect77

				if not arg_1_1.var_.effect77 then
					var_4_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_4_9.name = "77"
					arg_1_1.var_.effect77 = var_4_9
				else
					var_4_9.transform:SetParent(var_4_9000)
				end

				var_4_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_4_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				if arg_1_1.var_.effect77 then
					Object.Destroy(arg_1_1.var_.effect77)

					arg_1_1.var_.effect77 = nil
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_16", "se_story_16_channel", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			local var_4_16 = 2
			local var_4_17 = 0.35

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:GetWordFromCfg(416051001)
				local var_4_20 = arg_1_1:FormatText(var_4_19.content)

				arg_1_1.text_.text = var_4_20

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_22 = 14 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 14)

				if (14 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_20) / 14)) > 0 and var_4_17 < var_4_22 then
					arg_1_1.talkMaxDuration = var_4_22
					var_4_16 = var_4_16 + 0.3

					if var_4_22 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_20
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051001", "story_v_out_416051.awb") ~= 0 then
					local var_4_23 = manager.audio:GetVoiceLength("story_v_out_416051", "416051001", "story_v_out_416051.awb") / 1000

					if var_4_23 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_16
					end

					if var_4_19.prefab_name ~= "" and arg_1_1.actors_[var_4_19.prefab_name] ~= nil then
						local var_4_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_19.prefab_name].transform, "story_v_out_416051", "416051001", "story_v_out_416051.awb")

						arg_1_1:RecordAudio("416051001", var_4_24)
						arg_1_1:RecordAudio("416051001", var_4_24)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_416051", "416051001", "story_v_out_416051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_416051", "416051001", "story_v_out_416051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_16 + 0.3
			local var_4_26 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play416051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 416051002
		arg_8_1.duration_ = 6

		local var_8_0 = {
			zh = 2.866,
			ja = 6
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
				arg_8_0:Play416051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_16", "se_story_16_channel", "")
			end

			local var_11_1 = 0
			local var_11_2 = 0.4

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_3 = arg_8_1:GetWordFromCfg(416051002)
				local var_11_4 = arg_8_1:FormatText(var_11_3.content)

				arg_8_1.text_.text = var_11_4

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_6 = 16 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 16)

				if (16 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_4) / 16)) > 0 and var_11_2 < var_11_6 then
					arg_8_1.talkMaxDuration = var_11_6

					if var_11_6 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_6 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_4
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051002", "story_v_out_416051.awb") ~= 0 then
					local var_11_7 = manager.audio:GetVoiceLength("story_v_out_416051", "416051002", "story_v_out_416051.awb") / 1000

					if var_11_7 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_1
					end

					if var_11_3.prefab_name ~= "" and arg_8_1.actors_[var_11_3.prefab_name] ~= nil then
						local var_11_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_3.prefab_name].transform, "story_v_out_416051", "416051002", "story_v_out_416051.awb")

						arg_8_1:RecordAudio("416051002", var_11_8)
						arg_8_1:RecordAudio("416051002", var_11_8)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_416051", "416051002", "story_v_out_416051.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_416051", "416051002", "story_v_out_416051.awb")
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
	Play416051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 416051003
		arg_12_1.duration_ = 9

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play416051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_9000

			if 4 < arg_12_1.time_ and arg_12_1.time_ <= 4 + arg_15_0 then
				arg_12_1.allBtn_.enabled = false
			end

			if arg_12_1.time_ >= 4 + 0.666666666666667 and arg_12_1.time_ < 4 + 0.666666666666667 + arg_15_0 then
				arg_12_1.allBtn_.enabled = true
			end

			local var_15_0 = "I14f"

			if arg_12_1.bgs_.I14f == nil then
				local var_15_1 = Object.Instantiate(arg_12_1.paintGo_)

				var_15_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_15_0)
				var_15_1.name = var_15_0
				var_15_1.transform.parent = arg_12_1.stage_.transform
				var_15_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.bgs_[var_15_0] = var_15_1
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_2 = arg_12_1.bgs_.I14f

				arg_12_1.bgs_.I14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_15_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_15_3 = var_15_2:GetComponent("SpriteRenderer")

				if var_15_3 and var_15_3.sprite then
					local var_15_4 = 2 * (var_15_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_15_2.transform.localScale = Vector3.New(var_15_4 / var_15_3.sprite.bounds.size.y < var_15_4 * manager.ui.mainCameraCom_.aspect / var_15_3.sprite.bounds.size.x and var_15_4 * manager.ui.mainCameraCom_.aspect / var_15_3.sprite.bounds.size.x or var_15_4 / var_15_3.sprite.bounds.size.y, var_15_4 / var_15_3.sprite.bounds.size.y < var_15_4 * manager.ui.mainCameraCom_.aspect / var_15_3.sprite.bounds.size.x and var_15_4 * manager.ui.mainCameraCom_.aspect / var_15_3.sprite.bounds.size.x or var_15_4 / var_15_3.sprite.bounds.size.y, 0)
				end

				for iter_15_0, iter_15_1 in pairs(arg_12_1.bgs_) do
					if iter_15_0 ~= "I14f" then
						iter_15_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_15_5 = 0

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_6 = 2

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_6 then
				local var_15_7 = Color.New(0, 0, 0)

				var_15_7.a = Mathf.Lerp(0, 1, (arg_12_1.time_ - var_15_5) / var_15_6)
				arg_12_1.mask_.color = var_15_7
			end

			if arg_12_1.time_ >= var_15_5 + var_15_6 and arg_12_1.time_ < var_15_5 + var_15_6 + arg_15_0 then
				local var_15_8 = Color.New(0, 0, 0)

				var_15_8.a = 1
				arg_12_1.mask_.color = var_15_8
			end

			local var_15_9 = 2

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= var_15_9 + arg_15_0 then
				arg_12_1.mask_.enabled = true
				arg_12_1.mask_.raycastTarget = true

				arg_12_1:SetGaussion(false)
			end

			local var_15_10 = 2

			if var_15_9 <= arg_12_1.time_ and arg_12_1.time_ < var_15_9 + var_15_10 then
				local var_15_11 = Color.New(0, 0, 0)

				var_15_11.a = Mathf.Lerp(1, 0, (arg_12_1.time_ - var_15_9) / var_15_10)
				arg_12_1.mask_.color = var_15_11
			end

			if arg_12_1.time_ >= var_15_9 + var_15_10 and arg_12_1.time_ < var_15_9 + var_15_10 + arg_15_0 then
				local var_15_12 = Color.New(0, 0, 0)

				arg_12_1.mask_.enabled = false
				var_15_12.a = 0
				arg_12_1.mask_.color = var_15_12
			end

			if 2 < arg_12_1.time_ and arg_12_1.time_ <= 2 + arg_15_0 then
				local var_15_13 = arg_12_1.var_.effect51003

				if not arg_12_1.var_.effect51003 then
					var_15_13 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_15_13.name = "51003"
					arg_12_1.var_.effect51003 = var_15_13
				else
					var_15_13.transform:SetParent(var_15_9000)
				end

				var_15_13.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_13.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_15_17 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_17 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_17

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_17
						arg_12_1.bgmTxt2_.text = var_15_17
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.46666666666667 < arg_12_1.time_ and arg_12_1.time_ <= 1.46666666666667 + arg_15_0 then
				arg_12_1:AudioAction("play", "music", "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2.awb")

				local var_15_20 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_2", "bgm_activity_3_8_story_northwake_2")

				if "" ~= "" then
					if arg_12_1.bgmTxt_.text ~= var_15_20 and arg_12_1.bgmTxt_.text ~= "" then
						if arg_12_1.bgmTxt2_.text ~= "" then
							arg_12_1.bgmTxt_.text = arg_12_1.bgmTxt2_.text
						end

						arg_12_1.bgmTxt2_.text = var_15_20

						arg_12_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_12_1.bgmTxt_.text = var_15_20
						arg_12_1.bgmTxt2_.text = var_15_20
					end

					if arg_12_1.bgmTimer then
						arg_12_1.bgmTimer:Stop()

						arg_12_1.bgmTimer = nil
					end

					if arg_12_1.settingData.show_music_name == 1 then
						arg_12_1.musicController:SetSelectedState("show")
						arg_12_1.musicAnimator_:Play("open", 0, 0)

						if arg_12_1.settingData.music_time ~= 0 then
							arg_12_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_12_1.settingData.music_time), function()
								if arg_12_1 == nil or isNil(arg_12_1.bgmTxt_) then
									return
								end

								arg_12_1.musicController:SetSelectedState("hide")
								arg_12_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_12_1.frameCnt_ <= 1 then
				arg_12_1.dialog_:SetActive(false)
			end

			local var_15_21 = 4
			local var_15_22 = 1.925

			if 4 < arg_12_1.time_ and arg_12_1.time_ <= var_15_21 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0

				arg_12_1.dialog_:SetActive(true)

				arg_12_1.dialogCg_.alpha = 0

				local var_15_23 = LeanTween.value(arg_12_1.dialog_, 0, 1, 0.3)

				var_15_23:setOnUpdate(LuaHelper.FloatAction(function(arg_18_0)
					arg_12_1.dialogCg_.alpha = arg_18_0
				end))
				var_15_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_12_1.dialog_)
					var_15_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_12_1.duration_ = arg_12_1.duration_ + 0.3

				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_24 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(416051003).content)

				arg_12_1.text_.text = var_15_24

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_26 = 77 <= 0 and var_15_22 or var_15_22 * (utf8.len(var_15_24) / 77)

				if (77 <= 0 and var_15_22 or var_15_22 * (utf8.len(var_15_24) / 77)) > 0 and var_15_22 < var_15_26 then
					arg_12_1.talkMaxDuration = var_15_26
					var_15_21 = var_15_21 + 0.3

					if var_15_26 + var_15_21 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_26 + var_15_21
					end
				end

				arg_12_1.text_.text = var_15_24
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_27 = var_15_21 + 0.3
			local var_15_28 = math.max(var_15_22, arg_12_1.talkMaxDuration)

			if var_15_21 + 0.3 <= arg_12_1.time_ and arg_12_1.time_ < var_15_27 + var_15_28 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_27) / var_15_28

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_27 + var_15_28 and arg_12_1.time_ < var_15_27 + var_15_28 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play416051004 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 416051004
		arg_20_1.duration_ = 6.37

		local var_20_0 = {
			zh = 4.633,
			ja = 6.366
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
				arg_20_0:Play416051005(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1148"] == nil then
				local var_23_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1148")

				if not isNil(var_23_0) then
					local var_23_1 = Object.Instantiate(var_23_0, arg_20_1.canvasGo_.transform)

					var_23_1.transform:SetSiblingIndex(1)

					var_23_1.name = "1148"
					var_23_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_20_1.actors_["1148"] = var_23_1

					if arg_20_1.isInRecall_ then
						for iter_23_0, iter_23_1 in ipairs((var_23_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_23_1.color = arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_23_2 = arg_20_1.actors_["1148"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1148 = var_23_2.localPosition
				var_23_2.localScale = Vector3.New(1, 1, 1)

				arg_20_1:CheckSpriteTmpPos("1148", 3)

				for iter_23_2 = 0, var_23_2.childCount - 1 do
					local var_23_3 = var_23_2:GetChild(iter_23_2)

					if var_23_3.name == "split_6" or not string.find(var_23_3.name, "split") then
						var_23_3.gameObject:SetActive(true)
					else
						var_23_3.gameObject:SetActive(false)
					end
				end
			end

			local var_23_4 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				var_23_2.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_20_1.time_ - 0) / var_23_4)
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_23_5 = arg_20_1.actors_["1148"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.actorSpriteComps1148 == nil then
				arg_20_1.var_.actorSpriteComps1148 = var_23_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_23_6 = 0.125

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_6 and not isNil(var_23_5) then
				if arg_20_1.var_.actorSpriteComps1148 then
					for iter_23_3, iter_23_4 in pairs(arg_20_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_23_4 then
							if arg_20_1.isInRecall_ then
								iter_23_4.color = Color.New(Mathf.Lerp(iter_23_4.color.r, arg_20_1.hightColor1.r, (arg_20_1.time_ - 0) / var_23_6), Mathf.Lerp(iter_23_4.color.g, arg_20_1.hightColor1.g, (arg_20_1.time_ - 0) / var_23_6), (Mathf.Lerp(iter_23_4.color.b, arg_20_1.hightColor1.b, (arg_20_1.time_ - 0) / var_23_6)))
							else
								local var_23_7 = Mathf.Lerp(iter_23_4.color.r, 1, (arg_20_1.time_ - 0) / var_23_6)

								iter_23_4.color = Color.New(var_23_7, var_23_7, var_23_7)
							end
						end
					end
				end
			end

			if arg_20_1.time_ >= 0 + var_23_6 and arg_20_1.time_ < 0 + var_23_6 + arg_23_0 and not isNil(var_23_5) and arg_20_1.var_.actorSpriteComps1148 then
				for iter_23_5, iter_23_6 in pairs(arg_20_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_23_6 then
						iter_23_6.color = arg_20_1.isInRecall_ and (arg_20_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_20_1.var_.actorSpriteComps1148 = nil
			end

			local var_23_8 = 0
			local var_23_9 = 0.475

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(416051004)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 19 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 19)

				if (19 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 19)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051004", "story_v_out_416051.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051004", "story_v_out_416051.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_416051", "416051004", "story_v_out_416051.awb")

						arg_20_1:RecordAudio("416051004", var_23_15)
						arg_20_1:RecordAudio("416051004", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_416051", "416051004", "story_v_out_416051.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_416051", "416051004", "story_v_out_416051.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play416051005 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 416051005
		arg_24_1.duration_ = 5.8

		local var_24_0 = {
			zh = 4.1,
			ja = 5.8
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play416051006(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.5

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:GetWordFromCfg(416051005)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 20 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 20)

				if (20 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 20)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051005", "story_v_out_416051.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051005", "story_v_out_416051.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_416051", "416051005", "story_v_out_416051.awb")

						arg_24_1:RecordAudio("416051005", var_27_6)
						arg_24_1:RecordAudio("416051005", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_416051", "416051005", "story_v_out_416051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_416051", "416051005", "story_v_out_416051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play416051006 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 416051006
		arg_28_1.duration_ = 4.9

		local var_28_0 = {
			zh = 4.9,
			ja = 3.933
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
				arg_28_0:Play416051007(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1148"]) and arg_28_1.var_.actorSpriteComps1148 == nil then
				arg_28_1.var_.actorSpriteComps1148 = arg_28_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_31_0 = 0.125

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1148"]) then
				if arg_28_1.var_.actorSpriteComps1148 then
					for iter_31_0, iter_31_1 in pairs(arg_28_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_31_1 then
							if arg_28_1.isInRecall_ then
								iter_31_1.color = Color.New(Mathf.Lerp(iter_31_1.color.r, arg_28_1.hightColor2.r, (arg_28_1.time_ - 0) / var_31_0), Mathf.Lerp(iter_31_1.color.g, arg_28_1.hightColor2.g, (arg_28_1.time_ - 0) / var_31_0), (Mathf.Lerp(iter_31_1.color.b, arg_28_1.hightColor2.b, (arg_28_1.time_ - 0) / var_31_0)))
							else
								local var_31_1 = Mathf.Lerp(iter_31_1.color.r, 0.5, (arg_28_1.time_ - 0) / var_31_0)

								iter_31_1.color = Color.New(var_31_1, var_31_1, var_31_1)
							end
						end
					end
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1148"]) and arg_28_1.var_.actorSpriteComps1148 then
				for iter_31_2, iter_31_3 in pairs(arg_28_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_31_3 then
						iter_31_3.color = arg_28_1.isInRecall_ and (arg_28_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_28_1.var_.actorSpriteComps1148 = nil
			end

			local var_31_2 = 0
			local var_31_3 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_4 = arg_28_1:GetWordFromCfg(416051006)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 16 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 16)

				if (16 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 16)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051006", "story_v_out_416051.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051006", "story_v_out_416051.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_416051", "416051006", "story_v_out_416051.awb")

						arg_28_1:RecordAudio("416051006", var_31_9)
						arg_28_1:RecordAudio("416051006", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_416051", "416051006", "story_v_out_416051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_416051", "416051006", "story_v_out_416051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play416051007 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 416051007
		arg_32_1.duration_ = 10.17

		local var_32_0 = {
			zh = 5.1,
			ja = 10.166
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play416051008(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1148"]) and arg_32_1.var_.actorSpriteComps1148 == nil then
				arg_32_1.var_.actorSpriteComps1148 = arg_32_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_35_0 = 0.125

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1148"]) then
				if arg_32_1.var_.actorSpriteComps1148 then
					for iter_35_0, iter_35_1 in pairs(arg_32_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_35_1 then
							if arg_32_1.isInRecall_ then
								iter_35_1.color = Color.New(Mathf.Lerp(iter_35_1.color.r, arg_32_1.hightColor1.r, (arg_32_1.time_ - 0) / var_35_0), Mathf.Lerp(iter_35_1.color.g, arg_32_1.hightColor1.g, (arg_32_1.time_ - 0) / var_35_0), (Mathf.Lerp(iter_35_1.color.b, arg_32_1.hightColor1.b, (arg_32_1.time_ - 0) / var_35_0)))
							else
								local var_35_1 = Mathf.Lerp(iter_35_1.color.r, 1, (arg_32_1.time_ - 0) / var_35_0)

								iter_35_1.color = Color.New(var_35_1, var_35_1, var_35_1)
							end
						end
					end
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1148"]) and arg_32_1.var_.actorSpriteComps1148 then
				for iter_35_2, iter_35_3 in pairs(arg_32_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_35_3 then
						iter_35_3.color = arg_32_1.isInRecall_ and (arg_32_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_32_1.var_.actorSpriteComps1148 = nil
			end

			local var_35_2 = 0
			local var_35_3 = 0.55

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_2 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_4 = arg_32_1:GetWordFromCfg(416051007)
				local var_35_5 = arg_32_1:FormatText(var_35_4.content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 22 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 22)

				if (22 <= 0 and var_35_3 or var_35_3 * (utf8.len(var_35_5) / 22)) > 0 and var_35_3 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_2
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051007", "story_v_out_416051.awb") ~= 0 then
					local var_35_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051007", "story_v_out_416051.awb") / 1000

					if var_35_8 + var_35_2 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_8 + var_35_2
					end

					if var_35_4.prefab_name ~= "" and arg_32_1.actors_[var_35_4.prefab_name] ~= nil then
						local var_35_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_4.prefab_name].transform, "story_v_out_416051", "416051007", "story_v_out_416051.awb")

						arg_32_1:RecordAudio("416051007", var_35_9)
						arg_32_1:RecordAudio("416051007", var_35_9)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_416051", "416051007", "story_v_out_416051.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_416051", "416051007", "story_v_out_416051.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_10 = math.max(var_35_3, arg_32_1.talkMaxDuration)

			if var_35_2 <= arg_32_1.time_ and arg_32_1.time_ < var_35_2 + var_35_10 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_2) / var_35_10

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_2 + var_35_10 and arg_32_1.time_ < var_35_2 + var_35_10 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play416051008 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 416051008
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play416051009(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1148 = arg_36_1.actors_["1148"].transform.localPosition
				arg_36_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_36_1:CheckSpriteTmpPos("1148", 7)

				for iter_39_0 = 0, arg_36_1.actors_["1148"].transform.childCount - 1 do
					local var_39_0 = arg_36_1.actors_["1148"].transform:GetChild(iter_39_0)

					if var_39_0.name == "" or not string.find(var_39_0.name, "split") then
						var_39_0.gameObject:SetActive(true)
					else
						var_39_0.gameObject:SetActive(false)
					end
				end
			end

			local var_39_1 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_1 then
				arg_36_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_36_1.time_ - 0) / var_39_1)
			end

			if arg_36_1.time_ >= 0 + var_39_1 and arg_36_1.time_ < 0 + var_39_1 + arg_39_0 then
				arg_36_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_39_2 = 0
			local var_39_3 = 1.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, false)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(416051008).content)

				arg_36_1.text_.text = var_39_4

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_6 = 46 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 46)

				if (46 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_4) / 46)) > 0 and var_39_3 < var_39_6 then
					arg_36_1.talkMaxDuration = var_39_6

					if var_39_6 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_6 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_4
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_7 and arg_36_1.time_ < var_39_2 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play416051009 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 416051009
		arg_40_1.duration_ = 6.7

		local var_40_0 = {
			zh = 3.8,
			ja = 6.7
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
				arg_40_0:Play416051010(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.4

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_1 = arg_40_1:GetWordFromCfg(416051009)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 16 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 16)

				if (16 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 16)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051009", "story_v_out_416051.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051009", "story_v_out_416051.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_416051", "416051009", "story_v_out_416051.awb")

						arg_40_1:RecordAudio("416051009", var_43_6)
						arg_40_1:RecordAudio("416051009", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_416051", "416051009", "story_v_out_416051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_416051", "416051009", "story_v_out_416051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play416051010 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 416051010
		arg_44_1.duration_ = 8.7

		local var_44_0 = {
			zh = 4.6,
			ja = 8.7
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
				arg_44_0:Play416051011(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1148 = arg_44_1.actors_["1148"].transform.localPosition
				arg_44_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_44_1:CheckSpriteTmpPos("1148", 3)

				for iter_47_0 = 0, arg_44_1.actors_["1148"].transform.childCount - 1 do
					local var_47_0 = arg_44_1.actors_["1148"].transform:GetChild(iter_47_0)

					if var_47_0.name == "split_6" or not string.find(var_47_0.name, "split") then
						var_47_0.gameObject:SetActive(true)
					else
						var_47_0.gameObject:SetActive(false)
					end
				end
			end

			local var_47_1 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_1 then
				arg_44_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_44_1.time_ - 0) / var_47_1)
			end

			if arg_44_1.time_ >= 0 + var_47_1 and arg_44_1.time_ < 0 + var_47_1 + arg_47_0 then
				arg_44_1.actors_["1148"].transform.localPosition = Vector3.New(0, -429, -180)
			end

			local var_47_2 = arg_44_1.actors_["1148"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps1148 == nil then
				arg_44_1.var_.actorSpriteComps1148 = var_47_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_47_3 = 0.125

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.actorSpriteComps1148 then
					for iter_47_1, iter_47_2 in pairs(arg_44_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_47_2 then
							if arg_44_1.isInRecall_ then
								iter_47_2.color = Color.New(Mathf.Lerp(iter_47_2.color.r, arg_44_1.hightColor1.r, (arg_44_1.time_ - 0) / var_47_3), Mathf.Lerp(iter_47_2.color.g, arg_44_1.hightColor1.g, (arg_44_1.time_ - 0) / var_47_3), (Mathf.Lerp(iter_47_2.color.b, arg_44_1.hightColor1.b, (arg_44_1.time_ - 0) / var_47_3)))
							else
								local var_47_4 = Mathf.Lerp(iter_47_2.color.r, 1, (arg_44_1.time_ - 0) / var_47_3)

								iter_47_2.color = Color.New(var_47_4, var_47_4, var_47_4)
							end
						end
					end
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.actorSpriteComps1148 then
				for iter_47_3, iter_47_4 in pairs(arg_44_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_47_4 then
						iter_47_4.color = arg_44_1.isInRecall_ and (arg_44_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_44_1.var_.actorSpriteComps1148 = nil
			end

			local var_47_5 = 0
			local var_47_6 = 0.5

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_5 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_7 = arg_44_1:GetWordFromCfg(416051010)
				local var_47_8 = arg_44_1:FormatText(var_47_7.content)

				arg_44_1.text_.text = var_47_8

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_10 = 20 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 20)

				if (20 <= 0 and var_47_6 or var_47_6 * (utf8.len(var_47_8) / 20)) > 0 and var_47_6 < var_47_10 then
					arg_44_1.talkMaxDuration = var_47_10

					if var_47_10 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_5
					end
				end

				arg_44_1.text_.text = var_47_8
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051010", "story_v_out_416051.awb") ~= 0 then
					local var_47_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051010", "story_v_out_416051.awb") / 1000

					if var_47_11 + var_47_5 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_5
					end

					if var_47_7.prefab_name ~= "" and arg_44_1.actors_[var_47_7.prefab_name] ~= nil then
						local var_47_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_7.prefab_name].transform, "story_v_out_416051", "416051010", "story_v_out_416051.awb")

						arg_44_1:RecordAudio("416051010", var_47_12)
						arg_44_1:RecordAudio("416051010", var_47_12)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_416051", "416051010", "story_v_out_416051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_416051", "416051010", "story_v_out_416051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_13 = math.max(var_47_6, arg_44_1.talkMaxDuration)

			if var_47_5 <= arg_44_1.time_ and arg_44_1.time_ < var_47_5 + var_47_13 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_5) / var_47_13

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_5 + var_47_13 and arg_44_1.time_ < var_47_5 + var_47_13 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play416051011 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 416051011
		arg_48_1.duration_ = 6

		local var_48_0 = {
			zh = 6,
			ja = 5.733
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
				arg_48_0:Play416051012(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1148"]) and arg_48_1.var_.actorSpriteComps1148 == nil then
				arg_48_1.var_.actorSpriteComps1148 = arg_48_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_51_0 = 0.125

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1148"]) then
				if arg_48_1.var_.actorSpriteComps1148 then
					for iter_51_0, iter_51_1 in pairs(arg_48_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_51_1 then
							if arg_48_1.isInRecall_ then
								iter_51_1.color = Color.New(Mathf.Lerp(iter_51_1.color.r, arg_48_1.hightColor2.r, (arg_48_1.time_ - 0) / var_51_0), Mathf.Lerp(iter_51_1.color.g, arg_48_1.hightColor2.g, (arg_48_1.time_ - 0) / var_51_0), (Mathf.Lerp(iter_51_1.color.b, arg_48_1.hightColor2.b, (arg_48_1.time_ - 0) / var_51_0)))
							else
								local var_51_1 = Mathf.Lerp(iter_51_1.color.r, 0.5, (arg_48_1.time_ - 0) / var_51_0)

								iter_51_1.color = Color.New(var_51_1, var_51_1, var_51_1)
							end
						end
					end
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1148"]) and arg_48_1.var_.actorSpriteComps1148 then
				for iter_51_2, iter_51_3 in pairs(arg_48_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_51_3 then
						iter_51_3.color = arg_48_1.isInRecall_ and (arg_48_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_48_1.var_.actorSpriteComps1148 = nil
			end

			local var_51_2 = 0
			local var_51_3 = 0.65

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_2 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_4 = arg_48_1:GetWordFromCfg(416051011)
				local var_51_5 = arg_48_1:FormatText(var_51_4.content)

				arg_48_1.text_.text = var_51_5

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_7 = 26 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 26)

				if (26 <= 0 and var_51_3 or var_51_3 * (utf8.len(var_51_5) / 26)) > 0 and var_51_3 < var_51_7 then
					arg_48_1.talkMaxDuration = var_51_7

					if var_51_7 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_7 + var_51_2
					end
				end

				arg_48_1.text_.text = var_51_5
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051011", "story_v_out_416051.awb") ~= 0 then
					local var_51_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051011", "story_v_out_416051.awb") / 1000

					if var_51_8 + var_51_2 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_8 + var_51_2
					end

					if var_51_4.prefab_name ~= "" and arg_48_1.actors_[var_51_4.prefab_name] ~= nil then
						local var_51_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_4.prefab_name].transform, "story_v_out_416051", "416051011", "story_v_out_416051.awb")

						arg_48_1:RecordAudio("416051011", var_51_9)
						arg_48_1:RecordAudio("416051011", var_51_9)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_416051", "416051011", "story_v_out_416051.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_416051", "416051011", "story_v_out_416051.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_10 = math.max(var_51_3, arg_48_1.talkMaxDuration)

			if var_51_2 <= arg_48_1.time_ and arg_48_1.time_ < var_51_2 + var_51_10 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_2) / var_51_10

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_2 + var_51_10 and arg_48_1.time_ < var_51_2 + var_51_10 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play416051012 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 416051012
		arg_52_1.duration_ = 3.93

		local var_52_0 = {
			zh = 3.933,
			ja = 3.9
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
				arg_52_0:Play416051013(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.45

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:GetWordFromCfg(416051012)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 18)

				if (18 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 18)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051012", "story_v_out_416051.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051012", "story_v_out_416051.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_416051", "416051012", "story_v_out_416051.awb")

						arg_52_1:RecordAudio("416051012", var_55_6)
						arg_52_1:RecordAudio("416051012", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_416051", "416051012", "story_v_out_416051.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_416051", "416051012", "story_v_out_416051.awb")
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
	Play416051013 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 416051013
		arg_56_1.duration_ = 4.6

		local var_56_0 = {
			zh = 3.866,
			ja = 4.6
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
				arg_56_0:Play416051014(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1148"]) and arg_56_1.var_.actorSpriteComps1148 == nil then
				arg_56_1.var_.actorSpriteComps1148 = arg_56_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_59_0 = 0.125

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1148"]) then
				if arg_56_1.var_.actorSpriteComps1148 then
					for iter_59_0, iter_59_1 in pairs(arg_56_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_59_1 then
							if arg_56_1.isInRecall_ then
								iter_59_1.color = Color.New(Mathf.Lerp(iter_59_1.color.r, arg_56_1.hightColor1.r, (arg_56_1.time_ - 0) / var_59_0), Mathf.Lerp(iter_59_1.color.g, arg_56_1.hightColor1.g, (arg_56_1.time_ - 0) / var_59_0), (Mathf.Lerp(iter_59_1.color.b, arg_56_1.hightColor1.b, (arg_56_1.time_ - 0) / var_59_0)))
							else
								local var_59_1 = Mathf.Lerp(iter_59_1.color.r, 1, (arg_56_1.time_ - 0) / var_59_0)

								iter_59_1.color = Color.New(var_59_1, var_59_1, var_59_1)
							end
						end
					end
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1148"]) and arg_56_1.var_.actorSpriteComps1148 then
				for iter_59_2, iter_59_3 in pairs(arg_56_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_59_3 then
						iter_59_3.color = arg_56_1.isInRecall_ and (arg_56_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_56_1.var_.actorSpriteComps1148 = nil
			end

			local var_59_2 = arg_56_1.actors_["1148"].transform

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.var_.moveOldPos1148 = var_59_2.localPosition
				var_59_2.localScale = Vector3.New(1, 1, 1)

				arg_56_1:CheckSpriteTmpPos("1148", 3)

				for iter_59_4 = 0, var_59_2.childCount - 1 do
					local var_59_3 = var_59_2:GetChild(iter_59_4)

					if var_59_3.name == "split_3" or not string.find(var_59_3.name, "split") then
						var_59_3.gameObject:SetActive(true)
					else
						var_59_3.gameObject:SetActive(false)
					end
				end
			end

			local var_59_4 = 0.001

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				var_59_2.localPosition = Vector3.Lerp(arg_56_1.var_.moveOldPos1148, Vector3.New(0, -429, -180), (arg_56_1.time_ - 0) / var_59_4)
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				var_59_2.localPosition = Vector3.New(0, -429, -180)
			end

			local var_59_5 = 0
			local var_59_6 = 0.45

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_5 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_7 = arg_56_1:GetWordFromCfg(416051013)
				local var_59_8 = arg_56_1:FormatText(var_59_7.content)

				arg_56_1.text_.text = var_59_8

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_10 = 18 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 18)

				if (18 <= 0 and var_59_6 or var_59_6 * (utf8.len(var_59_8) / 18)) > 0 and var_59_6 < var_59_10 then
					arg_56_1.talkMaxDuration = var_59_10

					if var_59_10 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_5
					end
				end

				arg_56_1.text_.text = var_59_8
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051013", "story_v_out_416051.awb") ~= 0 then
					local var_59_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051013", "story_v_out_416051.awb") / 1000

					if var_59_11 + var_59_5 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_11 + var_59_5
					end

					if var_59_7.prefab_name ~= "" and arg_56_1.actors_[var_59_7.prefab_name] ~= nil then
						local var_59_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_7.prefab_name].transform, "story_v_out_416051", "416051013", "story_v_out_416051.awb")

						arg_56_1:RecordAudio("416051013", var_59_12)
						arg_56_1:RecordAudio("416051013", var_59_12)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_416051", "416051013", "story_v_out_416051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_416051", "416051013", "story_v_out_416051.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = math.max(var_59_6, arg_56_1.talkMaxDuration)

			if var_59_5 <= arg_56_1.time_ and arg_56_1.time_ < var_59_5 + var_59_13 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_5) / var_59_13

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_5 + var_59_13 and arg_56_1.time_ < var_59_5 + var_59_13 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_56_1:InitPlayNodeList()
	end,
	Play416051014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 416051014
		arg_60_1.duration_ = 5.07

		local var_60_0 = {
			zh = 4.533,
			ja = 5.066
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
				arg_60_0:Play416051015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.45

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_1 = arg_60_1:GetWordFromCfg(416051014)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 18)

				if (18 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 18)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051014", "story_v_out_416051.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051014", "story_v_out_416051.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_416051", "416051014", "story_v_out_416051.awb")

						arg_60_1:RecordAudio("416051014", var_63_6)
						arg_60_1:RecordAudio("416051014", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_416051", "416051014", "story_v_out_416051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_416051", "416051014", "story_v_out_416051.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play416051015 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 416051015
		arg_64_1.duration_ = 10.67

		local var_64_0 = {
			zh = 7.533,
			ja = 10.666
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
				arg_64_0:Play416051016(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1148"]) and arg_64_1.var_.actorSpriteComps1148 == nil then
				arg_64_1.var_.actorSpriteComps1148 = arg_64_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_67_0 = 0.125

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1148"]) then
				if arg_64_1.var_.actorSpriteComps1148 then
					for iter_67_0, iter_67_1 in pairs(arg_64_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_67_1 then
							if arg_64_1.isInRecall_ then
								iter_67_1.color = Color.New(Mathf.Lerp(iter_67_1.color.r, arg_64_1.hightColor2.r, (arg_64_1.time_ - 0) / var_67_0), Mathf.Lerp(iter_67_1.color.g, arg_64_1.hightColor2.g, (arg_64_1.time_ - 0) / var_67_0), (Mathf.Lerp(iter_67_1.color.b, arg_64_1.hightColor2.b, (arg_64_1.time_ - 0) / var_67_0)))
							else
								local var_67_1 = Mathf.Lerp(iter_67_1.color.r, 0.5, (arg_64_1.time_ - 0) / var_67_0)

								iter_67_1.color = Color.New(var_67_1, var_67_1, var_67_1)
							end
						end
					end
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1148"]) and arg_64_1.var_.actorSpriteComps1148 then
				for iter_67_2, iter_67_3 in pairs(arg_64_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_67_3 then
						iter_67_3.color = arg_64_1.isInRecall_ and (arg_64_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_64_1.var_.actorSpriteComps1148 = nil
			end

			local var_67_2 = 0
			local var_67_3 = 0.8

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_4 = arg_64_1:GetWordFromCfg(416051015)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 32 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 32)

				if (32 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 32)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051015", "story_v_out_416051.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051015", "story_v_out_416051.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_416051", "416051015", "story_v_out_416051.awb")

						arg_64_1:RecordAudio("416051015", var_67_9)
						arg_64_1:RecordAudio("416051015", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_416051", "416051015", "story_v_out_416051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_416051", "416051015", "story_v_out_416051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play416051016 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 416051016
		arg_68_1.duration_ = 6.47

		local var_68_0 = {
			zh = 3.466,
			ja = 6.466
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
				arg_68_0:Play416051017(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1148"]) and arg_68_1.var_.actorSpriteComps1148 == nil then
				arg_68_1.var_.actorSpriteComps1148 = arg_68_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_71_0 = 0.125

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1148"]) then
				if arg_68_1.var_.actorSpriteComps1148 then
					for iter_71_0, iter_71_1 in pairs(arg_68_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_71_1 then
							if arg_68_1.isInRecall_ then
								iter_71_1.color = Color.New(Mathf.Lerp(iter_71_1.color.r, arg_68_1.hightColor1.r, (arg_68_1.time_ - 0) / var_71_0), Mathf.Lerp(iter_71_1.color.g, arg_68_1.hightColor1.g, (arg_68_1.time_ - 0) / var_71_0), (Mathf.Lerp(iter_71_1.color.b, arg_68_1.hightColor1.b, (arg_68_1.time_ - 0) / var_71_0)))
							else
								local var_71_1 = Mathf.Lerp(iter_71_1.color.r, 1, (arg_68_1.time_ - 0) / var_71_0)

								iter_71_1.color = Color.New(var_71_1, var_71_1, var_71_1)
							end
						end
					end
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1148"]) and arg_68_1.var_.actorSpriteComps1148 then
				for iter_71_2, iter_71_3 in pairs(arg_68_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_71_3 then
						iter_71_3.color = arg_68_1.isInRecall_ and (arg_68_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_68_1.var_.actorSpriteComps1148 = nil
			end

			local var_71_2 = 0
			local var_71_3 = 0.45

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_2 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_4 = arg_68_1:GetWordFromCfg(416051016)
				local var_71_5 = arg_68_1:FormatText(var_71_4.content)

				arg_68_1.text_.text = var_71_5

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_7 = 18 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 18)

				if (18 <= 0 and var_71_3 or var_71_3 * (utf8.len(var_71_5) / 18)) > 0 and var_71_3 < var_71_7 then
					arg_68_1.talkMaxDuration = var_71_7

					if var_71_7 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_2
					end
				end

				arg_68_1.text_.text = var_71_5
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051016", "story_v_out_416051.awb") ~= 0 then
					local var_71_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051016", "story_v_out_416051.awb") / 1000

					if var_71_8 + var_71_2 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_8 + var_71_2
					end

					if var_71_4.prefab_name ~= "" and arg_68_1.actors_[var_71_4.prefab_name] ~= nil then
						local var_71_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_4.prefab_name].transform, "story_v_out_416051", "416051016", "story_v_out_416051.awb")

						arg_68_1:RecordAudio("416051016", var_71_9)
						arg_68_1:RecordAudio("416051016", var_71_9)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_416051", "416051016", "story_v_out_416051.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_416051", "416051016", "story_v_out_416051.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_10 = math.max(var_71_3, arg_68_1.talkMaxDuration)

			if var_71_2 <= arg_68_1.time_ and arg_68_1.time_ < var_71_2 + var_71_10 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_2) / var_71_10

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_2 + var_71_10 and arg_68_1.time_ < var_71_2 + var_71_10 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play416051017 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 416051017
		arg_72_1.duration_ = 4.8

		local var_72_0 = {
			zh = 4.133,
			ja = 4.8
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
				arg_72_0:Play416051018(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.475

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_1 = arg_72_1:GetWordFromCfg(416051017)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 19)

				if (19 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 19)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051017", "story_v_out_416051.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051017", "story_v_out_416051.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_416051", "416051017", "story_v_out_416051.awb")

						arg_72_1:RecordAudio("416051017", var_75_6)
						arg_72_1:RecordAudio("416051017", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_416051", "416051017", "story_v_out_416051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_416051", "416051017", "story_v_out_416051.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play416051018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 416051018
		arg_76_1.duration_ = 5.53

		local var_76_0 = {
			zh = 3.7,
			ja = 5.533
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
				arg_76_0:Play416051019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1148"]) and arg_76_1.var_.actorSpriteComps1148 == nil then
				arg_76_1.var_.actorSpriteComps1148 = arg_76_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_79_0 = 0.125

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1148"]) then
				if arg_76_1.var_.actorSpriteComps1148 then
					for iter_79_0, iter_79_1 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_79_1 then
							if arg_76_1.isInRecall_ then
								iter_79_1.color = Color.New(Mathf.Lerp(iter_79_1.color.r, arg_76_1.hightColor2.r, (arg_76_1.time_ - 0) / var_79_0), Mathf.Lerp(iter_79_1.color.g, arg_76_1.hightColor2.g, (arg_76_1.time_ - 0) / var_79_0), (Mathf.Lerp(iter_79_1.color.b, arg_76_1.hightColor2.b, (arg_76_1.time_ - 0) / var_79_0)))
							else
								local var_79_1 = Mathf.Lerp(iter_79_1.color.r, 0.5, (arg_76_1.time_ - 0) / var_79_0)

								iter_79_1.color = Color.New(var_79_1, var_79_1, var_79_1)
							end
						end
					end
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1148"]) and arg_76_1.var_.actorSpriteComps1148 then
				for iter_79_2, iter_79_3 in pairs(arg_76_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_79_3 then
						iter_79_3.color = arg_76_1.isInRecall_ and (arg_76_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_76_1.var_.actorSpriteComps1148 = nil
			end

			local var_79_2 = 0
			local var_79_3 = 0.425

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1084].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_studentwb")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_4 = arg_76_1:GetWordFromCfg(416051018)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 17 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 17)

				if (17 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 17)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051018", "story_v_out_416051.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051018", "story_v_out_416051.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_416051", "416051018", "story_v_out_416051.awb")

						arg_76_1:RecordAudio("416051018", var_79_9)
						arg_76_1:RecordAudio("416051018", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_416051", "416051018", "story_v_out_416051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_416051", "416051018", "story_v_out_416051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play416051019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 416051019
		arg_80_1.duration_ = 7.33

		local var_80_0 = {
			zh = 4.333,
			ja = 7.333
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play416051020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1148"]) and arg_80_1.var_.actorSpriteComps1148 == nil then
				arg_80_1.var_.actorSpriteComps1148 = arg_80_1.actors_["1148"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_83_0 = 0.125

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1148"]) then
				if arg_80_1.var_.actorSpriteComps1148 then
					for iter_83_0, iter_83_1 in pairs(arg_80_1.var_.actorSpriteComps1148:ToTable()) do
						if iter_83_1 then
							if arg_80_1.isInRecall_ then
								iter_83_1.color = Color.New(Mathf.Lerp(iter_83_1.color.r, arg_80_1.hightColor1.r, (arg_80_1.time_ - 0) / var_83_0), Mathf.Lerp(iter_83_1.color.g, arg_80_1.hightColor1.g, (arg_80_1.time_ - 0) / var_83_0), (Mathf.Lerp(iter_83_1.color.b, arg_80_1.hightColor1.b, (arg_80_1.time_ - 0) / var_83_0)))
							else
								local var_83_1 = Mathf.Lerp(iter_83_1.color.r, 1, (arg_80_1.time_ - 0) / var_83_0)

								iter_83_1.color = Color.New(var_83_1, var_83_1, var_83_1)
							end
						end
					end
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1148"]) and arg_80_1.var_.actorSpriteComps1148 then
				for iter_83_2, iter_83_3 in pairs(arg_80_1.var_.actorSpriteComps1148:ToTable()) do
					if iter_83_3 then
						iter_83_3.color = arg_80_1.isInRecall_ and (arg_80_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_80_1.var_.actorSpriteComps1148 = nil
			end

			local var_83_2 = 0
			local var_83_3 = 0.45

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_2 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_4 = arg_80_1:GetWordFromCfg(416051019)
				local var_83_5 = arg_80_1:FormatText(var_83_4.content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 18 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 18)

				if (18 <= 0 and var_83_3 or var_83_3 * (utf8.len(var_83_5) / 18)) > 0 and var_83_3 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_2
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051019", "story_v_out_416051.awb") ~= 0 then
					local var_83_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051019", "story_v_out_416051.awb") / 1000

					if var_83_8 + var_83_2 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_2
					end

					if var_83_4.prefab_name ~= "" and arg_80_1.actors_[var_83_4.prefab_name] ~= nil then
						local var_83_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_4.prefab_name].transform, "story_v_out_416051", "416051019", "story_v_out_416051.awb")

						arg_80_1:RecordAudio("416051019", var_83_9)
						arg_80_1:RecordAudio("416051019", var_83_9)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_416051", "416051019", "story_v_out_416051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_416051", "416051019", "story_v_out_416051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_10 = math.max(var_83_3, arg_80_1.talkMaxDuration)

			if var_83_2 <= arg_80_1.time_ and arg_80_1.time_ < var_83_2 + var_83_10 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_2) / var_83_10

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_2 + var_83_10 and arg_80_1.time_ < var_83_2 + var_83_10 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play416051020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 416051020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play416051021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1148 = arg_84_1.actors_["1148"].transform.localPosition
				arg_84_1.actors_["1148"].transform.localScale = Vector3.New(1, 1, 1)

				arg_84_1:CheckSpriteTmpPos("1148", 7)

				for iter_87_0 = 0, arg_84_1.actors_["1148"].transform.childCount - 1 do
					local var_87_0 = arg_84_1.actors_["1148"].transform:GetChild(iter_87_0)

					if var_87_0.name == "" or not string.find(var_87_0.name, "split") then
						var_87_0.gameObject:SetActive(true)
					else
						var_87_0.gameObject:SetActive(false)
					end
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["1148"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1148, Vector3.New(0, -2000, 0), (arg_84_1.time_ - 0) / var_87_1)
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["1148"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_87_2 = 0
			local var_87_3 = 2

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_2 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_4 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(416051020).content)

				arg_84_1.text_.text = var_87_4

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_6 = 80 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 80)

				if (80 <= 0 and var_87_3 or var_87_3 * (utf8.len(var_87_4) / 80)) > 0 and var_87_3 < var_87_6 then
					arg_84_1.talkMaxDuration = var_87_6

					if var_87_6 + var_87_2 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_2
					end
				end

				arg_84_1.text_.text = var_87_4
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_3, arg_84_1.talkMaxDuration)

			if var_87_2 <= arg_84_1.time_ and arg_84_1.time_ < var_87_2 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_2) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_2 + var_87_7 and arg_84_1.time_ < var_87_2 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play416051021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 416051021
		arg_88_1.duration_ = 9.7

		local var_88_0 = {
			zh = 9.7,
			ja = 8.366
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play416051022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 4 < arg_88_1.time_ and arg_88_1.time_ <= 4 + arg_91_0 then
				arg_88_1.allBtn_.enabled = false
			end

			if arg_88_1.time_ >= 4 + 0.3 and arg_88_1.time_ < 4 + 0.3 + arg_91_0 then
				arg_88_1.allBtn_.enabled = true
			end

			local var_91_0 = "ST2101"

			if arg_88_1.bgs_.ST2101 == nil then
				local var_91_1 = Object.Instantiate(arg_88_1.paintGo_)

				var_91_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_91_0)
				var_91_1.name = var_91_0
				var_91_1.transform.parent = arg_88_1.stage_.transform
				var_91_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.bgs_[var_91_0] = var_91_1
			end

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				local var_91_2 = arg_88_1.bgs_.ST2101

				arg_88_1.bgs_.ST2101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_91_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_91_3 = var_91_2:GetComponent("SpriteRenderer")

				if var_91_3 and var_91_3.sprite then
					local var_91_4 = 2 * (var_91_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_91_2.transform.localScale = Vector3.New(var_91_4 / var_91_3.sprite.bounds.size.y < var_91_4 * manager.ui.mainCameraCom_.aspect / var_91_3.sprite.bounds.size.x and var_91_4 * manager.ui.mainCameraCom_.aspect / var_91_3.sprite.bounds.size.x or var_91_4 / var_91_3.sprite.bounds.size.y, var_91_4 / var_91_3.sprite.bounds.size.y < var_91_4 * manager.ui.mainCameraCom_.aspect / var_91_3.sprite.bounds.size.x and var_91_4 * manager.ui.mainCameraCom_.aspect / var_91_3.sprite.bounds.size.x or var_91_4 / var_91_3.sprite.bounds.size.y, 0)
				end

				for iter_91_0, iter_91_1 in pairs(arg_88_1.bgs_) do
					if iter_91_0 ~= "ST2101" then
						iter_91_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_91_5 = 0

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_6 = 2

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_6 then
				local var_91_7 = Color.New(0, 0, 0)

				var_91_7.a = Mathf.Lerp(0, 1, (arg_88_1.time_ - var_91_5) / var_91_6)
				arg_88_1.mask_.color = var_91_7
			end

			if arg_88_1.time_ >= var_91_5 + var_91_6 and arg_88_1.time_ < var_91_5 + var_91_6 + arg_91_0 then
				local var_91_8 = Color.New(0, 0, 0)

				var_91_8.a = 1
				arg_88_1.mask_.color = var_91_8
			end

			local var_91_9 = 2

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= var_91_9 + arg_91_0 then
				arg_88_1.mask_.enabled = true
				arg_88_1.mask_.raycastTarget = true

				arg_88_1:SetGaussion(false)
			end

			local var_91_10 = 2

			if var_91_9 <= arg_88_1.time_ and arg_88_1.time_ < var_91_9 + var_91_10 then
				local var_91_11 = Color.New(0, 0, 0)

				var_91_11.a = Mathf.Lerp(1, 0, (arg_88_1.time_ - var_91_9) / var_91_10)
				arg_88_1.mask_.color = var_91_11
			end

			if arg_88_1.time_ >= var_91_9 + var_91_10 and arg_88_1.time_ < var_91_9 + var_91_10 + arg_91_0 then
				local var_91_12 = Color.New(0, 0, 0)

				arg_88_1.mask_.enabled = false
				var_91_12.a = 0
				arg_88_1.mask_.color = var_91_12
			end

			local var_91_13 = "10054"

			if arg_88_1.actors_["10054"] == nil then
				local var_91_14 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10054")

				if not isNil(var_91_14) then
					local var_91_15 = Object.Instantiate(var_91_14, arg_88_1.canvasGo_.transform)

					var_91_15.transform:SetSiblingIndex(1)

					var_91_15.name = var_91_13
					var_91_15.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_88_1.actors_[var_91_13] = var_91_15

					if arg_88_1.isInRecall_ then
						for iter_91_2, iter_91_3 in ipairs((var_91_15:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_91_3.color = arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_91_16 = arg_88_1.actors_["10054"].transform

			if 3.73333333333333 < arg_88_1.time_ and arg_88_1.time_ <= 3.73333333333333 + arg_91_0 then
				arg_88_1.var_.moveOldPos10054 = var_91_16.localPosition
				var_91_16.localScale = Vector3.New(1, 1, 1)

				arg_88_1:CheckSpriteTmpPos("10054", 3)

				for iter_91_4 = 0, var_91_16.childCount - 1 do
					local var_91_17 = var_91_16:GetChild(iter_91_4)

					if var_91_17.name == "split_4" or not string.find(var_91_17.name, "split") then
						var_91_17.gameObject:SetActive(true)
					else
						var_91_17.gameObject:SetActive(false)
					end
				end
			end

			local var_91_18 = 0.001

			if 3.73333333333333 <= arg_88_1.time_ and arg_88_1.time_ < 3.73333333333333 + var_91_18 then
				var_91_16.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos10054, Vector3.New(0, -331.1, -274.72), (arg_88_1.time_ - 3.73333333333333) / var_91_18)
			end

			if arg_88_1.time_ >= 3.73333333333333 + var_91_18 and arg_88_1.time_ < 3.73333333333333 + var_91_18 + arg_91_0 then
				var_91_16.localPosition = Vector3.New(0, -331.1, -274.72)
			end

			local var_91_19 = arg_88_1.actors_["10054"]

			if 3.73333333333333 < arg_88_1.time_ and arg_88_1.time_ <= 3.73333333333333 + arg_91_0 and not isNil(var_91_19) and arg_88_1.var_.actorSpriteComps10054 == nil then
				arg_88_1.var_.actorSpriteComps10054 = var_91_19:GetComponentsInChildren(typeof(Image), true)
			end

			local var_91_20 = 0.125

			if 3.73333333333333 <= arg_88_1.time_ and arg_88_1.time_ < 3.73333333333333 + var_91_20 and not isNil(var_91_19) then
				if arg_88_1.var_.actorSpriteComps10054 then
					for iter_91_5, iter_91_6 in pairs(arg_88_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_91_6 then
							if arg_88_1.isInRecall_ then
								iter_91_6.color = Color.New(Mathf.Lerp(iter_91_6.color.r, arg_88_1.hightColor1.r, (arg_88_1.time_ - 3.73333333333333) / var_91_20), Mathf.Lerp(iter_91_6.color.g, arg_88_1.hightColor1.g, (arg_88_1.time_ - 3.73333333333333) / var_91_20), (Mathf.Lerp(iter_91_6.color.b, arg_88_1.hightColor1.b, (arg_88_1.time_ - 3.73333333333333) / var_91_20)))
							else
								local var_91_21 = Mathf.Lerp(iter_91_6.color.r, 1, (arg_88_1.time_ - 3.73333333333333) / var_91_20)

								iter_91_6.color = Color.New(var_91_21, var_91_21, var_91_21)
							end
						end
					end
				end
			end

			if arg_88_1.time_ >= 3.73333333333333 + var_91_20 and arg_88_1.time_ < 3.73333333333333 + var_91_20 + arg_91_0 and not isNil(var_91_19) and arg_88_1.var_.actorSpriteComps10054 then
				for iter_91_7, iter_91_8 in pairs(arg_88_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_91_8 then
						iter_91_8.color = arg_88_1.isInRecall_ and (arg_88_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_88_1.var_.actorSpriteComps10054 = nil
			end

			if 3.73333333333333 < arg_88_1.time_ and arg_88_1.time_ <= 3.73333333333333 + arg_91_0 then
				local var_91_22 = arg_88_1.actors_["10054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_91_22 then
					arg_88_1.var_.alphaOldValue10054 = var_91_22.alpha
					arg_88_1.var_.characterEffect10054 = var_91_22
				end

				arg_88_1.var_.alphaOldValue10054 = 0
			end

			local var_91_23 = 0.4

			if 3.73333333333333 <= arg_88_1.time_ and arg_88_1.time_ < 3.73333333333333 + var_91_23 then
				if arg_88_1.var_.characterEffect10054 then
					arg_88_1.var_.characterEffect10054.alpha = Mathf.Lerp(arg_88_1.var_.alphaOldValue10054, 1, (arg_88_1.time_ - 3.73333333333333) / var_91_23)
				end
			end

			if arg_88_1.time_ >= 3.73333333333333 + var_91_23 and arg_88_1.time_ < 3.73333333333333 + var_91_23 + arg_91_0 and arg_88_1.var_.characterEffect10054 then
				arg_88_1.var_.characterEffect10054.alpha = 1
			end

			if 2 < arg_88_1.time_ and arg_88_1.time_ <= 2 + arg_91_0 then
				if arg_88_1.var_.effect51003 then
					Object.Destroy(arg_88_1.var_.effect51003)

					arg_88_1.var_.effect51003 = nil
				end
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_91_27 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_27 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_27

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_27
						arg_88_1.bgmTxt2_.text = var_91_27
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2.3 < arg_88_1.time_ and arg_88_1.time_ <= 2.3 + arg_91_0 then
				arg_88_1:AudioAction("play", "music", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg.awb")

				local var_91_30 = manager.audio:GetAudioName("bgm_activity_3_8_story_corg", "bgm_activity_3_8_story_corg")

				if "" ~= "" then
					if arg_88_1.bgmTxt_.text ~= var_91_30 and arg_88_1.bgmTxt_.text ~= "" then
						if arg_88_1.bgmTxt2_.text ~= "" then
							arg_88_1.bgmTxt_.text = arg_88_1.bgmTxt2_.text
						end

						arg_88_1.bgmTxt2_.text = var_91_30

						arg_88_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_88_1.bgmTxt_.text = var_91_30
						arg_88_1.bgmTxt2_.text = var_91_30
					end

					if arg_88_1.bgmTimer then
						arg_88_1.bgmTimer:Stop()

						arg_88_1.bgmTimer = nil
					end

					if arg_88_1.settingData.show_music_name == 1 then
						arg_88_1.musicController:SetSelectedState("show")
						arg_88_1.musicAnimator_:Play("open", 0, 0)

						if arg_88_1.settingData.music_time ~= 0 then
							arg_88_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_88_1.settingData.music_time), function()
								if arg_88_1 == nil or isNil(arg_88_1.bgmTxt_) then
									return
								end

								arg_88_1.musicController:SetSelectedState("hide")
								arg_88_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_88_1.frameCnt_ <= 1 then
				arg_88_1.dialog_:SetActive(false)
			end

			local var_91_31 = 4
			local var_91_32 = 0.525

			if 4 < arg_88_1.time_ and arg_88_1.time_ <= var_91_31 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0

				arg_88_1.dialog_:SetActive(true)

				arg_88_1.dialogCg_.alpha = 0

				local var_91_33 = LeanTween.value(arg_88_1.dialog_, 0, 1, 0.3)

				var_91_33:setOnUpdate(LuaHelper.FloatAction(function(arg_94_0)
					arg_88_1.dialogCg_.alpha = arg_94_0
				end))
				var_91_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_88_1.dialog_)
					var_91_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_88_1.duration_ = arg_88_1.duration_ + 0.3

				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_34 = arg_88_1:GetWordFromCfg(416051021)
				local var_91_35 = arg_88_1:FormatText(var_91_34.content)

				arg_88_1.text_.text = var_91_35

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_37 = 19 <= 0 and var_91_32 or var_91_32 * (utf8.len(var_91_35) / 19)

				if (19 <= 0 and var_91_32 or var_91_32 * (utf8.len(var_91_35) / 19)) > 0 and var_91_32 < var_91_37 then
					arg_88_1.talkMaxDuration = var_91_37
					var_91_31 = var_91_31 + 0.3

					if var_91_37 + var_91_31 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_37 + var_91_31
					end
				end

				arg_88_1.text_.text = var_91_35
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051021", "story_v_out_416051.awb") ~= 0 then
					local var_91_38 = manager.audio:GetVoiceLength("story_v_out_416051", "416051021", "story_v_out_416051.awb") / 1000

					if var_91_38 + var_91_31 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_38 + var_91_31
					end

					if var_91_34.prefab_name ~= "" and arg_88_1.actors_[var_91_34.prefab_name] ~= nil then
						local var_91_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_34.prefab_name].transform, "story_v_out_416051", "416051021", "story_v_out_416051.awb")

						arg_88_1:RecordAudio("416051021", var_91_39)
						arg_88_1:RecordAudio("416051021", var_91_39)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_416051", "416051021", "story_v_out_416051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_416051", "416051021", "story_v_out_416051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_40 = var_91_31 + 0.3
			local var_91_41 = math.max(var_91_32, arg_88_1.talkMaxDuration)

			if var_91_31 + 0.3 <= arg_88_1.time_ and arg_88_1.time_ < var_91_40 + var_91_41 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_40) / var_91_41

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_40 + var_91_41 and arg_88_1.time_ < var_91_40 + var_91_41 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play416051022 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 416051022
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play416051023(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos10054 = arg_96_1.actors_["10054"].transform.localPosition
				arg_96_1.actors_["10054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_96_1:CheckSpriteTmpPos("10054", 7)

				for iter_99_0 = 0, arg_96_1.actors_["10054"].transform.childCount - 1 do
					local var_99_0 = arg_96_1.actors_["10054"].transform:GetChild(iter_99_0)

					if var_99_0.name == "" or not string.find(var_99_0.name, "split") then
						var_99_0.gameObject:SetActive(true)
					else
						var_99_0.gameObject:SetActive(false)
					end
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["10054"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos10054, Vector3.New(0, -2000, 0), (arg_96_1.time_ - 0) / var_99_1)
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["10054"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_99_2 = 0
			local var_99_3 = 2

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(416051022).content)

				arg_96_1.text_.text = var_99_4

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_6 = 80 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 80)

				if (80 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_4) / 80)) > 0 and var_99_3 < var_99_6 then
					arg_96_1.talkMaxDuration = var_99_6

					if var_99_6 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_6 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_4
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_7 and arg_96_1.time_ < var_99_2 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_96_1:InitPlayNodeList()
	end,
	Play416051023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 416051023
		arg_100_1.duration_ = 6.83

		local var_100_0 = {
			zh = 3.666,
			ja = 6.833
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
				arg_100_0:Play416051024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos10054 = arg_100_1.actors_["10054"].transform.localPosition
				arg_100_1.actors_["10054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_100_1:CheckSpriteTmpPos("10054", 3)

				for iter_103_0 = 0, arg_100_1.actors_["10054"].transform.childCount - 1 do
					local var_103_0 = arg_100_1.actors_["10054"].transform:GetChild(iter_103_0)

					if var_103_0.name == "" or not string.find(var_103_0.name, "split") then
						var_103_0.gameObject:SetActive(true)
					else
						var_103_0.gameObject:SetActive(false)
					end
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["10054"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos10054, Vector3.New(0, -331.1, -274.72), (arg_100_1.time_ - 0) / var_103_1)
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["10054"].transform.localPosition = Vector3.New(0, -331.1, -274.72)
			end

			local var_103_2 = arg_100_1.actors_["10054"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps10054 == nil then
				arg_100_1.var_.actorSpriteComps10054 = var_103_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_103_3 = 0.125

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.actorSpriteComps10054 then
					for iter_103_1, iter_103_2 in pairs(arg_100_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_103_2 then
							if arg_100_1.isInRecall_ then
								iter_103_2.color = Color.New(Mathf.Lerp(iter_103_2.color.r, arg_100_1.hightColor1.r, (arg_100_1.time_ - 0) / var_103_3), Mathf.Lerp(iter_103_2.color.g, arg_100_1.hightColor1.g, (arg_100_1.time_ - 0) / var_103_3), (Mathf.Lerp(iter_103_2.color.b, arg_100_1.hightColor1.b, (arg_100_1.time_ - 0) / var_103_3)))
							else
								local var_103_4 = Mathf.Lerp(iter_103_2.color.r, 1, (arg_100_1.time_ - 0) / var_103_3)

								iter_103_2.color = Color.New(var_103_4, var_103_4, var_103_4)
							end
						end
					end
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.actorSpriteComps10054 then
				for iter_103_3, iter_103_4 in pairs(arg_100_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_103_4 then
						iter_103_4.color = arg_100_1.isInRecall_ and (arg_100_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_100_1.var_.actorSpriteComps10054 = nil
			end

			local var_103_5 = 0
			local var_103_6 = 0.5

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_5 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_7 = arg_100_1:GetWordFromCfg(416051023)
				local var_103_8 = arg_100_1:FormatText(var_103_7.content)

				arg_100_1.text_.text = var_103_8

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_10 = 20 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 20)

				if (20 <= 0 and var_103_6 or var_103_6 * (utf8.len(var_103_8) / 20)) > 0 and var_103_6 < var_103_10 then
					arg_100_1.talkMaxDuration = var_103_10

					if var_103_10 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_5
					end
				end

				arg_100_1.text_.text = var_103_8
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051023", "story_v_out_416051.awb") ~= 0 then
					local var_103_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051023", "story_v_out_416051.awb") / 1000

					if var_103_11 + var_103_5 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_11 + var_103_5
					end

					if var_103_7.prefab_name ~= "" and arg_100_1.actors_[var_103_7.prefab_name] ~= nil then
						local var_103_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_7.prefab_name].transform, "story_v_out_416051", "416051023", "story_v_out_416051.awb")

						arg_100_1:RecordAudio("416051023", var_103_12)
						arg_100_1:RecordAudio("416051023", var_103_12)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_416051", "416051023", "story_v_out_416051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_416051", "416051023", "story_v_out_416051.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_13 = math.max(var_103_6, arg_100_1.talkMaxDuration)

			if var_103_5 <= arg_100_1.time_ and arg_100_1.time_ < var_103_5 + var_103_13 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_5) / var_103_13

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_5 + var_103_13 and arg_100_1.time_ < var_103_5 + var_103_13 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_100_1:InitPlayNodeList()
	end,
	Play416051024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 416051024
		arg_104_1.duration_ = 9.83

		local var_104_0 = {
			zh = 5.666,
			ja = 9.833
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
				arg_104_0:Play416051025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos10054 = arg_104_1.actors_["10054"].transform.localPosition
				arg_104_1.actors_["10054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("10054", 2)

				for iter_107_0 = 0, arg_104_1.actors_["10054"].transform.childCount - 1 do
					local var_107_0 = arg_104_1.actors_["10054"].transform:GetChild(iter_107_0)

					if var_107_0.name == "" or not string.find(var_107_0.name, "split") then
						var_107_0.gameObject:SetActive(true)
					else
						var_107_0.gameObject:SetActive(false)
					end
				end
			end

			local var_107_1 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_1 then
				arg_104_1.actors_["10054"].transform.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos10054, Vector3.New(-390, -331.1, -274.72), (arg_104_1.time_ - 0) / var_107_1)
			end

			if arg_104_1.time_ >= 0 + var_107_1 and arg_104_1.time_ < 0 + var_107_1 + arg_107_0 then
				arg_104_1.actors_["10054"].transform.localPosition = Vector3.New(-390, -331.1, -274.72)
			end

			local var_107_2 = "1033"

			if arg_104_1.actors_["1033"] == nil then
				local var_107_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1033")

				if not isNil(var_107_3) then
					local var_107_4 = Object.Instantiate(var_107_3, arg_104_1.canvasGo_.transform)

					var_107_4.transform:SetSiblingIndex(1)

					var_107_4.name = var_107_2
					var_107_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_104_1.actors_[var_107_2] = var_107_4

					if arg_104_1.isInRecall_ then
						for iter_107_1, iter_107_2 in ipairs((var_107_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_107_2.color = arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_107_5 = arg_104_1.actors_["1033"].transform

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.var_.moveOldPos1033 = var_107_5.localPosition
				var_107_5.localScale = Vector3.New(1, 1, 1)

				arg_104_1:CheckSpriteTmpPos("1033", 4)

				for iter_107_3 = 0, var_107_5.childCount - 1 do
					local var_107_6 = var_107_5:GetChild(iter_107_3)

					if var_107_6.name == "split_6" or not string.find(var_107_6.name, "split") then
						var_107_6.gameObject:SetActive(true)
					else
						var_107_6.gameObject:SetActive(false)
					end
				end
			end

			local var_107_7 = 0.001

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				var_107_5.localPosition = Vector3.Lerp(arg_104_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_104_1.time_ - 0) / var_107_7)
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				var_107_5.localPosition = Vector3.New(390, -420, 0)
			end

			local var_107_8 = arg_104_1.actors_["1033"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps1033 == nil then
				arg_104_1.var_.actorSpriteComps1033 = var_107_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_9 = 0.125

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_9 and not isNil(var_107_8) then
				if arg_104_1.var_.actorSpriteComps1033 then
					for iter_107_4, iter_107_5 in pairs(arg_104_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_107_5 then
							if arg_104_1.isInRecall_ then
								iter_107_5.color = Color.New(Mathf.Lerp(iter_107_5.color.r, arg_104_1.hightColor1.r, (arg_104_1.time_ - 0) / var_107_9), Mathf.Lerp(iter_107_5.color.g, arg_104_1.hightColor1.g, (arg_104_1.time_ - 0) / var_107_9), (Mathf.Lerp(iter_107_5.color.b, arg_104_1.hightColor1.b, (arg_104_1.time_ - 0) / var_107_9)))
							else
								local var_107_10 = Mathf.Lerp(iter_107_5.color.r, 1, (arg_104_1.time_ - 0) / var_107_9)

								iter_107_5.color = Color.New(var_107_10, var_107_10, var_107_10)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_9 and arg_104_1.time_ < 0 + var_107_9 + arg_107_0 and not isNil(var_107_8) and arg_104_1.var_.actorSpriteComps1033 then
				for iter_107_6, iter_107_7 in pairs(arg_104_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_107_7 then
						iter_107_7.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_104_1.var_.actorSpriteComps1033 = nil
			end

			local var_107_11 = arg_104_1.actors_["10054"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.actorSpriteComps10054 == nil then
				arg_104_1.var_.actorSpriteComps10054 = var_107_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_107_12 = 0.125

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_12 and not isNil(var_107_11) then
				if arg_104_1.var_.actorSpriteComps10054 then
					for iter_107_8, iter_107_9 in pairs(arg_104_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_107_9 then
							if arg_104_1.isInRecall_ then
								iter_107_9.color = Color.New(Mathf.Lerp(iter_107_9.color.r, arg_104_1.hightColor2.r, (arg_104_1.time_ - 0) / var_107_12), Mathf.Lerp(iter_107_9.color.g, arg_104_1.hightColor2.g, (arg_104_1.time_ - 0) / var_107_12), (Mathf.Lerp(iter_107_9.color.b, arg_104_1.hightColor2.b, (arg_104_1.time_ - 0) / var_107_12)))
							else
								local var_107_13 = Mathf.Lerp(iter_107_9.color.r, 0.5, (arg_104_1.time_ - 0) / var_107_12)

								iter_107_9.color = Color.New(var_107_13, var_107_13, var_107_13)
							end
						end
					end
				end
			end

			if arg_104_1.time_ >= 0 + var_107_12 and arg_104_1.time_ < 0 + var_107_12 + arg_107_0 and not isNil(var_107_11) and arg_104_1.var_.actorSpriteComps10054 then
				for iter_107_10, iter_107_11 in pairs(arg_104_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_107_11 then
						iter_107_11.color = arg_104_1.isInRecall_ and (arg_104_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_104_1.var_.actorSpriteComps10054 = nil
			end

			local var_107_14 = 0
			local var_107_15 = 0.85

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_14 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_16 = arg_104_1:GetWordFromCfg(416051024)
				local var_107_17 = arg_104_1:FormatText(var_107_16.content)

				arg_104_1.text_.text = var_107_17

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_19 = 34 <= 0 and var_107_15 or var_107_15 * (utf8.len(var_107_17) / 34)

				if (34 <= 0 and var_107_15 or var_107_15 * (utf8.len(var_107_17) / 34)) > 0 and var_107_15 < var_107_19 then
					arg_104_1.talkMaxDuration = var_107_19

					if var_107_19 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_19 + var_107_14
					end
				end

				arg_104_1.text_.text = var_107_17
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051024", "story_v_out_416051.awb") ~= 0 then
					local var_107_20 = manager.audio:GetVoiceLength("story_v_out_416051", "416051024", "story_v_out_416051.awb") / 1000

					if var_107_20 + var_107_14 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_20 + var_107_14
					end

					if var_107_16.prefab_name ~= "" and arg_104_1.actors_[var_107_16.prefab_name] ~= nil then
						local var_107_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_16.prefab_name].transform, "story_v_out_416051", "416051024", "story_v_out_416051.awb")

						arg_104_1:RecordAudio("416051024", var_107_21)
						arg_104_1:RecordAudio("416051024", var_107_21)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_416051", "416051024", "story_v_out_416051.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_416051", "416051024", "story_v_out_416051.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_22 = math.max(var_107_15, arg_104_1.talkMaxDuration)

			if var_107_14 <= arg_104_1.time_ and arg_104_1.time_ < var_107_14 + var_107_22 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_14) / var_107_22

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_14 + var_107_22 and arg_104_1.time_ < var_107_14 + var_107_22 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_104_1:InitPlayNodeList()
	end,
	Play416051025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 416051025
		arg_108_1.duration_ = 5.43

		local var_108_0 = {
			zh = 3.4,
			ja = 5.433
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play416051026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1033"]) and arg_108_1.var_.actorSpriteComps1033 == nil then
				arg_108_1.var_.actorSpriteComps1033 = arg_108_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_0 = 0.125

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1033"]) then
				if arg_108_1.var_.actorSpriteComps1033 then
					for iter_111_0, iter_111_1 in pairs(arg_108_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_111_1 then
							if arg_108_1.isInRecall_ then
								iter_111_1.color = Color.New(Mathf.Lerp(iter_111_1.color.r, arg_108_1.hightColor2.r, (arg_108_1.time_ - 0) / var_111_0), Mathf.Lerp(iter_111_1.color.g, arg_108_1.hightColor2.g, (arg_108_1.time_ - 0) / var_111_0), (Mathf.Lerp(iter_111_1.color.b, arg_108_1.hightColor2.b, (arg_108_1.time_ - 0) / var_111_0)))
							else
								local var_111_1 = Mathf.Lerp(iter_111_1.color.r, 0.5, (arg_108_1.time_ - 0) / var_111_0)

								iter_111_1.color = Color.New(var_111_1, var_111_1, var_111_1)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1033"]) and arg_108_1.var_.actorSpriteComps1033 then
				for iter_111_2, iter_111_3 in pairs(arg_108_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_111_3 then
						iter_111_3.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_108_1.var_.actorSpriteComps1033 = nil
			end

			local var_111_2 = arg_108_1.actors_["10054"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10054 == nil then
				arg_108_1.var_.actorSpriteComps10054 = var_111_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_111_3 = 0.125

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.actorSpriteComps10054 then
					for iter_111_4, iter_111_5 in pairs(arg_108_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_111_5 then
							if arg_108_1.isInRecall_ then
								iter_111_5.color = Color.New(Mathf.Lerp(iter_111_5.color.r, arg_108_1.hightColor1.r, (arg_108_1.time_ - 0) / var_111_3), Mathf.Lerp(iter_111_5.color.g, arg_108_1.hightColor1.g, (arg_108_1.time_ - 0) / var_111_3), (Mathf.Lerp(iter_111_5.color.b, arg_108_1.hightColor1.b, (arg_108_1.time_ - 0) / var_111_3)))
							else
								local var_111_4 = Mathf.Lerp(iter_111_5.color.r, 1, (arg_108_1.time_ - 0) / var_111_3)

								iter_111_5.color = Color.New(var_111_4, var_111_4, var_111_4)
							end
						end
					end
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.actorSpriteComps10054 then
				for iter_111_6, iter_111_7 in pairs(arg_108_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_111_7 then
						iter_111_7.color = arg_108_1.isInRecall_ and (arg_108_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_108_1.var_.actorSpriteComps10054 = nil
			end

			local var_111_5 = 0
			local var_111_6 = 0.475

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_5 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_7 = arg_108_1:GetWordFromCfg(416051025)
				local var_111_8 = arg_108_1:FormatText(var_111_7.content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 19 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 19)

				if (19 <= 0 and var_111_6 or var_111_6 * (utf8.len(var_111_8) / 19)) > 0 and var_111_6 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_5
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051025", "story_v_out_416051.awb") ~= 0 then
					local var_111_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051025", "story_v_out_416051.awb") / 1000

					if var_111_11 + var_111_5 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_11 + var_111_5
					end

					if var_111_7.prefab_name ~= "" and arg_108_1.actors_[var_111_7.prefab_name] ~= nil then
						local var_111_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_7.prefab_name].transform, "story_v_out_416051", "416051025", "story_v_out_416051.awb")

						arg_108_1:RecordAudio("416051025", var_111_12)
						arg_108_1:RecordAudio("416051025", var_111_12)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_416051", "416051025", "story_v_out_416051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_416051", "416051025", "story_v_out_416051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_13 = math.max(var_111_6, arg_108_1.talkMaxDuration)

			if var_111_5 <= arg_108_1.time_ and arg_108_1.time_ < var_111_5 + var_111_13 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_5) / var_111_13

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_5 + var_111_13 and arg_108_1.time_ < var_111_5 + var_111_13 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play416051026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 416051026
		arg_112_1.duration_ = 10.07

		local var_112_0 = {
			zh = 6.766,
			ja = 10.066
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
				arg_112_0:Play416051027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["1033"]) and arg_112_1.var_.actorSpriteComps1033 == nil then
				arg_112_1.var_.actorSpriteComps1033 = arg_112_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_0 = 0.125

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["1033"]) then
				if arg_112_1.var_.actorSpriteComps1033 then
					for iter_115_0, iter_115_1 in pairs(arg_112_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_115_1 then
							if arg_112_1.isInRecall_ then
								iter_115_1.color = Color.New(Mathf.Lerp(iter_115_1.color.r, arg_112_1.hightColor1.r, (arg_112_1.time_ - 0) / var_115_0), Mathf.Lerp(iter_115_1.color.g, arg_112_1.hightColor1.g, (arg_112_1.time_ - 0) / var_115_0), (Mathf.Lerp(iter_115_1.color.b, arg_112_1.hightColor1.b, (arg_112_1.time_ - 0) / var_115_0)))
							else
								local var_115_1 = Mathf.Lerp(iter_115_1.color.r, 1, (arg_112_1.time_ - 0) / var_115_0)

								iter_115_1.color = Color.New(var_115_1, var_115_1, var_115_1)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["1033"]) and arg_112_1.var_.actorSpriteComps1033 then
				for iter_115_2, iter_115_3 in pairs(arg_112_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_115_3 then
						iter_115_3.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_112_1.var_.actorSpriteComps1033 = nil
			end

			local var_115_2 = arg_112_1.actors_["10054"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps10054 == nil then
				arg_112_1.var_.actorSpriteComps10054 = var_115_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_115_3 = 0.125

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.actorSpriteComps10054 then
					for iter_115_4, iter_115_5 in pairs(arg_112_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_115_5 then
							if arg_112_1.isInRecall_ then
								iter_115_5.color = Color.New(Mathf.Lerp(iter_115_5.color.r, arg_112_1.hightColor2.r, (arg_112_1.time_ - 0) / var_115_3), Mathf.Lerp(iter_115_5.color.g, arg_112_1.hightColor2.g, (arg_112_1.time_ - 0) / var_115_3), (Mathf.Lerp(iter_115_5.color.b, arg_112_1.hightColor2.b, (arg_112_1.time_ - 0) / var_115_3)))
							else
								local var_115_4 = Mathf.Lerp(iter_115_5.color.r, 0.5, (arg_112_1.time_ - 0) / var_115_3)

								iter_115_5.color = Color.New(var_115_4, var_115_4, var_115_4)
							end
						end
					end
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.actorSpriteComps10054 then
				for iter_115_6, iter_115_7 in pairs(arg_112_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_115_7 then
						iter_115_7.color = arg_112_1.isInRecall_ and (arg_112_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_112_1.var_.actorSpriteComps10054 = nil
			end

			local var_115_5 = 0
			local var_115_6 = 0.7

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_5 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_7 = arg_112_1:GetWordFromCfg(416051026)
				local var_115_8 = arg_112_1:FormatText(var_115_7.content)

				arg_112_1.text_.text = var_115_8

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_10 = 28 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 28)

				if (28 <= 0 and var_115_6 or var_115_6 * (utf8.len(var_115_8) / 28)) > 0 and var_115_6 < var_115_10 then
					arg_112_1.talkMaxDuration = var_115_10

					if var_115_10 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_5
					end
				end

				arg_112_1.text_.text = var_115_8
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051026", "story_v_out_416051.awb") ~= 0 then
					local var_115_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051026", "story_v_out_416051.awb") / 1000

					if var_115_11 + var_115_5 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_11 + var_115_5
					end

					if var_115_7.prefab_name ~= "" and arg_112_1.actors_[var_115_7.prefab_name] ~= nil then
						local var_115_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_7.prefab_name].transform, "story_v_out_416051", "416051026", "story_v_out_416051.awb")

						arg_112_1:RecordAudio("416051026", var_115_12)
						arg_112_1:RecordAudio("416051026", var_115_12)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_416051", "416051026", "story_v_out_416051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_416051", "416051026", "story_v_out_416051.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_6, arg_112_1.talkMaxDuration)

			if var_115_5 <= arg_112_1.time_ and arg_112_1.time_ < var_115_5 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_5) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_5 + var_115_13 and arg_112_1.time_ < var_115_5 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play416051027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 416051027
		arg_116_1.duration_ = 3.13

		local var_116_0 = {
			zh = 2.8,
			ja = 3.133
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play416051028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1033"]) and arg_116_1.var_.actorSpriteComps1033 == nil then
				arg_116_1.var_.actorSpriteComps1033 = arg_116_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_0 = 0.125

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1033"]) then
				if arg_116_1.var_.actorSpriteComps1033 then
					for iter_119_0, iter_119_1 in pairs(arg_116_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_119_1 then
							if arg_116_1.isInRecall_ then
								iter_119_1.color = Color.New(Mathf.Lerp(iter_119_1.color.r, arg_116_1.hightColor2.r, (arg_116_1.time_ - 0) / var_119_0), Mathf.Lerp(iter_119_1.color.g, arg_116_1.hightColor2.g, (arg_116_1.time_ - 0) / var_119_0), (Mathf.Lerp(iter_119_1.color.b, arg_116_1.hightColor2.b, (arg_116_1.time_ - 0) / var_119_0)))
							else
								local var_119_1 = Mathf.Lerp(iter_119_1.color.r, 0.5, (arg_116_1.time_ - 0) / var_119_0)

								iter_119_1.color = Color.New(var_119_1, var_119_1, var_119_1)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1033"]) and arg_116_1.var_.actorSpriteComps1033 then
				for iter_119_2, iter_119_3 in pairs(arg_116_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_119_3 then
						iter_119_3.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_116_1.var_.actorSpriteComps1033 = nil
			end

			local var_119_2 = arg_116_1.actors_["10054"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps10054 == nil then
				arg_116_1.var_.actorSpriteComps10054 = var_119_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_119_3 = 0.125

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.actorSpriteComps10054 then
					for iter_119_4, iter_119_5 in pairs(arg_116_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_119_5 then
							if arg_116_1.isInRecall_ then
								iter_119_5.color = Color.New(Mathf.Lerp(iter_119_5.color.r, arg_116_1.hightColor1.r, (arg_116_1.time_ - 0) / var_119_3), Mathf.Lerp(iter_119_5.color.g, arg_116_1.hightColor1.g, (arg_116_1.time_ - 0) / var_119_3), (Mathf.Lerp(iter_119_5.color.b, arg_116_1.hightColor1.b, (arg_116_1.time_ - 0) / var_119_3)))
							else
								local var_119_4 = Mathf.Lerp(iter_119_5.color.r, 1, (arg_116_1.time_ - 0) / var_119_3)

								iter_119_5.color = Color.New(var_119_4, var_119_4, var_119_4)
							end
						end
					end
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.actorSpriteComps10054 then
				for iter_119_6, iter_119_7 in pairs(arg_116_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_119_7 then
						iter_119_7.color = arg_116_1.isInRecall_ and (arg_116_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_116_1.var_.actorSpriteComps10054 = nil
			end

			local var_119_5 = 0
			local var_119_6 = 0.225

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_5 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_7 = arg_116_1:GetWordFromCfg(416051027)
				local var_119_8 = arg_116_1:FormatText(var_119_7.content)

				arg_116_1.text_.text = var_119_8

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_10 = 9 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_8) / 9)

				if (9 <= 0 and var_119_6 or var_119_6 * (utf8.len(var_119_8) / 9)) > 0 and var_119_6 < var_119_10 then
					arg_116_1.talkMaxDuration = var_119_10

					if var_119_10 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_5
					end
				end

				arg_116_1.text_.text = var_119_8
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051027", "story_v_out_416051.awb") ~= 0 then
					local var_119_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051027", "story_v_out_416051.awb") / 1000

					if var_119_11 + var_119_5 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_11 + var_119_5
					end

					if var_119_7.prefab_name ~= "" and arg_116_1.actors_[var_119_7.prefab_name] ~= nil then
						local var_119_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_7.prefab_name].transform, "story_v_out_416051", "416051027", "story_v_out_416051.awb")

						arg_116_1:RecordAudio("416051027", var_119_12)
						arg_116_1:RecordAudio("416051027", var_119_12)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_416051", "416051027", "story_v_out_416051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_416051", "416051027", "story_v_out_416051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_13 = math.max(var_119_6, arg_116_1.talkMaxDuration)

			if var_119_5 <= arg_116_1.time_ and arg_116_1.time_ < var_119_5 + var_119_13 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_5) / var_119_13

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_5 + var_119_13 and arg_116_1.time_ < var_119_5 + var_119_13 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play416051028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 416051028
		arg_120_1.duration_ = 6.87

		local var_120_0 = {
			zh = 6.333,
			ja = 6.866
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
				arg_120_0:Play416051029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["1033"]) and arg_120_1.var_.actorSpriteComps1033 == nil then
				arg_120_1.var_.actorSpriteComps1033 = arg_120_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.125

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["1033"]) then
				if arg_120_1.var_.actorSpriteComps1033 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor1.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor1.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor1.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 1, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["1033"]) and arg_120_1.var_.actorSpriteComps1033 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_120_1.var_.actorSpriteComps1033 = nil
			end

			local var_123_2 = arg_120_1.actors_["10054"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps10054 == nil then
				arg_120_1.var_.actorSpriteComps10054 = var_123_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_3 = 0.125

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.actorSpriteComps10054 then
					for iter_123_4, iter_123_5 in pairs(arg_120_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_123_5 then
							if arg_120_1.isInRecall_ then
								iter_123_5.color = Color.New(Mathf.Lerp(iter_123_5.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_3), Mathf.Lerp(iter_123_5.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_3), (Mathf.Lerp(iter_123_5.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_3)))
							else
								local var_123_4 = Mathf.Lerp(iter_123_5.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_3)

								iter_123_5.color = Color.New(var_123_4, var_123_4, var_123_4)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.actorSpriteComps10054 then
				for iter_123_6, iter_123_7 in pairs(arg_120_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_123_7 then
						iter_123_7.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps10054 = nil
			end

			local var_123_5 = 0
			local var_123_6 = 0.75

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_5 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_7 = arg_120_1:GetWordFromCfg(416051028)
				local var_123_8 = arg_120_1:FormatText(var_123_7.content)

				arg_120_1.text_.text = var_123_8

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_10 = 30 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 30)

				if (30 <= 0 and var_123_6 or var_123_6 * (utf8.len(var_123_8) / 30)) > 0 and var_123_6 < var_123_10 then
					arg_120_1.talkMaxDuration = var_123_10

					if var_123_10 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_10 + var_123_5
					end
				end

				arg_120_1.text_.text = var_123_8
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051028", "story_v_out_416051.awb") ~= 0 then
					local var_123_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051028", "story_v_out_416051.awb") / 1000

					if var_123_11 + var_123_5 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_11 + var_123_5
					end

					if var_123_7.prefab_name ~= "" and arg_120_1.actors_[var_123_7.prefab_name] ~= nil then
						local var_123_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_7.prefab_name].transform, "story_v_out_416051", "416051028", "story_v_out_416051.awb")

						arg_120_1:RecordAudio("416051028", var_123_12)
						arg_120_1:RecordAudio("416051028", var_123_12)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_416051", "416051028", "story_v_out_416051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_416051", "416051028", "story_v_out_416051.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_13 = math.max(var_123_6, arg_120_1.talkMaxDuration)

			if var_123_5 <= arg_120_1.time_ and arg_120_1.time_ < var_123_5 + var_123_13 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_5) / var_123_13

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_5 + var_123_13 and arg_120_1.time_ < var_123_5 + var_123_13 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play416051029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 416051029
		arg_124_1.duration_ = 5.1

		local var_124_0 = {
			zh = 4.9,
			ja = 5.1
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
				arg_124_0:Play416051030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1033"]) and arg_124_1.var_.actorSpriteComps1033 == nil then
				arg_124_1.var_.actorSpriteComps1033 = arg_124_1.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_0 = 0.125

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1033"]) then
				if arg_124_1.var_.actorSpriteComps1033 then
					for iter_127_0, iter_127_1 in pairs(arg_124_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_127_1 then
							if arg_124_1.isInRecall_ then
								iter_127_1.color = Color.New(Mathf.Lerp(iter_127_1.color.r, arg_124_1.hightColor2.r, (arg_124_1.time_ - 0) / var_127_0), Mathf.Lerp(iter_127_1.color.g, arg_124_1.hightColor2.g, (arg_124_1.time_ - 0) / var_127_0), (Mathf.Lerp(iter_127_1.color.b, arg_124_1.hightColor2.b, (arg_124_1.time_ - 0) / var_127_0)))
							else
								local var_127_1 = Mathf.Lerp(iter_127_1.color.r, 0.5, (arg_124_1.time_ - 0) / var_127_0)

								iter_127_1.color = Color.New(var_127_1, var_127_1, var_127_1)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1033"]) and arg_124_1.var_.actorSpriteComps1033 then
				for iter_127_2, iter_127_3 in pairs(arg_124_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_127_3 then
						iter_127_3.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_124_1.var_.actorSpriteComps1033 = nil
			end

			local var_127_2 = arg_124_1.actors_["10054"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps10054 == nil then
				arg_124_1.var_.actorSpriteComps10054 = var_127_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_127_3 = 0.125

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.actorSpriteComps10054 then
					for iter_127_4, iter_127_5 in pairs(arg_124_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_127_5 then
							if arg_124_1.isInRecall_ then
								iter_127_5.color = Color.New(Mathf.Lerp(iter_127_5.color.r, arg_124_1.hightColor1.r, (arg_124_1.time_ - 0) / var_127_3), Mathf.Lerp(iter_127_5.color.g, arg_124_1.hightColor1.g, (arg_124_1.time_ - 0) / var_127_3), (Mathf.Lerp(iter_127_5.color.b, arg_124_1.hightColor1.b, (arg_124_1.time_ - 0) / var_127_3)))
							else
								local var_127_4 = Mathf.Lerp(iter_127_5.color.r, 1, (arg_124_1.time_ - 0) / var_127_3)

								iter_127_5.color = Color.New(var_127_4, var_127_4, var_127_4)
							end
						end
					end
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.actorSpriteComps10054 then
				for iter_127_6, iter_127_7 in pairs(arg_124_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_127_7 then
						iter_127_7.color = arg_124_1.isInRecall_ and (arg_124_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_124_1.var_.actorSpriteComps10054 = nil
			end

			local var_127_5 = 0
			local var_127_6 = 0.325

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_5 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_7 = arg_124_1:GetWordFromCfg(416051029)
				local var_127_8 = arg_124_1:FormatText(var_127_7.content)

				arg_124_1.text_.text = var_127_8

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_10 = 13 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 13)

				if (13 <= 0 and var_127_6 or var_127_6 * (utf8.len(var_127_8) / 13)) > 0 and var_127_6 < var_127_10 then
					arg_124_1.talkMaxDuration = var_127_10

					if var_127_10 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_10 + var_127_5
					end
				end

				arg_124_1.text_.text = var_127_8
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051029", "story_v_out_416051.awb") ~= 0 then
					local var_127_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051029", "story_v_out_416051.awb") / 1000

					if var_127_11 + var_127_5 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_11 + var_127_5
					end

					if var_127_7.prefab_name ~= "" and arg_124_1.actors_[var_127_7.prefab_name] ~= nil then
						local var_127_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_7.prefab_name].transform, "story_v_out_416051", "416051029", "story_v_out_416051.awb")

						arg_124_1:RecordAudio("416051029", var_127_12)
						arg_124_1:RecordAudio("416051029", var_127_12)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_416051", "416051029", "story_v_out_416051.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_416051", "416051029", "story_v_out_416051.awb")
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
	Play416051030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 416051030
		arg_128_1.duration_ = 6.2

		local var_128_0 = {
			zh = 5.833,
			ja = 6.2
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
				arg_128_0:Play416051031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 4 < arg_128_1.time_ and arg_128_1.time_ <= 4 + arg_131_0 then
				arg_128_1.allBtn_.enabled = false
			end

			if arg_128_1.time_ >= 4 + 0.0666666666666669 and arg_128_1.time_ < 4 + 0.0666666666666669 + arg_131_0 then
				arg_128_1.allBtn_.enabled = true
			end

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= 2 + arg_131_0 then
				local var_131_0 = arg_128_1.bgs_.ST2101

				arg_128_1.bgs_.ST2101.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_131_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_131_1 = var_131_0:GetComponent("SpriteRenderer")

				if var_131_1 and var_131_1.sprite then
					local var_131_2 = 2 * (var_131_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_131_0.transform.localScale = Vector3.New(var_131_2 / var_131_1.sprite.bounds.size.y < var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x and var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x or var_131_2 / var_131_1.sprite.bounds.size.y, var_131_2 / var_131_1.sprite.bounds.size.y < var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x and var_131_2 * manager.ui.mainCameraCom_.aspect / var_131_1.sprite.bounds.size.x or var_131_2 / var_131_1.sprite.bounds.size.y, 0)
				end

				for iter_131_0, iter_131_1 in pairs(arg_128_1.bgs_) do
					if iter_131_0 ~= "ST2101" then
						iter_131_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_131_3 = 0

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_4 = 2

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_4 then
				local var_131_5 = Color.New(0, 0, 0)

				var_131_5.a = Mathf.Lerp(0, 1, (arg_128_1.time_ - var_131_3) / var_131_4)
				arg_128_1.mask_.color = var_131_5
			end

			if arg_128_1.time_ >= var_131_3 + var_131_4 and arg_128_1.time_ < var_131_3 + var_131_4 + arg_131_0 then
				local var_131_6 = Color.New(0, 0, 0)

				var_131_6.a = 1
				arg_128_1.mask_.color = var_131_6
			end

			local var_131_7 = 2

			if 2 < arg_128_1.time_ and arg_128_1.time_ <= var_131_7 + arg_131_0 then
				arg_128_1.mask_.enabled = true
				arg_128_1.mask_.raycastTarget = true

				arg_128_1:SetGaussion(false)
			end

			local var_131_8 = 2

			if var_131_7 <= arg_128_1.time_ and arg_128_1.time_ < var_131_7 + var_131_8 then
				local var_131_9 = Color.New(0, 0, 0)

				var_131_9.a = Mathf.Lerp(1, 0, (arg_128_1.time_ - var_131_7) / var_131_8)
				arg_128_1.mask_.color = var_131_9
			end

			if arg_128_1.time_ >= var_131_7 + var_131_8 and arg_128_1.time_ < var_131_7 + var_131_8 + arg_131_0 then
				local var_131_10 = Color.New(0, 0, 0)

				arg_128_1.mask_.enabled = false
				var_131_10.a = 0
				arg_128_1.mask_.color = var_131_10
			end

			local var_131_11 = arg_128_1.actors_["10054"].transform

			if 1.966 < arg_128_1.time_ and arg_128_1.time_ <= 1.966 + arg_131_0 then
				arg_128_1.var_.moveOldPos10054 = var_131_11.localPosition
				var_131_11.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10054", 7)

				for iter_131_2 = 0, var_131_11.childCount - 1 do
					local var_131_12 = var_131_11:GetChild(iter_131_2)

					if var_131_12.name == "" or not string.find(var_131_12.name, "split") then
						var_131_12.gameObject:SetActive(true)
					else
						var_131_12.gameObject:SetActive(false)
					end
				end
			end

			local var_131_13 = 0.001

			if 1.966 <= arg_128_1.time_ and arg_128_1.time_ < 1.966 + var_131_13 then
				var_131_11.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10054, Vector3.New(0, -2000, 0), (arg_128_1.time_ - 1.966) / var_131_13)
			end

			if arg_128_1.time_ >= 1.966 + var_131_13 and arg_128_1.time_ < 1.966 + var_131_13 + arg_131_0 then
				var_131_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_131_14 = arg_128_1.actors_["10054"].transform

			if 3.73333333333333 < arg_128_1.time_ and arg_128_1.time_ <= 3.73333333333333 + arg_131_0 then
				arg_128_1.var_.moveOldPos10054 = var_131_14.localPosition
				var_131_14.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("10054", 3)

				for iter_131_3 = 0, var_131_14.childCount - 1 do
					local var_131_15 = var_131_14:GetChild(iter_131_3)

					if var_131_15.name == "" or not string.find(var_131_15.name, "split") then
						var_131_15.gameObject:SetActive(true)
					else
						var_131_15.gameObject:SetActive(false)
					end
				end
			end

			local var_131_16 = 0.001

			if 3.73333333333333 <= arg_128_1.time_ and arg_128_1.time_ < 3.73333333333333 + var_131_16 then
				var_131_14.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos10054, Vector3.New(0, -331.1, -274.72), (arg_128_1.time_ - 3.73333333333333) / var_131_16)
			end

			if arg_128_1.time_ >= 3.73333333333333 + var_131_16 and arg_128_1.time_ < 3.73333333333333 + var_131_16 + arg_131_0 then
				var_131_14.localPosition = Vector3.New(0, -331.1, -274.72)
			end

			local var_131_17 = arg_128_1.actors_["1033"].transform

			if 1.966 < arg_128_1.time_ and arg_128_1.time_ <= 1.966 + arg_131_0 then
				arg_128_1.var_.moveOldPos1033 = var_131_17.localPosition
				var_131_17.localScale = Vector3.New(1, 1, 1)

				arg_128_1:CheckSpriteTmpPos("1033", 7)

				for iter_131_4 = 0, var_131_17.childCount - 1 do
					local var_131_18 = var_131_17:GetChild(iter_131_4)

					if var_131_18.name == "" or not string.find(var_131_18.name, "split") then
						var_131_18.gameObject:SetActive(true)
					else
						var_131_18.gameObject:SetActive(false)
					end
				end
			end

			local var_131_19 = 0.001

			if 1.966 <= arg_128_1.time_ and arg_128_1.time_ < 1.966 + var_131_19 then
				var_131_17.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_128_1.time_ - 1.966) / var_131_19)
			end

			if arg_128_1.time_ >= 1.966 + var_131_19 and arg_128_1.time_ < 1.966 + var_131_19 + arg_131_0 then
				var_131_17.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_131_20 = arg_128_1.actors_["10054"]

			if 3.73333333333333 < arg_128_1.time_ and arg_128_1.time_ <= 3.73333333333333 + arg_131_0 and not isNil(var_131_20) and arg_128_1.var_.actorSpriteComps10054 == nil then
				arg_128_1.var_.actorSpriteComps10054 = var_131_20:GetComponentsInChildren(typeof(Image), true)
			end

			local var_131_21 = 0.125

			if 3.73333333333333 <= arg_128_1.time_ and arg_128_1.time_ < 3.73333333333333 + var_131_21 and not isNil(var_131_20) then
				if arg_128_1.var_.actorSpriteComps10054 then
					for iter_131_5, iter_131_6 in pairs(arg_128_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_131_6 then
							if arg_128_1.isInRecall_ then
								iter_131_6.color = Color.New(Mathf.Lerp(iter_131_6.color.r, arg_128_1.hightColor1.r, (arg_128_1.time_ - 3.73333333333333) / var_131_21), Mathf.Lerp(iter_131_6.color.g, arg_128_1.hightColor1.g, (arg_128_1.time_ - 3.73333333333333) / var_131_21), (Mathf.Lerp(iter_131_6.color.b, arg_128_1.hightColor1.b, (arg_128_1.time_ - 3.73333333333333) / var_131_21)))
							else
								local var_131_22 = Mathf.Lerp(iter_131_6.color.r, 1, (arg_128_1.time_ - 3.73333333333333) / var_131_21)

								iter_131_6.color = Color.New(var_131_22, var_131_22, var_131_22)
							end
						end
					end
				end
			end

			if arg_128_1.time_ >= 3.73333333333333 + var_131_21 and arg_128_1.time_ < 3.73333333333333 + var_131_21 + arg_131_0 and not isNil(var_131_20) and arg_128_1.var_.actorSpriteComps10054 then
				for iter_131_7, iter_131_8 in pairs(arg_128_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_131_8 then
						iter_131_8.color = arg_128_1.isInRecall_ and (arg_128_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_128_1.var_.actorSpriteComps10054 = nil
			end

			if 3.73333333333333 < arg_128_1.time_ and arg_128_1.time_ <= 3.73333333333333 + arg_131_0 then
				local var_131_23 = arg_128_1.actors_["10054"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_131_23 then
					arg_128_1.var_.alphaOldValue10054 = var_131_23.alpha
					arg_128_1.var_.characterEffect10054 = var_131_23
				end

				arg_128_1.var_.alphaOldValue10054 = 0
			end

			local var_131_24 = 0.333333333333333

			if 3.73333333333333 <= arg_128_1.time_ and arg_128_1.time_ < 3.73333333333333 + var_131_24 then
				if arg_128_1.var_.characterEffect10054 then
					arg_128_1.var_.characterEffect10054.alpha = Mathf.Lerp(arg_128_1.var_.alphaOldValue10054, 1, (arg_128_1.time_ - 3.73333333333333) / var_131_24)
				end
			end

			if arg_128_1.time_ >= 3.73333333333333 + var_131_24 and arg_128_1.time_ < 3.73333333333333 + var_131_24 + arg_131_0 and arg_128_1.var_.characterEffect10054 then
				arg_128_1.var_.characterEffect10054.alpha = 1
			end

			if arg_128_1.frameCnt_ <= 1 then
				arg_128_1.dialog_:SetActive(false)
			end

			local var_131_25 = 4
			local var_131_26 = 0.15

			if 4 < arg_128_1.time_ and arg_128_1.time_ <= var_131_25 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0

				arg_128_1.dialog_:SetActive(true)

				arg_128_1.dialogCg_.alpha = 0

				local var_131_27 = LeanTween.value(arg_128_1.dialog_, 0, 1, 0.3)

				var_131_27:setOnUpdate(LuaHelper.FloatAction(function(arg_132_0)
					arg_128_1.dialogCg_.alpha = arg_132_0
				end))
				var_131_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_128_1.dialog_)
					var_131_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_128_1.duration_ = arg_128_1.duration_ + 0.3

				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_28 = arg_128_1:GetWordFromCfg(416051030)
				local var_131_29 = arg_128_1:FormatText(var_131_28.content)

				arg_128_1.text_.text = var_131_29

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_31 = 6 <= 0 and var_131_26 or var_131_26 * (utf8.len(var_131_29) / 6)

				if (6 <= 0 and var_131_26 or var_131_26 * (utf8.len(var_131_29) / 6)) > 0 and var_131_26 < var_131_31 then
					arg_128_1.talkMaxDuration = var_131_31
					var_131_25 = var_131_25 + 0.3

					if var_131_31 + var_131_25 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_31 + var_131_25
					end
				end

				arg_128_1.text_.text = var_131_29
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051030", "story_v_out_416051.awb") ~= 0 then
					local var_131_32 = manager.audio:GetVoiceLength("story_v_out_416051", "416051030", "story_v_out_416051.awb") / 1000

					if var_131_32 + var_131_25 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_32 + var_131_25
					end

					if var_131_28.prefab_name ~= "" and arg_128_1.actors_[var_131_28.prefab_name] ~= nil then
						local var_131_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_28.prefab_name].transform, "story_v_out_416051", "416051030", "story_v_out_416051.awb")

						arg_128_1:RecordAudio("416051030", var_131_33)
						arg_128_1:RecordAudio("416051030", var_131_33)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_416051", "416051030", "story_v_out_416051.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_416051", "416051030", "story_v_out_416051.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_34 = var_131_25 + 0.3
			local var_131_35 = math.max(var_131_26, arg_128_1.talkMaxDuration)

			if var_131_25 + 0.3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_34 + var_131_35 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_34) / var_131_35

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_34 + var_131_35 and arg_128_1.time_ < var_131_34 + var_131_35 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play416051031 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 416051031
		arg_134_1.duration_ = 9.83

		local var_134_0 = {
			zh = 6.366,
			ja = 9.833
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play416051032(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos10054 = arg_134_1.actors_["10054"].transform.localPosition
				arg_134_1.actors_["10054"].transform.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("10054", 2)

				for iter_137_0 = 0, arg_134_1.actors_["10054"].transform.childCount - 1 do
					local var_137_0 = arg_134_1.actors_["10054"].transform:GetChild(iter_137_0)

					if var_137_0.name == "" or not string.find(var_137_0.name, "split") then
						var_137_0.gameObject:SetActive(true)
					else
						var_137_0.gameObject:SetActive(false)
					end
				end
			end

			local var_137_1 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_1 then
				arg_134_1.actors_["10054"].transform.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos10054, Vector3.New(-390, -331.1, -274.72), (arg_134_1.time_ - 0) / var_137_1)
			end

			if arg_134_1.time_ >= 0 + var_137_1 and arg_134_1.time_ < 0 + var_137_1 + arg_137_0 then
				arg_134_1.actors_["10054"].transform.localPosition = Vector3.New(-390, -331.1, -274.72)
			end

			local var_137_2 = arg_134_1.actors_["10054"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps10054 == nil then
				arg_134_1.var_.actorSpriteComps10054 = var_137_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_3 = 0.125

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.actorSpriteComps10054 then
					for iter_137_1, iter_137_2 in pairs(arg_134_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_137_2 then
							if arg_134_1.isInRecall_ then
								iter_137_2.color = Color.New(Mathf.Lerp(iter_137_2.color.r, arg_134_1.hightColor2.r, (arg_134_1.time_ - 0) / var_137_3), Mathf.Lerp(iter_137_2.color.g, arg_134_1.hightColor2.g, (arg_134_1.time_ - 0) / var_137_3), (Mathf.Lerp(iter_137_2.color.b, arg_134_1.hightColor2.b, (arg_134_1.time_ - 0) / var_137_3)))
							else
								local var_137_4 = Mathf.Lerp(iter_137_2.color.r, 0.5, (arg_134_1.time_ - 0) / var_137_3)

								iter_137_2.color = Color.New(var_137_4, var_137_4, var_137_4)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.actorSpriteComps10054 then
				for iter_137_3, iter_137_4 in pairs(arg_134_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_137_4 then
						iter_137_4.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_134_1.var_.actorSpriteComps10054 = nil
			end

			local var_137_5 = arg_134_1.actors_["1033"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.actorSpriteComps1033 == nil then
				arg_134_1.var_.actorSpriteComps1033 = var_137_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_137_6 = 0.125

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_6 and not isNil(var_137_5) then
				if arg_134_1.var_.actorSpriteComps1033 then
					for iter_137_5, iter_137_6 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_137_6 then
							if arg_134_1.isInRecall_ then
								iter_137_6.color = Color.New(Mathf.Lerp(iter_137_6.color.r, arg_134_1.hightColor1.r, (arg_134_1.time_ - 0) / var_137_6), Mathf.Lerp(iter_137_6.color.g, arg_134_1.hightColor1.g, (arg_134_1.time_ - 0) / var_137_6), (Mathf.Lerp(iter_137_6.color.b, arg_134_1.hightColor1.b, (arg_134_1.time_ - 0) / var_137_6)))
							else
								local var_137_7 = Mathf.Lerp(iter_137_6.color.r, 1, (arg_134_1.time_ - 0) / var_137_6)

								iter_137_6.color = Color.New(var_137_7, var_137_7, var_137_7)
							end
						end
					end
				end
			end

			if arg_134_1.time_ >= 0 + var_137_6 and arg_134_1.time_ < 0 + var_137_6 + arg_137_0 and not isNil(var_137_5) and arg_134_1.var_.actorSpriteComps1033 then
				for iter_137_7, iter_137_8 in pairs(arg_134_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_137_8 then
						iter_137_8.color = arg_134_1.isInRecall_ and (arg_134_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_134_1.var_.actorSpriteComps1033 = nil
			end

			local var_137_8 = arg_134_1.actors_["1033"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1033 = var_137_8.localPosition
				var_137_8.localScale = Vector3.New(1, 1, 1)

				arg_134_1:CheckSpriteTmpPos("1033", 4)

				for iter_137_9 = 0, var_137_8.childCount - 1 do
					local var_137_9 = var_137_8:GetChild(iter_137_9)

					if var_137_9.name == "split_6" or not string.find(var_137_9.name, "split") then
						var_137_9.gameObject:SetActive(true)
					else
						var_137_9.gameObject:SetActive(false)
					end
				end
			end

			local var_137_10 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_10 then
				var_137_8.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1033, Vector3.New(390, -420, 0), (arg_134_1.time_ - 0) / var_137_10)
			end

			if arg_134_1.time_ >= 0 + var_137_10 and arg_134_1.time_ < 0 + var_137_10 + arg_137_0 then
				var_137_8.localPosition = Vector3.New(390, -420, 0)
			end

			local var_137_11 = 0
			local var_137_12 = 0.8

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_11 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_13 = arg_134_1:GetWordFromCfg(416051031)
				local var_137_14 = arg_134_1:FormatText(var_137_13.content)

				arg_134_1.text_.text = var_137_14

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_16 = 32 <= 0 and var_137_12 or var_137_12 * (utf8.len(var_137_14) / 32)

				if (32 <= 0 and var_137_12 or var_137_12 * (utf8.len(var_137_14) / 32)) > 0 and var_137_12 < var_137_16 then
					arg_134_1.talkMaxDuration = var_137_16

					if var_137_16 + var_137_11 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_16 + var_137_11
					end
				end

				arg_134_1.text_.text = var_137_14
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051031", "story_v_out_416051.awb") ~= 0 then
					local var_137_17 = manager.audio:GetVoiceLength("story_v_out_416051", "416051031", "story_v_out_416051.awb") / 1000

					if var_137_17 + var_137_11 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_17 + var_137_11
					end

					if var_137_13.prefab_name ~= "" and arg_134_1.actors_[var_137_13.prefab_name] ~= nil then
						local var_137_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_13.prefab_name].transform, "story_v_out_416051", "416051031", "story_v_out_416051.awb")

						arg_134_1:RecordAudio("416051031", var_137_18)
						arg_134_1:RecordAudio("416051031", var_137_18)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_416051", "416051031", "story_v_out_416051.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_416051", "416051031", "story_v_out_416051.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_19 = math.max(var_137_12, arg_134_1.talkMaxDuration)

			if var_137_11 <= arg_134_1.time_ and arg_134_1.time_ < var_137_11 + var_137_19 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_11) / var_137_19

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_11 + var_137_19 and arg_134_1.time_ < var_137_11 + var_137_19 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_134_1:InitPlayNodeList()
	end,
	Play416051032 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 416051032
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play416051033(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10054"]) and arg_138_1.var_.actorSpriteComps10054 == nil then
				arg_138_1.var_.actorSpriteComps10054 = arg_138_1.actors_["10054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_0 = 0.125

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10054"]) then
				if arg_138_1.var_.actorSpriteComps10054 then
					for iter_141_0, iter_141_1 in pairs(arg_138_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_141_1 then
							if arg_138_1.isInRecall_ then
								iter_141_1.color = Color.New(Mathf.Lerp(iter_141_1.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_0), Mathf.Lerp(iter_141_1.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_0), (Mathf.Lerp(iter_141_1.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_0)))
							else
								local var_141_1 = Mathf.Lerp(iter_141_1.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_0)

								iter_141_1.color = Color.New(var_141_1, var_141_1, var_141_1)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10054"]) and arg_138_1.var_.actorSpriteComps10054 then
				for iter_141_2, iter_141_3 in pairs(arg_138_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_141_3 then
						iter_141_3.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps10054 = nil
			end

			local var_141_2 = arg_138_1.actors_["1033"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1033 == nil then
				arg_138_1.var_.actorSpriteComps1033 = var_141_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_141_3 = 0.125

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.actorSpriteComps1033 then
					for iter_141_4, iter_141_5 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_141_5 then
							if arg_138_1.isInRecall_ then
								iter_141_5.color = Color.New(Mathf.Lerp(iter_141_5.color.r, arg_138_1.hightColor2.r, (arg_138_1.time_ - 0) / var_141_3), Mathf.Lerp(iter_141_5.color.g, arg_138_1.hightColor2.g, (arg_138_1.time_ - 0) / var_141_3), (Mathf.Lerp(iter_141_5.color.b, arg_138_1.hightColor2.b, (arg_138_1.time_ - 0) / var_141_3)))
							else
								local var_141_4 = Mathf.Lerp(iter_141_5.color.r, 0.5, (arg_138_1.time_ - 0) / var_141_3)

								iter_141_5.color = Color.New(var_141_4, var_141_4, var_141_4)
							end
						end
					end
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.actorSpriteComps1033 then
				for iter_141_6, iter_141_7 in pairs(arg_138_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_141_7 then
						iter_141_7.color = arg_138_1.isInRecall_ and (arg_138_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_138_1.var_.actorSpriteComps1033 = nil
			end

			local var_141_5 = 0
			local var_141_6 = 1.575

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_5 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, false)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_7 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(416051032).content)

				arg_138_1.text_.text = var_141_7

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_9 = 63 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_7) / 63)

				if (63 <= 0 and var_141_6 or var_141_6 * (utf8.len(var_141_7) / 63)) > 0 and var_141_6 < var_141_9 then
					arg_138_1.talkMaxDuration = var_141_9

					if var_141_9 + var_141_5 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_9 + var_141_5
					end
				end

				arg_138_1.text_.text = var_141_7
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_10 = math.max(var_141_6, arg_138_1.talkMaxDuration)

			if var_141_5 <= arg_138_1.time_ and arg_138_1.time_ < var_141_5 + var_141_10 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_5) / var_141_10

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_5 + var_141_10 and arg_138_1.time_ < var_141_5 + var_141_10 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play416051033 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 416051033
		arg_142_1.duration_ = 5.5

		local var_142_0 = {
			zh = 4.133,
			ja = 5.5
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play416051034(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10054"]) and arg_142_1.var_.actorSpriteComps10054 == nil then
				arg_142_1.var_.actorSpriteComps10054 = arg_142_1.actors_["10054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_0 = 0.125

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10054"]) then
				if arg_142_1.var_.actorSpriteComps10054 then
					for iter_145_0, iter_145_1 in pairs(arg_142_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_145_1 then
							if arg_142_1.isInRecall_ then
								iter_145_1.color = Color.New(Mathf.Lerp(iter_145_1.color.r, arg_142_1.hightColor1.r, (arg_142_1.time_ - 0) / var_145_0), Mathf.Lerp(iter_145_1.color.g, arg_142_1.hightColor1.g, (arg_142_1.time_ - 0) / var_145_0), (Mathf.Lerp(iter_145_1.color.b, arg_142_1.hightColor1.b, (arg_142_1.time_ - 0) / var_145_0)))
							else
								local var_145_1 = Mathf.Lerp(iter_145_1.color.r, 1, (arg_142_1.time_ - 0) / var_145_0)

								iter_145_1.color = Color.New(var_145_1, var_145_1, var_145_1)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10054"]) and arg_142_1.var_.actorSpriteComps10054 then
				for iter_145_2, iter_145_3 in pairs(arg_142_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_145_3 then
						iter_145_3.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_142_1.var_.actorSpriteComps10054 = nil
			end

			local var_145_2 = arg_142_1.actors_["1033"]

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps1033 == nil then
				arg_142_1.var_.actorSpriteComps1033 = var_145_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_145_3 = 0.125

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_3 and not isNil(var_145_2) then
				if arg_142_1.var_.actorSpriteComps1033 then
					for iter_145_4, iter_145_5 in pairs(arg_142_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_145_5 then
							if arg_142_1.isInRecall_ then
								iter_145_5.color = Color.New(Mathf.Lerp(iter_145_5.color.r, arg_142_1.hightColor2.r, (arg_142_1.time_ - 0) / var_145_3), Mathf.Lerp(iter_145_5.color.g, arg_142_1.hightColor2.g, (arg_142_1.time_ - 0) / var_145_3), (Mathf.Lerp(iter_145_5.color.b, arg_142_1.hightColor2.b, (arg_142_1.time_ - 0) / var_145_3)))
							else
								local var_145_4 = Mathf.Lerp(iter_145_5.color.r, 0.5, (arg_142_1.time_ - 0) / var_145_3)

								iter_145_5.color = Color.New(var_145_4, var_145_4, var_145_4)
							end
						end
					end
				end
			end

			if arg_142_1.time_ >= 0 + var_145_3 and arg_142_1.time_ < 0 + var_145_3 + arg_145_0 and not isNil(var_145_2) and arg_142_1.var_.actorSpriteComps1033 then
				for iter_145_6, iter_145_7 in pairs(arg_142_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_145_7 then
						iter_145_7.color = arg_142_1.isInRecall_ and (arg_142_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_142_1.var_.actorSpriteComps1033 = nil
			end

			local var_145_5 = 0
			local var_145_6 = 0.525

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_5 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_7 = arg_142_1:GetWordFromCfg(416051033)
				local var_145_8 = arg_142_1:FormatText(var_145_7.content)

				arg_142_1.text_.text = var_145_8

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_10 = 21 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 21)

				if (21 <= 0 and var_145_6 or var_145_6 * (utf8.len(var_145_8) / 21)) > 0 and var_145_6 < var_145_10 then
					arg_142_1.talkMaxDuration = var_145_10

					if var_145_10 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_10 + var_145_5
					end
				end

				arg_142_1.text_.text = var_145_8
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051033", "story_v_out_416051.awb") ~= 0 then
					local var_145_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051033", "story_v_out_416051.awb") / 1000

					if var_145_11 + var_145_5 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_11 + var_145_5
					end

					if var_145_7.prefab_name ~= "" and arg_142_1.actors_[var_145_7.prefab_name] ~= nil then
						local var_145_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_7.prefab_name].transform, "story_v_out_416051", "416051033", "story_v_out_416051.awb")

						arg_142_1:RecordAudio("416051033", var_145_12)
						arg_142_1:RecordAudio("416051033", var_145_12)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_416051", "416051033", "story_v_out_416051.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_416051", "416051033", "story_v_out_416051.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_13 = math.max(var_145_6, arg_142_1.talkMaxDuration)

			if var_145_5 <= arg_142_1.time_ and arg_142_1.time_ < var_145_5 + var_145_13 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_5) / var_145_13

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_5 + var_145_13 and arg_142_1.time_ < var_145_5 + var_145_13 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play416051034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 416051034
		arg_146_1.duration_ = 5.2

		local var_146_0 = {
			zh = 2.533,
			ja = 5.2
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play416051035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["10054"]) and arg_146_1.var_.actorSpriteComps10054 == nil then
				arg_146_1.var_.actorSpriteComps10054 = arg_146_1.actors_["10054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_0 = 0.125

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["10054"]) then
				if arg_146_1.var_.actorSpriteComps10054 then
					for iter_149_0, iter_149_1 in pairs(arg_146_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_149_1 then
							if arg_146_1.isInRecall_ then
								iter_149_1.color = Color.New(Mathf.Lerp(iter_149_1.color.r, arg_146_1.hightColor2.r, (arg_146_1.time_ - 0) / var_149_0), Mathf.Lerp(iter_149_1.color.g, arg_146_1.hightColor2.g, (arg_146_1.time_ - 0) / var_149_0), (Mathf.Lerp(iter_149_1.color.b, arg_146_1.hightColor2.b, (arg_146_1.time_ - 0) / var_149_0)))
							else
								local var_149_1 = Mathf.Lerp(iter_149_1.color.r, 0.5, (arg_146_1.time_ - 0) / var_149_0)

								iter_149_1.color = Color.New(var_149_1, var_149_1, var_149_1)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["10054"]) and arg_146_1.var_.actorSpriteComps10054 then
				for iter_149_2, iter_149_3 in pairs(arg_146_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_149_3 then
						iter_149_3.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_146_1.var_.actorSpriteComps10054 = nil
			end

			local var_149_2 = arg_146_1.actors_["1033"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps1033 == nil then
				arg_146_1.var_.actorSpriteComps1033 = var_149_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_149_3 = 0.125

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.actorSpriteComps1033 then
					for iter_149_4, iter_149_5 in pairs(arg_146_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_149_5 then
							if arg_146_1.isInRecall_ then
								iter_149_5.color = Color.New(Mathf.Lerp(iter_149_5.color.r, arg_146_1.hightColor1.r, (arg_146_1.time_ - 0) / var_149_3), Mathf.Lerp(iter_149_5.color.g, arg_146_1.hightColor1.g, (arg_146_1.time_ - 0) / var_149_3), (Mathf.Lerp(iter_149_5.color.b, arg_146_1.hightColor1.b, (arg_146_1.time_ - 0) / var_149_3)))
							else
								local var_149_4 = Mathf.Lerp(iter_149_5.color.r, 1, (arg_146_1.time_ - 0) / var_149_3)

								iter_149_5.color = Color.New(var_149_4, var_149_4, var_149_4)
							end
						end
					end
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.actorSpriteComps1033 then
				for iter_149_6, iter_149_7 in pairs(arg_146_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_149_7 then
						iter_149_7.color = arg_146_1.isInRecall_ and (arg_146_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_146_1.var_.actorSpriteComps1033 = nil
			end

			local var_149_5 = 0
			local var_149_6 = 0.375

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_5 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_7 = arg_146_1:GetWordFromCfg(416051034)
				local var_149_8 = arg_146_1:FormatText(var_149_7.content)

				arg_146_1.text_.text = var_149_8

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_10 = 15 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_8) / 15)

				if (15 <= 0 and var_149_6 or var_149_6 * (utf8.len(var_149_8) / 15)) > 0 and var_149_6 < var_149_10 then
					arg_146_1.talkMaxDuration = var_149_10

					if var_149_10 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_10 + var_149_5
					end
				end

				arg_146_1.text_.text = var_149_8
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051034", "story_v_out_416051.awb") ~= 0 then
					local var_149_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051034", "story_v_out_416051.awb") / 1000

					if var_149_11 + var_149_5 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_11 + var_149_5
					end

					if var_149_7.prefab_name ~= "" and arg_146_1.actors_[var_149_7.prefab_name] ~= nil then
						local var_149_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_7.prefab_name].transform, "story_v_out_416051", "416051034", "story_v_out_416051.awb")

						arg_146_1:RecordAudio("416051034", var_149_12)
						arg_146_1:RecordAudio("416051034", var_149_12)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_416051", "416051034", "story_v_out_416051.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_416051", "416051034", "story_v_out_416051.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_13 = math.max(var_149_6, arg_146_1.talkMaxDuration)

			if var_149_5 <= arg_146_1.time_ and arg_146_1.time_ < var_149_5 + var_149_13 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_5) / var_149_13

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_5 + var_149_13 and arg_146_1.time_ < var_149_5 + var_149_13 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play416051035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 416051035
		arg_150_1.duration_ = 4.1

		local var_150_0 = {
			zh = 1.733,
			ja = 4.1
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play416051036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["10054"]) and arg_150_1.var_.actorSpriteComps10054 == nil then
				arg_150_1.var_.actorSpriteComps10054 = arg_150_1.actors_["10054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_0 = 0.125

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["10054"]) then
				if arg_150_1.var_.actorSpriteComps10054 then
					for iter_153_0, iter_153_1 in pairs(arg_150_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_153_1 then
							if arg_150_1.isInRecall_ then
								iter_153_1.color = Color.New(Mathf.Lerp(iter_153_1.color.r, arg_150_1.hightColor1.r, (arg_150_1.time_ - 0) / var_153_0), Mathf.Lerp(iter_153_1.color.g, arg_150_1.hightColor1.g, (arg_150_1.time_ - 0) / var_153_0), (Mathf.Lerp(iter_153_1.color.b, arg_150_1.hightColor1.b, (arg_150_1.time_ - 0) / var_153_0)))
							else
								local var_153_1 = Mathf.Lerp(iter_153_1.color.r, 1, (arg_150_1.time_ - 0) / var_153_0)

								iter_153_1.color = Color.New(var_153_1, var_153_1, var_153_1)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["10054"]) and arg_150_1.var_.actorSpriteComps10054 then
				for iter_153_2, iter_153_3 in pairs(arg_150_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_153_3 then
						iter_153_3.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_150_1.var_.actorSpriteComps10054 = nil
			end

			local var_153_2 = arg_150_1.actors_["1033"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1033 == nil then
				arg_150_1.var_.actorSpriteComps1033 = var_153_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_153_3 = 0.125

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.actorSpriteComps1033 then
					for iter_153_4, iter_153_5 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_153_5 then
							if arg_150_1.isInRecall_ then
								iter_153_5.color = Color.New(Mathf.Lerp(iter_153_5.color.r, arg_150_1.hightColor2.r, (arg_150_1.time_ - 0) / var_153_3), Mathf.Lerp(iter_153_5.color.g, arg_150_1.hightColor2.g, (arg_150_1.time_ - 0) / var_153_3), (Mathf.Lerp(iter_153_5.color.b, arg_150_1.hightColor2.b, (arg_150_1.time_ - 0) / var_153_3)))
							else
								local var_153_4 = Mathf.Lerp(iter_153_5.color.r, 0.5, (arg_150_1.time_ - 0) / var_153_3)

								iter_153_5.color = Color.New(var_153_4, var_153_4, var_153_4)
							end
						end
					end
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.actorSpriteComps1033 then
				for iter_153_6, iter_153_7 in pairs(arg_150_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_153_7 then
						iter_153_7.color = arg_150_1.isInRecall_ and (arg_150_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_150_1.var_.actorSpriteComps1033 = nil
			end

			local var_153_5 = 0
			local var_153_6 = 0.225

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_5 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_7 = arg_150_1:GetWordFromCfg(416051035)
				local var_153_8 = arg_150_1:FormatText(var_153_7.content)

				arg_150_1.text_.text = var_153_8

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_10 = 9 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 9)

				if (9 <= 0 and var_153_6 or var_153_6 * (utf8.len(var_153_8) / 9)) > 0 and var_153_6 < var_153_10 then
					arg_150_1.talkMaxDuration = var_153_10

					if var_153_10 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_10 + var_153_5
					end
				end

				arg_150_1.text_.text = var_153_8
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051035", "story_v_out_416051.awb") ~= 0 then
					local var_153_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051035", "story_v_out_416051.awb") / 1000

					if var_153_11 + var_153_5 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_11 + var_153_5
					end

					if var_153_7.prefab_name ~= "" and arg_150_1.actors_[var_153_7.prefab_name] ~= nil then
						local var_153_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_7.prefab_name].transform, "story_v_out_416051", "416051035", "story_v_out_416051.awb")

						arg_150_1:RecordAudio("416051035", var_153_12)
						arg_150_1:RecordAudio("416051035", var_153_12)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_416051", "416051035", "story_v_out_416051.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_416051", "416051035", "story_v_out_416051.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_13 = math.max(var_153_6, arg_150_1.talkMaxDuration)

			if var_153_5 <= arg_150_1.time_ and arg_150_1.time_ < var_153_5 + var_153_13 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_5) / var_153_13

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_5 + var_153_13 and arg_150_1.time_ < var_153_5 + var_153_13 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play416051036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 416051036
		arg_154_1.duration_ = 10.47

		local var_154_0 = {
			zh = 7.133,
			ja = 10.466
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play416051037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10054"]) and arg_154_1.var_.actorSpriteComps10054 == nil then
				arg_154_1.var_.actorSpriteComps10054 = arg_154_1.actors_["10054"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_0 = 0.125

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10054"]) then
				if arg_154_1.var_.actorSpriteComps10054 then
					for iter_157_0, iter_157_1 in pairs(arg_154_1.var_.actorSpriteComps10054:ToTable()) do
						if iter_157_1 then
							if arg_154_1.isInRecall_ then
								iter_157_1.color = Color.New(Mathf.Lerp(iter_157_1.color.r, arg_154_1.hightColor2.r, (arg_154_1.time_ - 0) / var_157_0), Mathf.Lerp(iter_157_1.color.g, arg_154_1.hightColor2.g, (arg_154_1.time_ - 0) / var_157_0), (Mathf.Lerp(iter_157_1.color.b, arg_154_1.hightColor2.b, (arg_154_1.time_ - 0) / var_157_0)))
							else
								local var_157_1 = Mathf.Lerp(iter_157_1.color.r, 0.5, (arg_154_1.time_ - 0) / var_157_0)

								iter_157_1.color = Color.New(var_157_1, var_157_1, var_157_1)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10054"]) and arg_154_1.var_.actorSpriteComps10054 then
				for iter_157_2, iter_157_3 in pairs(arg_154_1.var_.actorSpriteComps10054:ToTable()) do
					if iter_157_3 then
						iter_157_3.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_154_1.var_.actorSpriteComps10054 = nil
			end

			local var_157_2 = arg_154_1.actors_["1033"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1033 == nil then
				arg_154_1.var_.actorSpriteComps1033 = var_157_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_157_3 = 0.125

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.actorSpriteComps1033 then
					for iter_157_4, iter_157_5 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
						if iter_157_5 then
							if arg_154_1.isInRecall_ then
								iter_157_5.color = Color.New(Mathf.Lerp(iter_157_5.color.r, arg_154_1.hightColor1.r, (arg_154_1.time_ - 0) / var_157_3), Mathf.Lerp(iter_157_5.color.g, arg_154_1.hightColor1.g, (arg_154_1.time_ - 0) / var_157_3), (Mathf.Lerp(iter_157_5.color.b, arg_154_1.hightColor1.b, (arg_154_1.time_ - 0) / var_157_3)))
							else
								local var_157_4 = Mathf.Lerp(iter_157_5.color.r, 1, (arg_154_1.time_ - 0) / var_157_3)

								iter_157_5.color = Color.New(var_157_4, var_157_4, var_157_4)
							end
						end
					end
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.actorSpriteComps1033 then
				for iter_157_6, iter_157_7 in pairs(arg_154_1.var_.actorSpriteComps1033:ToTable()) do
					if iter_157_7 then
						iter_157_7.color = arg_154_1.isInRecall_ and (arg_154_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_154_1.var_.actorSpriteComps1033 = nil
			end

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_17", "se_story_17_messenger03", "")
			end

			local var_157_6 = 0
			local var_157_7 = 0.875

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_6 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_8 = arg_154_1:GetWordFromCfg(416051036)
				local var_157_9 = arg_154_1:FormatText(var_157_8.content)

				arg_154_1.text_.text = var_157_9

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_11 = 35 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_9) / 35)

				if (35 <= 0 and var_157_7 or var_157_7 * (utf8.len(var_157_9) / 35)) > 0 and var_157_7 < var_157_11 then
					arg_154_1.talkMaxDuration = var_157_11

					if var_157_11 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_11 + var_157_6
					end
				end

				arg_154_1.text_.text = var_157_9
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051036", "story_v_out_416051.awb") ~= 0 then
					local var_157_12 = manager.audio:GetVoiceLength("story_v_out_416051", "416051036", "story_v_out_416051.awb") / 1000

					if var_157_12 + var_157_6 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_12 + var_157_6
					end

					if var_157_8.prefab_name ~= "" and arg_154_1.actors_[var_157_8.prefab_name] ~= nil then
						local var_157_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_8.prefab_name].transform, "story_v_out_416051", "416051036", "story_v_out_416051.awb")

						arg_154_1:RecordAudio("416051036", var_157_13)
						arg_154_1:RecordAudio("416051036", var_157_13)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_416051", "416051036", "story_v_out_416051.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_416051", "416051036", "story_v_out_416051.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_14 = math.max(var_157_7, arg_154_1.talkMaxDuration)

			if var_157_6 <= arg_154_1.time_ and arg_154_1.time_ < var_157_6 + var_157_14 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_6) / var_157_14

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_6 + var_157_14 and arg_154_1.time_ < var_157_6 + var_157_14 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play416051037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 416051037
		arg_158_1.duration_ = 5.87

		local var_158_0 = {
			zh = 5.766,
			ja = 5.866
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play416051038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.8

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:GetWordFromCfg(416051037)
				local var_161_2 = arg_158_1:FormatText(var_161_1.content)

				arg_158_1.text_.text = var_161_2

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_4 = 32 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 32)

				if (32 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_2) / 32)) > 0 and var_161_0 < var_161_4 then
					arg_158_1.talkMaxDuration = var_161_4

					if var_161_4 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_4 + 0
					end
				end

				arg_158_1.text_.text = var_161_2
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051037", "story_v_out_416051.awb") ~= 0 then
					local var_161_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051037", "story_v_out_416051.awb") / 1000

					if var_161_5 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_5 + 0
					end

					if var_161_1.prefab_name ~= "" and arg_158_1.actors_[var_161_1.prefab_name] ~= nil then
						local var_161_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_1.prefab_name].transform, "story_v_out_416051", "416051037", "story_v_out_416051.awb")

						arg_158_1:RecordAudio("416051037", var_161_6)
						arg_158_1:RecordAudio("416051037", var_161_6)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_416051", "416051037", "story_v_out_416051.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_416051", "416051037", "story_v_out_416051.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_7 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_7 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_7

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_7 and arg_158_1.time_ < 0 + var_161_7 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play416051038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 416051038
		arg_162_1.duration_ = 4.67

		local var_162_0 = {
			zh = 4.6,
			ja = 4.666
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play416051039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:AudioAction("play", "effect", "se_story_17", "se_story_17_messenger03", "")
			end

			local var_165_1 = 0
			local var_165_2 = 0.675

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:GetWordFromCfg(416051038)
				local var_165_4 = arg_162_1:FormatText(var_165_3.content)

				arg_162_1.text_.text = var_165_4

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_6 = 27 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 27)

				if (27 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_4) / 27)) > 0 and var_165_2 < var_165_6 then
					arg_162_1.talkMaxDuration = var_165_6

					if var_165_6 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_6 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_4
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051038", "story_v_out_416051.awb") ~= 0 then
					local var_165_7 = manager.audio:GetVoiceLength("story_v_out_416051", "416051038", "story_v_out_416051.awb") / 1000

					if var_165_7 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_1
					end

					if var_165_3.prefab_name ~= "" and arg_162_1.actors_[var_165_3.prefab_name] ~= nil then
						local var_165_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_3.prefab_name].transform, "story_v_out_416051", "416051038", "story_v_out_416051.awb")

						arg_162_1:RecordAudio("416051038", var_165_8)
						arg_162_1:RecordAudio("416051038", var_165_8)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_416051", "416051038", "story_v_out_416051.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_416051", "416051038", "story_v_out_416051.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_9 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_9 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_9

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_9 and arg_162_1.time_ < var_165_1 + var_165_9 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play416051039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 416051039
		arg_166_1.duration_ = 8.43

		local var_166_0 = {
			zh = 7.3,
			ja = 8.433
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play416051040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 4 < arg_166_1.time_ and arg_166_1.time_ <= 4 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= 4 + 0.133333333333334 and arg_166_1.time_ < 4 + 0.133333333333334 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_0 = "ST0106"

			if arg_166_1.bgs_.ST0106 == nil then
				local var_169_1 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_169_0)
				var_169_1.name = var_169_0
				var_169_1.transform.parent = arg_166_1.stage_.transform
				var_169_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_[var_169_0] = var_169_1
			end

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 then
				local var_169_2 = arg_166_1.bgs_.ST0106

				arg_166_1.bgs_.ST0106.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_3 = var_169_2:GetComponent("SpriteRenderer")

				if var_169_3 and var_169_3.sprite then
					local var_169_4 = 2 * (var_169_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_2.transform.localScale = Vector3.New(var_169_4 / var_169_3.sprite.bounds.size.y < var_169_4 * manager.ui.mainCameraCom_.aspect / var_169_3.sprite.bounds.size.x and var_169_4 * manager.ui.mainCameraCom_.aspect / var_169_3.sprite.bounds.size.x or var_169_4 / var_169_3.sprite.bounds.size.y, var_169_4 / var_169_3.sprite.bounds.size.y < var_169_4 * manager.ui.mainCameraCom_.aspect / var_169_3.sprite.bounds.size.x and var_169_4 * manager.ui.mainCameraCom_.aspect / var_169_3.sprite.bounds.size.x or var_169_4 / var_169_3.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST0106" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_5 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_5 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_6 = 2

			if var_169_5 <= arg_166_1.time_ and arg_166_1.time_ < var_169_5 + var_169_6 then
				local var_169_7 = Color.New(0, 0, 0)

				var_169_7.a = Mathf.Lerp(0, 1, (arg_166_1.time_ - var_169_5) / var_169_6)
				arg_166_1.mask_.color = var_169_7
			end

			if arg_166_1.time_ >= var_169_5 + var_169_6 and arg_166_1.time_ < var_169_5 + var_169_6 + arg_169_0 then
				local var_169_8 = Color.New(0, 0, 0)

				var_169_8.a = 1
				arg_166_1.mask_.color = var_169_8
			end

			local var_169_9 = 2

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_10 = 2

			if var_169_9 <= arg_166_1.time_ and arg_166_1.time_ < var_169_9 + var_169_10 then
				local var_169_11 = Color.New(0, 0, 0)

				var_169_11.a = Mathf.Lerp(1, 0, (arg_166_1.time_ - var_169_9) / var_169_10)
				arg_166_1.mask_.color = var_169_11
			end

			if arg_166_1.time_ >= var_169_9 + var_169_10 and arg_166_1.time_ < var_169_9 + var_169_10 + arg_169_0 then
				local var_169_12 = Color.New(0, 0, 0)

				arg_166_1.mask_.enabled = false
				var_169_12.a = 0
				arg_166_1.mask_.color = var_169_12
			end

			local var_169_13 = arg_166_1.actors_["1033"].transform

			if 1.966 < arg_166_1.time_ and arg_166_1.time_ <= 1.966 + arg_169_0 then
				arg_166_1.var_.moveOldPos1033 = var_169_13.localPosition
				var_169_13.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1033", 7)

				for iter_169_2 = 0, var_169_13.childCount - 1 do
					local var_169_14 = var_169_13:GetChild(iter_169_2)

					if var_169_14.name == "" or not string.find(var_169_14.name, "split") then
						var_169_14.gameObject:SetActive(true)
					else
						var_169_14.gameObject:SetActive(false)
					end
				end
			end

			local var_169_15 = 0.001

			if 1.966 <= arg_166_1.time_ and arg_166_1.time_ < 1.966 + var_169_15 then
				var_169_13.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1033, Vector3.New(0, -2000, 0), (arg_166_1.time_ - 1.966) / var_169_15)
			end

			if arg_166_1.time_ >= 1.966 + var_169_15 and arg_166_1.time_ < 1.966 + var_169_15 + arg_169_0 then
				var_169_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_16 = arg_166_1.actors_["10054"].transform

			if 1.966 < arg_166_1.time_ and arg_166_1.time_ <= 1.966 + arg_169_0 then
				arg_166_1.var_.moveOldPos10054 = var_169_16.localPosition
				var_169_16.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("10054", 7)

				for iter_169_3 = 0, var_169_16.childCount - 1 do
					local var_169_17 = var_169_16:GetChild(iter_169_3)

					if var_169_17.name == "" or not string.find(var_169_17.name, "split") then
						var_169_17.gameObject:SetActive(true)
					else
						var_169_17.gameObject:SetActive(false)
					end
				end
			end

			local var_169_18 = 0.001

			if 1.966 <= arg_166_1.time_ and arg_166_1.time_ < 1.966 + var_169_18 then
				var_169_16.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos10054, Vector3.New(0, -2000, 0), (arg_166_1.time_ - 1.966) / var_169_18)
			end

			if arg_166_1.time_ >= 1.966 + var_169_18 and arg_166_1.time_ < 1.966 + var_169_18 + arg_169_0 then
				var_169_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_169_19 = "1028"

			if arg_166_1.actors_["1028"] == nil then
				local var_169_20 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1028")

				if not isNil(var_169_20) then
					local var_169_21 = Object.Instantiate(var_169_20, arg_166_1.canvasGo_.transform)

					var_169_21.transform:SetSiblingIndex(1)

					var_169_21.name = var_169_19
					var_169_21.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_166_1.actors_[var_169_19] = var_169_21

					if arg_166_1.isInRecall_ then
						for iter_169_4, iter_169_5 in ipairs((var_169_21:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_169_5.color = arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_169_22 = arg_166_1.actors_["1028"]

			if 3.73333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 3.73333333333333 + arg_169_0 and not isNil(var_169_22) and arg_166_1.var_.actorSpriteComps1028 == nil then
				arg_166_1.var_.actorSpriteComps1028 = var_169_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_169_23 = 0.125

			if 3.73333333333333 <= arg_166_1.time_ and arg_166_1.time_ < 3.73333333333333 + var_169_23 and not isNil(var_169_22) then
				if arg_166_1.var_.actorSpriteComps1028 then
					for iter_169_6, iter_169_7 in pairs(arg_166_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_169_7 then
							if arg_166_1.isInRecall_ then
								iter_169_7.color = Color.New(Mathf.Lerp(iter_169_7.color.r, arg_166_1.hightColor1.r, (arg_166_1.time_ - 3.73333333333333) / var_169_23), Mathf.Lerp(iter_169_7.color.g, arg_166_1.hightColor1.g, (arg_166_1.time_ - 3.73333333333333) / var_169_23), (Mathf.Lerp(iter_169_7.color.b, arg_166_1.hightColor1.b, (arg_166_1.time_ - 3.73333333333333) / var_169_23)))
							else
								local var_169_24 = Mathf.Lerp(iter_169_7.color.r, 1, (arg_166_1.time_ - 3.73333333333333) / var_169_23)

								iter_169_7.color = Color.New(var_169_24, var_169_24, var_169_24)
							end
						end
					end
				end
			end

			if arg_166_1.time_ >= 3.73333333333333 + var_169_23 and arg_166_1.time_ < 3.73333333333333 + var_169_23 + arg_169_0 and not isNil(var_169_22) and arg_166_1.var_.actorSpriteComps1028 then
				for iter_169_8, iter_169_9 in pairs(arg_166_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_169_9 then
						iter_169_9.color = arg_166_1.isInRecall_ and (arg_166_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_166_1.var_.actorSpriteComps1028 = nil
			end

			local var_169_25 = arg_166_1.actors_["1028"].transform

			if 3.73333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 3.73333333333333 + arg_169_0 then
				arg_166_1.var_.moveOldPos1028 = var_169_25.localPosition
				var_169_25.localScale = Vector3.New(1, 1, 1)

				arg_166_1:CheckSpriteTmpPos("1028", 3)

				for iter_169_10 = 0, var_169_25.childCount - 1 do
					local var_169_26 = var_169_25:GetChild(iter_169_10)

					if var_169_26.name == "" or not string.find(var_169_26.name, "split") then
						var_169_26.gameObject:SetActive(true)
					else
						var_169_26.gameObject:SetActive(false)
					end
				end
			end

			local var_169_27 = 0.001

			if 3.73333333333333 <= arg_166_1.time_ and arg_166_1.time_ < 3.73333333333333 + var_169_27 then
				var_169_25.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_166_1.time_ - 3.73333333333333) / var_169_27)
			end

			if arg_166_1.time_ >= 3.73333333333333 + var_169_27 and arg_166_1.time_ < 3.73333333333333 + var_169_27 + arg_169_0 then
				var_169_25.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			if 3.73333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 3.73333333333333 + arg_169_0 then
				local var_169_28 = arg_166_1.actors_["1028"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_169_28 then
					arg_166_1.var_.alphaOldValue1028 = var_169_28.alpha
					arg_166_1.var_.characterEffect1028 = var_169_28
				end

				arg_166_1.var_.alphaOldValue1028 = 0
			end

			local var_169_29 = 0.3

			if 3.73333333333333 <= arg_166_1.time_ and arg_166_1.time_ < 3.73333333333333 + var_169_29 then
				if arg_166_1.var_.characterEffect1028 then
					arg_166_1.var_.characterEffect1028.alpha = Mathf.Lerp(arg_166_1.var_.alphaOldValue1028, 1, (arg_166_1.time_ - 3.73333333333333) / var_169_29)
				end
			end

			if arg_166_1.time_ >= 3.73333333333333 + var_169_29 and arg_166_1.time_ < 3.73333333333333 + var_169_29 + arg_169_0 and arg_166_1.var_.characterEffect1028 then
				arg_166_1.var_.characterEffect1028.alpha = 1
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_169_32 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_32 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_32

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_32
						arg_166_1.bgmTxt2_.text = var_169_32
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.43333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 1.43333333333333 + arg_169_0 then
				arg_166_1:AudioAction("play", "music", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village.awb")

				local var_169_35 = manager.audio:GetAudioName("bgm_activity_3_8_story_village", "bgm_activity_3_8_story_village")

				if "" ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_35 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_35

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_35
						arg_166_1.bgmTxt2_.text = var_169_35
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_36 = 4
			local var_169_37 = 0.3

			if 4 < arg_166_1.time_ and arg_166_1.time_ <= var_169_36 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_38 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_38:setOnUpdate(LuaHelper.FloatAction(function(arg_172_0)
					arg_166_1.dialogCg_.alpha = arg_172_0
				end))
				var_169_38:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_38:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_39 = arg_166_1:GetWordFromCfg(416051039)
				local var_169_40 = arg_166_1:FormatText(var_169_39.content)

				arg_166_1.text_.text = var_169_40

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_42 = 12 <= 0 and var_169_37 or var_169_37 * (utf8.len(var_169_40) / 12)

				if (12 <= 0 and var_169_37 or var_169_37 * (utf8.len(var_169_40) / 12)) > 0 and var_169_37 < var_169_42 then
					arg_166_1.talkMaxDuration = var_169_42
					var_169_36 = var_169_36 + 0.3

					if var_169_42 + var_169_36 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_42 + var_169_36
					end
				end

				arg_166_1.text_.text = var_169_40
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051039", "story_v_out_416051.awb") ~= 0 then
					local var_169_43 = manager.audio:GetVoiceLength("story_v_out_416051", "416051039", "story_v_out_416051.awb") / 1000

					if var_169_43 + var_169_36 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_43 + var_169_36
					end

					if var_169_39.prefab_name ~= "" and arg_166_1.actors_[var_169_39.prefab_name] ~= nil then
						local var_169_44 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_39.prefab_name].transform, "story_v_out_416051", "416051039", "story_v_out_416051.awb")

						arg_166_1:RecordAudio("416051039", var_169_44)
						arg_166_1:RecordAudio("416051039", var_169_44)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_416051", "416051039", "story_v_out_416051.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_416051", "416051039", "story_v_out_416051.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_45 = var_169_36 + 0.3
			local var_169_46 = math.max(var_169_37, arg_166_1.talkMaxDuration)

			if var_169_36 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_45 + var_169_46 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_45) / var_169_46

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_45 + var_169_46 and arg_166_1.time_ < var_169_45 + var_169_46 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1033",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10054",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.73333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play416051040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 416051040
		arg_174_1.duration_ = 5.33

		local var_174_0 = {
			zh = 5.333,
			ja = 4.833
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play416051041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1028 = arg_174_1.actors_["1028"].transform.localPosition
				arg_174_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1028", 2)

				for iter_177_0 = 0, arg_174_1.actors_["1028"].transform.childCount - 1 do
					local var_177_0 = arg_174_1.actors_["1028"].transform:GetChild(iter_177_0)

					if var_177_0.name == "" or not string.find(var_177_0.name, "split") then
						var_177_0.gameObject:SetActive(true)
					else
						var_177_0.gameObject:SetActive(false)
					end
				end
			end

			local var_177_1 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_1 then
				arg_174_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_174_1.time_ - 0) / var_177_1)
			end

			if arg_174_1.time_ >= 0 + var_177_1 and arg_174_1.time_ < 0 + var_177_1 + arg_177_0 then
				arg_174_1.actors_["1028"].transform.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_177_2 = arg_174_1.actors_["1028"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps1028 == nil then
				arg_174_1.var_.actorSpriteComps1028 = var_177_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_3 = 0.125

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_3 and not isNil(var_177_2) then
				if arg_174_1.var_.actorSpriteComps1028 then
					for iter_177_1, iter_177_2 in pairs(arg_174_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_177_2 then
							if arg_174_1.isInRecall_ then
								iter_177_2.color = Color.New(Mathf.Lerp(iter_177_2.color.r, arg_174_1.hightColor2.r, (arg_174_1.time_ - 0) / var_177_3), Mathf.Lerp(iter_177_2.color.g, arg_174_1.hightColor2.g, (arg_174_1.time_ - 0) / var_177_3), (Mathf.Lerp(iter_177_2.color.b, arg_174_1.hightColor2.b, (arg_174_1.time_ - 0) / var_177_3)))
							else
								local var_177_4 = Mathf.Lerp(iter_177_2.color.r, 0.5, (arg_174_1.time_ - 0) / var_177_3)

								iter_177_2.color = Color.New(var_177_4, var_177_4, var_177_4)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_3 and arg_174_1.time_ < 0 + var_177_3 + arg_177_0 and not isNil(var_177_2) and arg_174_1.var_.actorSpriteComps1028 then
				for iter_177_3, iter_177_4 in pairs(arg_174_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_177_4 then
						iter_177_4.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_174_1.var_.actorSpriteComps1028 = nil
			end

			local var_177_5 = "1086"

			if arg_174_1.actors_["1086"] == nil then
				local var_177_6 = Asset.Load("Widget/System/Story/StoryExpression/" .. "1086")

				if not isNil(var_177_6) then
					local var_177_7 = Object.Instantiate(var_177_6, arg_174_1.canvasGo_.transform)

					var_177_7.transform:SetSiblingIndex(1)

					var_177_7.name = var_177_5
					var_177_7.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_174_1.actors_[var_177_5] = var_177_7

					if arg_174_1.isInRecall_ then
						for iter_177_5, iter_177_6 in ipairs((var_177_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_177_6.color = arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_177_8 = arg_174_1.actors_["1086"]

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps1086 == nil then
				arg_174_1.var_.actorSpriteComps1086 = var_177_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_177_9 = 0.125

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_9 and not isNil(var_177_8) then
				if arg_174_1.var_.actorSpriteComps1086 then
					for iter_177_7, iter_177_8 in pairs(arg_174_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_177_8 then
							if arg_174_1.isInRecall_ then
								iter_177_8.color = Color.New(Mathf.Lerp(iter_177_8.color.r, arg_174_1.hightColor1.r, (arg_174_1.time_ - 0) / var_177_9), Mathf.Lerp(iter_177_8.color.g, arg_174_1.hightColor1.g, (arg_174_1.time_ - 0) / var_177_9), (Mathf.Lerp(iter_177_8.color.b, arg_174_1.hightColor1.b, (arg_174_1.time_ - 0) / var_177_9)))
							else
								local var_177_10 = Mathf.Lerp(iter_177_8.color.r, 1, (arg_174_1.time_ - 0) / var_177_9)

								iter_177_8.color = Color.New(var_177_10, var_177_10, var_177_10)
							end
						end
					end
				end
			end

			if arg_174_1.time_ >= 0 + var_177_9 and arg_174_1.time_ < 0 + var_177_9 + arg_177_0 and not isNil(var_177_8) and arg_174_1.var_.actorSpriteComps1086 then
				for iter_177_9, iter_177_10 in pairs(arg_174_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_177_10 then
						iter_177_10.color = arg_174_1.isInRecall_ and (arg_174_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_174_1.var_.actorSpriteComps1086 = nil
			end

			local var_177_11 = arg_174_1.actors_["1086"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos1086 = var_177_11.localPosition
				var_177_11.localScale = Vector3.New(1, 1, 1)

				arg_174_1:CheckSpriteTmpPos("1086", 4)

				for iter_177_11 = 0, var_177_11.childCount - 1 do
					local var_177_12 = var_177_11:GetChild(iter_177_11)

					if var_177_12.name == "split_1" or not string.find(var_177_12.name, "split") then
						var_177_12.gameObject:SetActive(true)
					else
						var_177_12.gameObject:SetActive(false)
					end
				end
			end

			local var_177_13 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_13 then
				var_177_11.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_174_1.time_ - 0) / var_177_13)
			end

			if arg_174_1.time_ >= 0 + var_177_13 and arg_174_1.time_ < 0 + var_177_13 + arg_177_0 then
				var_177_11.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_177_14 = 0
			local var_177_15 = 0.55

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_14 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, false)
				arg_174_1.callingController_:SetSelectedState("normal")

				local var_177_16 = arg_174_1:GetWordFromCfg(416051040)
				local var_177_17 = arg_174_1:FormatText(var_177_16.content)

				arg_174_1.text_.text = var_177_17

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_19 = 22 <= 0 and var_177_15 or var_177_15 * (utf8.len(var_177_17) / 22)

				if (22 <= 0 and var_177_15 or var_177_15 * (utf8.len(var_177_17) / 22)) > 0 and var_177_15 < var_177_19 then
					arg_174_1.talkMaxDuration = var_177_19

					if var_177_19 + var_177_14 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_19 + var_177_14
					end
				end

				arg_174_1.text_.text = var_177_17
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051040", "story_v_out_416051.awb") ~= 0 then
					local var_177_20 = manager.audio:GetVoiceLength("story_v_out_416051", "416051040", "story_v_out_416051.awb") / 1000

					if var_177_20 + var_177_14 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_20 + var_177_14
					end

					if var_177_16.prefab_name ~= "" and arg_174_1.actors_[var_177_16.prefab_name] ~= nil then
						local var_177_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_16.prefab_name].transform, "story_v_out_416051", "416051040", "story_v_out_416051.awb")

						arg_174_1:RecordAudio("416051040", var_177_21)
						arg_174_1:RecordAudio("416051040", var_177_21)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_416051", "416051040", "story_v_out_416051.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_416051", "416051040", "story_v_out_416051.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_22 = math.max(var_177_15, arg_174_1.talkMaxDuration)

			if var_177_14 <= arg_174_1.time_ and arg_174_1.time_ < var_177_14 + var_177_22 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_14) / var_177_22

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_14 + var_177_22 and arg_174_1.time_ < var_177_14 + var_177_22 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play416051041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 416051041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play416051042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["1086"]) and arg_178_1.var_.actorSpriteComps1086 == nil then
				arg_178_1.var_.actorSpriteComps1086 = arg_178_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_181_0 = 0.125

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["1086"]) then
				if arg_178_1.var_.actorSpriteComps1086 then
					for iter_181_0, iter_181_1 in pairs(arg_178_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_181_1 then
							if arg_178_1.isInRecall_ then
								iter_181_1.color = Color.New(Mathf.Lerp(iter_181_1.color.r, arg_178_1.hightColor2.r, (arg_178_1.time_ - 0) / var_181_0), Mathf.Lerp(iter_181_1.color.g, arg_178_1.hightColor2.g, (arg_178_1.time_ - 0) / var_181_0), (Mathf.Lerp(iter_181_1.color.b, arg_178_1.hightColor2.b, (arg_178_1.time_ - 0) / var_181_0)))
							else
								local var_181_1 = Mathf.Lerp(iter_181_1.color.r, 0.5, (arg_178_1.time_ - 0) / var_181_0)

								iter_181_1.color = Color.New(var_181_1, var_181_1, var_181_1)
							end
						end
					end
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["1086"]) and arg_178_1.var_.actorSpriteComps1086 then
				for iter_181_2, iter_181_3 in pairs(arg_178_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_181_3 then
						iter_181_3.color = arg_178_1.isInRecall_ and (arg_178_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_178_1.var_.actorSpriteComps1086 = nil
			end

			local var_181_2 = 0
			local var_181_3 = 1.525

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, false)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_4 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(416051041).content)

				arg_178_1.text_.text = var_181_4

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_6 = 61 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_4) / 61)

				if (61 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_4) / 61)) > 0 and var_181_3 < var_181_6 then
					arg_178_1.talkMaxDuration = var_181_6

					if var_181_6 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_6 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_4
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_7 and arg_178_1.time_ < var_181_2 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play416051042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 416051042
		arg_182_1.duration_ = 7.47

		local var_182_0 = {
			zh = 5.933,
			ja = 7.466
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play416051043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(arg_182_1.actors_["1028"]) and arg_182_1.var_.actorSpriteComps1028 == nil then
				arg_182_1.var_.actorSpriteComps1028 = arg_182_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_0 = 0.125

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 and not isNil(arg_182_1.actors_["1028"]) then
				if arg_182_1.var_.actorSpriteComps1028 then
					for iter_185_0, iter_185_1 in pairs(arg_182_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_185_1 then
							if arg_182_1.isInRecall_ then
								iter_185_1.color = Color.New(Mathf.Lerp(iter_185_1.color.r, arg_182_1.hightColor1.r, (arg_182_1.time_ - 0) / var_185_0), Mathf.Lerp(iter_185_1.color.g, arg_182_1.hightColor1.g, (arg_182_1.time_ - 0) / var_185_0), (Mathf.Lerp(iter_185_1.color.b, arg_182_1.hightColor1.b, (arg_182_1.time_ - 0) / var_185_0)))
							else
								local var_185_1 = Mathf.Lerp(iter_185_1.color.r, 1, (arg_182_1.time_ - 0) / var_185_0)

								iter_185_1.color = Color.New(var_185_1, var_185_1, var_185_1)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 and not isNil(arg_182_1.actors_["1028"]) and arg_182_1.var_.actorSpriteComps1028 then
				for iter_185_2, iter_185_3 in pairs(arg_182_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_185_3 then
						iter_185_3.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_182_1.var_.actorSpriteComps1028 = nil
			end

			local var_185_2 = arg_182_1.actors_["1086"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps1086 == nil then
				arg_182_1.var_.actorSpriteComps1086 = var_185_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_185_3 = 0.125

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_3 and not isNil(var_185_2) then
				if arg_182_1.var_.actorSpriteComps1086 then
					for iter_185_4, iter_185_5 in pairs(arg_182_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_185_5 then
							if arg_182_1.isInRecall_ then
								iter_185_5.color = Color.New(Mathf.Lerp(iter_185_5.color.r, arg_182_1.hightColor2.r, (arg_182_1.time_ - 0) / var_185_3), Mathf.Lerp(iter_185_5.color.g, arg_182_1.hightColor2.g, (arg_182_1.time_ - 0) / var_185_3), (Mathf.Lerp(iter_185_5.color.b, arg_182_1.hightColor2.b, (arg_182_1.time_ - 0) / var_185_3)))
							else
								local var_185_4 = Mathf.Lerp(iter_185_5.color.r, 0.5, (arg_182_1.time_ - 0) / var_185_3)

								iter_185_5.color = Color.New(var_185_4, var_185_4, var_185_4)
							end
						end
					end
				end
			end

			if arg_182_1.time_ >= 0 + var_185_3 and arg_182_1.time_ < 0 + var_185_3 + arg_185_0 and not isNil(var_185_2) and arg_182_1.var_.actorSpriteComps1086 then
				for iter_185_6, iter_185_7 in pairs(arg_182_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_185_7 then
						iter_185_7.color = arg_182_1.isInRecall_ and (arg_182_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_182_1.var_.actorSpriteComps1086 = nil
			end

			local var_185_5 = 0
			local var_185_6 = 0.525

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_5 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_7 = arg_182_1:GetWordFromCfg(416051042)
				local var_185_8 = arg_182_1:FormatText(var_185_7.content)

				arg_182_1.text_.text = var_185_8

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_10 = 21 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 21)

				if (21 <= 0 and var_185_6 or var_185_6 * (utf8.len(var_185_8) / 21)) > 0 and var_185_6 < var_185_10 then
					arg_182_1.talkMaxDuration = var_185_10

					if var_185_10 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_10 + var_185_5
					end
				end

				arg_182_1.text_.text = var_185_8
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051042", "story_v_out_416051.awb") ~= 0 then
					local var_185_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051042", "story_v_out_416051.awb") / 1000

					if var_185_11 + var_185_5 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_11 + var_185_5
					end

					if var_185_7.prefab_name ~= "" and arg_182_1.actors_[var_185_7.prefab_name] ~= nil then
						local var_185_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_7.prefab_name].transform, "story_v_out_416051", "416051042", "story_v_out_416051.awb")

						arg_182_1:RecordAudio("416051042", var_185_12)
						arg_182_1:RecordAudio("416051042", var_185_12)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_416051", "416051042", "story_v_out_416051.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_416051", "416051042", "story_v_out_416051.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_13 = math.max(var_185_6, arg_182_1.talkMaxDuration)

			if var_185_5 <= arg_182_1.time_ and arg_182_1.time_ < var_185_5 + var_185_13 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_5) / var_185_13

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_5 + var_185_13 and arg_182_1.time_ < var_185_5 + var_185_13 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play416051043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 416051043
		arg_186_1.duration_ = 2.37

		local var_186_0 = {
			zh = 1.366,
			ja = 2.366
		}
		local var_186_1 = manager.audio:GetLocalizationFlag()

		if var_186_0[var_186_1] ~= nil then
			arg_186_1.duration_ = var_186_0[var_186_1]
		end

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play416051044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(arg_186_1.actors_["1028"]) and arg_186_1.var_.actorSpriteComps1028 == nil then
				arg_186_1.var_.actorSpriteComps1028 = arg_186_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_0 = 0.125

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 and not isNil(arg_186_1.actors_["1028"]) then
				if arg_186_1.var_.actorSpriteComps1028 then
					for iter_189_0, iter_189_1 in pairs(arg_186_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_189_1 then
							if arg_186_1.isInRecall_ then
								iter_189_1.color = Color.New(Mathf.Lerp(iter_189_1.color.r, arg_186_1.hightColor2.r, (arg_186_1.time_ - 0) / var_189_0), Mathf.Lerp(iter_189_1.color.g, arg_186_1.hightColor2.g, (arg_186_1.time_ - 0) / var_189_0), (Mathf.Lerp(iter_189_1.color.b, arg_186_1.hightColor2.b, (arg_186_1.time_ - 0) / var_189_0)))
							else
								local var_189_1 = Mathf.Lerp(iter_189_1.color.r, 0.5, (arg_186_1.time_ - 0) / var_189_0)

								iter_189_1.color = Color.New(var_189_1, var_189_1, var_189_1)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 and not isNil(arg_186_1.actors_["1028"]) and arg_186_1.var_.actorSpriteComps1028 then
				for iter_189_2, iter_189_3 in pairs(arg_186_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_189_3 then
						iter_189_3.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_186_1.var_.actorSpriteComps1028 = nil
			end

			local var_189_2 = arg_186_1.actors_["1086"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps1086 == nil then
				arg_186_1.var_.actorSpriteComps1086 = var_189_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_189_3 = 0.125

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 and not isNil(var_189_2) then
				if arg_186_1.var_.actorSpriteComps1086 then
					for iter_189_4, iter_189_5 in pairs(arg_186_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_189_5 then
							if arg_186_1.isInRecall_ then
								iter_189_5.color = Color.New(Mathf.Lerp(iter_189_5.color.r, arg_186_1.hightColor1.r, (arg_186_1.time_ - 0) / var_189_3), Mathf.Lerp(iter_189_5.color.g, arg_186_1.hightColor1.g, (arg_186_1.time_ - 0) / var_189_3), (Mathf.Lerp(iter_189_5.color.b, arg_186_1.hightColor1.b, (arg_186_1.time_ - 0) / var_189_3)))
							else
								local var_189_4 = Mathf.Lerp(iter_189_5.color.r, 1, (arg_186_1.time_ - 0) / var_189_3)

								iter_189_5.color = Color.New(var_189_4, var_189_4, var_189_4)
							end
						end
					end
				end
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 and not isNil(var_189_2) and arg_186_1.var_.actorSpriteComps1086 then
				for iter_189_6, iter_189_7 in pairs(arg_186_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_189_7 then
						iter_189_7.color = arg_186_1.isInRecall_ and (arg_186_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_186_1.var_.actorSpriteComps1086 = nil
			end

			local var_189_5 = 0
			local var_189_6 = 0.05

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_5 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_7 = arg_186_1:GetWordFromCfg(416051043)
				local var_189_8 = arg_186_1:FormatText(var_189_7.content)

				arg_186_1.text_.text = var_189_8

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_10 = 2 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 2)

				if (2 <= 0 and var_189_6 or var_189_6 * (utf8.len(var_189_8) / 2)) > 0 and var_189_6 < var_189_10 then
					arg_186_1.talkMaxDuration = var_189_10

					if var_189_10 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_10 + var_189_5
					end
				end

				arg_186_1.text_.text = var_189_8
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051043", "story_v_out_416051.awb") ~= 0 then
					local var_189_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051043", "story_v_out_416051.awb") / 1000

					if var_189_11 + var_189_5 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_11 + var_189_5
					end

					if var_189_7.prefab_name ~= "" and arg_186_1.actors_[var_189_7.prefab_name] ~= nil then
						local var_189_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_7.prefab_name].transform, "story_v_out_416051", "416051043", "story_v_out_416051.awb")

						arg_186_1:RecordAudio("416051043", var_189_12)
						arg_186_1:RecordAudio("416051043", var_189_12)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_416051", "416051043", "story_v_out_416051.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_416051", "416051043", "story_v_out_416051.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_6, arg_186_1.talkMaxDuration)

			if var_189_5 <= arg_186_1.time_ and arg_186_1.time_ < var_189_5 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_5) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_5 + var_189_13 and arg_186_1.time_ < var_189_5 + var_189_13 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {}

		arg_186_1:InitPlayNodeList()
	end,
	Play416051044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 416051044
		arg_190_1.duration_ = 6.03

		local var_190_0 = {
			zh = 5.566,
			ja = 6.033
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play416051045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1028"]) and arg_190_1.var_.actorSpriteComps1028 == nil then
				arg_190_1.var_.actorSpriteComps1028 = arg_190_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_0 = 0.125

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1028"]) then
				if arg_190_1.var_.actorSpriteComps1028 then
					for iter_193_0, iter_193_1 in pairs(arg_190_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_193_1 then
							if arg_190_1.isInRecall_ then
								iter_193_1.color = Color.New(Mathf.Lerp(iter_193_1.color.r, arg_190_1.hightColor1.r, (arg_190_1.time_ - 0) / var_193_0), Mathf.Lerp(iter_193_1.color.g, arg_190_1.hightColor1.g, (arg_190_1.time_ - 0) / var_193_0), (Mathf.Lerp(iter_193_1.color.b, arg_190_1.hightColor1.b, (arg_190_1.time_ - 0) / var_193_0)))
							else
								local var_193_1 = Mathf.Lerp(iter_193_1.color.r, 1, (arg_190_1.time_ - 0) / var_193_0)

								iter_193_1.color = Color.New(var_193_1, var_193_1, var_193_1)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1028"]) and arg_190_1.var_.actorSpriteComps1028 then
				for iter_193_2, iter_193_3 in pairs(arg_190_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_193_3 then
						iter_193_3.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_190_1.var_.actorSpriteComps1028 = nil
			end

			local var_193_2 = arg_190_1.actors_["1086"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.actorSpriteComps1086 == nil then
				arg_190_1.var_.actorSpriteComps1086 = var_193_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_193_3 = 0.125

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_3 and not isNil(var_193_2) then
				if arg_190_1.var_.actorSpriteComps1086 then
					for iter_193_4, iter_193_5 in pairs(arg_190_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_193_5 then
							if arg_190_1.isInRecall_ then
								iter_193_5.color = Color.New(Mathf.Lerp(iter_193_5.color.r, arg_190_1.hightColor2.r, (arg_190_1.time_ - 0) / var_193_3), Mathf.Lerp(iter_193_5.color.g, arg_190_1.hightColor2.g, (arg_190_1.time_ - 0) / var_193_3), (Mathf.Lerp(iter_193_5.color.b, arg_190_1.hightColor2.b, (arg_190_1.time_ - 0) / var_193_3)))
							else
								local var_193_4 = Mathf.Lerp(iter_193_5.color.r, 0.5, (arg_190_1.time_ - 0) / var_193_3)

								iter_193_5.color = Color.New(var_193_4, var_193_4, var_193_4)
							end
						end
					end
				end
			end

			if arg_190_1.time_ >= 0 + var_193_3 and arg_190_1.time_ < 0 + var_193_3 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.actorSpriteComps1086 then
				for iter_193_6, iter_193_7 in pairs(arg_190_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_193_7 then
						iter_193_7.color = arg_190_1.isInRecall_ and (arg_190_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_190_1.var_.actorSpriteComps1086 = nil
			end

			local var_193_5 = 0
			local var_193_6 = 0.35

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_5 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_7 = arg_190_1:GetWordFromCfg(416051044)
				local var_193_8 = arg_190_1:FormatText(var_193_7.content)

				arg_190_1.text_.text = var_193_8

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_10 = 14 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_8) / 14)

				if (14 <= 0 and var_193_6 or var_193_6 * (utf8.len(var_193_8) / 14)) > 0 and var_193_6 < var_193_10 then
					arg_190_1.talkMaxDuration = var_193_10

					if var_193_10 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_10 + var_193_5
					end
				end

				arg_190_1.text_.text = var_193_8
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051044", "story_v_out_416051.awb") ~= 0 then
					local var_193_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051044", "story_v_out_416051.awb") / 1000

					if var_193_11 + var_193_5 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_11 + var_193_5
					end

					if var_193_7.prefab_name ~= "" and arg_190_1.actors_[var_193_7.prefab_name] ~= nil then
						local var_193_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_7.prefab_name].transform, "story_v_out_416051", "416051044", "story_v_out_416051.awb")

						arg_190_1:RecordAudio("416051044", var_193_12)
						arg_190_1:RecordAudio("416051044", var_193_12)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_416051", "416051044", "story_v_out_416051.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_416051", "416051044", "story_v_out_416051.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_13 = math.max(var_193_6, arg_190_1.talkMaxDuration)

			if var_193_5 <= arg_190_1.time_ and arg_190_1.time_ < var_193_5 + var_193_13 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_5) / var_193_13

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_5 + var_193_13 and arg_190_1.time_ < var_193_5 + var_193_13 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play416051045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 416051045
		arg_194_1.duration_ = 4.5

		local var_194_0 = {
			zh = 2.533,
			ja = 4.5
		}
		local var_194_1 = manager.audio:GetLocalizationFlag()

		if var_194_0[var_194_1] ~= nil then
			arg_194_1.duration_ = var_194_0[var_194_1]
		end

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play416051046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["1028"]) and arg_194_1.var_.actorSpriteComps1028 == nil then
				arg_194_1.var_.actorSpriteComps1028 = arg_194_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_0 = 0.125

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["1028"]) then
				if arg_194_1.var_.actorSpriteComps1028 then
					for iter_197_0, iter_197_1 in pairs(arg_194_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_197_1 then
							if arg_194_1.isInRecall_ then
								iter_197_1.color = Color.New(Mathf.Lerp(iter_197_1.color.r, arg_194_1.hightColor2.r, (arg_194_1.time_ - 0) / var_197_0), Mathf.Lerp(iter_197_1.color.g, arg_194_1.hightColor2.g, (arg_194_1.time_ - 0) / var_197_0), (Mathf.Lerp(iter_197_1.color.b, arg_194_1.hightColor2.b, (arg_194_1.time_ - 0) / var_197_0)))
							else
								local var_197_1 = Mathf.Lerp(iter_197_1.color.r, 0.5, (arg_194_1.time_ - 0) / var_197_0)

								iter_197_1.color = Color.New(var_197_1, var_197_1, var_197_1)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["1028"]) and arg_194_1.var_.actorSpriteComps1028 then
				for iter_197_2, iter_197_3 in pairs(arg_194_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_197_3 then
						iter_197_3.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_194_1.var_.actorSpriteComps1028 = nil
			end

			local var_197_2 = arg_194_1.actors_["1086"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.actorSpriteComps1086 == nil then
				arg_194_1.var_.actorSpriteComps1086 = var_197_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_197_3 = 0.125

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.actorSpriteComps1086 then
					for iter_197_4, iter_197_5 in pairs(arg_194_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_197_5 then
							if arg_194_1.isInRecall_ then
								iter_197_5.color = Color.New(Mathf.Lerp(iter_197_5.color.r, arg_194_1.hightColor1.r, (arg_194_1.time_ - 0) / var_197_3), Mathf.Lerp(iter_197_5.color.g, arg_194_1.hightColor1.g, (arg_194_1.time_ - 0) / var_197_3), (Mathf.Lerp(iter_197_5.color.b, arg_194_1.hightColor1.b, (arg_194_1.time_ - 0) / var_197_3)))
							else
								local var_197_4 = Mathf.Lerp(iter_197_5.color.r, 1, (arg_194_1.time_ - 0) / var_197_3)

								iter_197_5.color = Color.New(var_197_4, var_197_4, var_197_4)
							end
						end
					end
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.actorSpriteComps1086 then
				for iter_197_6, iter_197_7 in pairs(arg_194_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_197_7 then
						iter_197_7.color = arg_194_1.isInRecall_ and (arg_194_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_194_1.var_.actorSpriteComps1086 = nil
			end

			local var_197_5 = 0
			local var_197_6 = 0.3

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_5 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_7 = arg_194_1:GetWordFromCfg(416051045)
				local var_197_8 = arg_194_1:FormatText(var_197_7.content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 12 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 12)

				if (12 <= 0 and var_197_6 or var_197_6 * (utf8.len(var_197_8) / 12)) > 0 and var_197_6 < var_197_10 then
					arg_194_1.talkMaxDuration = var_197_10

					if var_197_10 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_5
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051045", "story_v_out_416051.awb") ~= 0 then
					local var_197_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051045", "story_v_out_416051.awb") / 1000

					if var_197_11 + var_197_5 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_5
					end

					if var_197_7.prefab_name ~= "" and arg_194_1.actors_[var_197_7.prefab_name] ~= nil then
						local var_197_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_7.prefab_name].transform, "story_v_out_416051", "416051045", "story_v_out_416051.awb")

						arg_194_1:RecordAudio("416051045", var_197_12)
						arg_194_1:RecordAudio("416051045", var_197_12)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_416051", "416051045", "story_v_out_416051.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_416051", "416051045", "story_v_out_416051.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_13 = math.max(var_197_6, arg_194_1.talkMaxDuration)

			if var_197_5 <= arg_194_1.time_ and arg_194_1.time_ < var_197_5 + var_197_13 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_5) / var_197_13

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_5 + var_197_13 and arg_194_1.time_ < var_197_5 + var_197_13 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {}

		arg_194_1:InitPlayNodeList()
	end,
	Play416051046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 416051046
		arg_198_1.duration_ = 7.93

		local var_198_0 = {
			zh = 4.666,
			ja = 7.933
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play416051047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1028"]) and arg_198_1.var_.actorSpriteComps1028 == nil then
				arg_198_1.var_.actorSpriteComps1028 = arg_198_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_0 = 0.125

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1028"]) then
				if arg_198_1.var_.actorSpriteComps1028 then
					for iter_201_0, iter_201_1 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_201_1 then
							if arg_198_1.isInRecall_ then
								iter_201_1.color = Color.New(Mathf.Lerp(iter_201_1.color.r, arg_198_1.hightColor1.r, (arg_198_1.time_ - 0) / var_201_0), Mathf.Lerp(iter_201_1.color.g, arg_198_1.hightColor1.g, (arg_198_1.time_ - 0) / var_201_0), (Mathf.Lerp(iter_201_1.color.b, arg_198_1.hightColor1.b, (arg_198_1.time_ - 0) / var_201_0)))
							else
								local var_201_1 = Mathf.Lerp(iter_201_1.color.r, 1, (arg_198_1.time_ - 0) / var_201_0)

								iter_201_1.color = Color.New(var_201_1, var_201_1, var_201_1)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1028"]) and arg_198_1.var_.actorSpriteComps1028 then
				for iter_201_2, iter_201_3 in pairs(arg_198_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_201_3 then
						iter_201_3.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_198_1.var_.actorSpriteComps1028 = nil
			end

			local var_201_2 = arg_198_1.actors_["1086"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1086 == nil then
				arg_198_1.var_.actorSpriteComps1086 = var_201_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_201_3 = 0.125

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.actorSpriteComps1086 then
					for iter_201_4, iter_201_5 in pairs(arg_198_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_201_5 then
							if arg_198_1.isInRecall_ then
								iter_201_5.color = Color.New(Mathf.Lerp(iter_201_5.color.r, arg_198_1.hightColor2.r, (arg_198_1.time_ - 0) / var_201_3), Mathf.Lerp(iter_201_5.color.g, arg_198_1.hightColor2.g, (arg_198_1.time_ - 0) / var_201_3), (Mathf.Lerp(iter_201_5.color.b, arg_198_1.hightColor2.b, (arg_198_1.time_ - 0) / var_201_3)))
							else
								local var_201_4 = Mathf.Lerp(iter_201_5.color.r, 0.5, (arg_198_1.time_ - 0) / var_201_3)

								iter_201_5.color = Color.New(var_201_4, var_201_4, var_201_4)
							end
						end
					end
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.actorSpriteComps1086 then
				for iter_201_6, iter_201_7 in pairs(arg_198_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_201_7 then
						iter_201_7.color = arg_198_1.isInRecall_ and (arg_198_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_198_1.var_.actorSpriteComps1086 = nil
			end

			local var_201_5 = arg_198_1.actors_["1028"].transform

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1028 = var_201_5.localPosition
				var_201_5.localScale = Vector3.New(1, 1, 1)

				arg_198_1:CheckSpriteTmpPos("1028", 2)

				for iter_201_8 = 0, var_201_5.childCount - 1 do
					local var_201_6 = var_201_5:GetChild(iter_201_8)

					if var_201_6.name == "split_2" or not string.find(var_201_6.name, "split") then
						var_201_6.gameObject:SetActive(true)
					else
						var_201_6.gameObject:SetActive(false)
					end
				end
			end

			local var_201_7 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				var_201_5.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_198_1.time_ - 0) / var_201_7)
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				var_201_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_201_8 = 0
			local var_201_9 = 0.325

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:GetWordFromCfg(416051046)
				local var_201_11 = arg_198_1:FormatText(var_201_10.content)

				arg_198_1.text_.text = var_201_11

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_13 = 13 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 13)

				if (13 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_11) / 13)) > 0 and var_201_9 < var_201_13 then
					arg_198_1.talkMaxDuration = var_201_13

					if var_201_13 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_13 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_11
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051046", "story_v_out_416051.awb") ~= 0 then
					local var_201_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051046", "story_v_out_416051.awb") / 1000

					if var_201_14 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_14 + var_201_8
					end

					if var_201_10.prefab_name ~= "" and arg_198_1.actors_[var_201_10.prefab_name] ~= nil then
						local var_201_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_10.prefab_name].transform, "story_v_out_416051", "416051046", "story_v_out_416051.awb")

						arg_198_1:RecordAudio("416051046", var_201_15)
						arg_198_1:RecordAudio("416051046", var_201_15)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_416051", "416051046", "story_v_out_416051.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_416051", "416051046", "story_v_out_416051.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_16 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_16 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_16

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_16 and arg_198_1.time_ < var_201_8 + var_201_16 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play416051047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 416051047
		arg_202_1.duration_ = 5.1

		local var_202_0 = {
			zh = 3.6,
			ja = 5.1
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play416051048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1086 = arg_202_1.actors_["1086"].transform.localPosition
				arg_202_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("1086", 7)

				for iter_205_0 = 0, arg_202_1.actors_["1086"].transform.childCount - 1 do
					local var_205_0 = arg_202_1.actors_["1086"].transform:GetChild(iter_205_0)

					if var_205_0.name == "" or not string.find(var_205_0.name, "split") then
						var_205_0.gameObject:SetActive(true)
					else
						var_205_0.gameObject:SetActive(false)
					end
				end
			end

			local var_205_1 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 then
				arg_202_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_202_1.time_ - 0) / var_205_1)
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 then
				arg_202_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_205_2 = "10108"

			if arg_202_1.actors_["10108"] == nil then
				local var_205_3 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10108")

				if not isNil(var_205_3) then
					local var_205_4 = Object.Instantiate(var_205_3, arg_202_1.canvasGo_.transform)

					var_205_4.transform:SetSiblingIndex(1)

					var_205_4.name = var_205_2
					var_205_4.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_202_1.actors_[var_205_2] = var_205_4

					if arg_202_1.isInRecall_ then
						for iter_205_1, iter_205_2 in ipairs((var_205_4:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_205_2.color = arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_205_5 = arg_202_1.actors_["10108"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.actorSpriteComps10108 == nil then
				arg_202_1.var_.actorSpriteComps10108 = var_205_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_6 = 0.125

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_6 and not isNil(var_205_5) then
				if arg_202_1.var_.actorSpriteComps10108 then
					for iter_205_3, iter_205_4 in pairs(arg_202_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_205_4 then
							if arg_202_1.isInRecall_ then
								iter_205_4.color = Color.New(Mathf.Lerp(iter_205_4.color.r, arg_202_1.hightColor1.r, (arg_202_1.time_ - 0) / var_205_6), Mathf.Lerp(iter_205_4.color.g, arg_202_1.hightColor1.g, (arg_202_1.time_ - 0) / var_205_6), (Mathf.Lerp(iter_205_4.color.b, arg_202_1.hightColor1.b, (arg_202_1.time_ - 0) / var_205_6)))
							else
								local var_205_7 = Mathf.Lerp(iter_205_4.color.r, 1, (arg_202_1.time_ - 0) / var_205_6)

								iter_205_4.color = Color.New(var_205_7, var_205_7, var_205_7)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_6 and arg_202_1.time_ < 0 + var_205_6 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.actorSpriteComps10108 then
				for iter_205_5, iter_205_6 in pairs(arg_202_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_205_6 then
						iter_205_6.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_202_1.var_.actorSpriteComps10108 = nil
			end

			local var_205_8 = arg_202_1.actors_["10108"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10108 = var_205_8.localPosition
				var_205_8.localScale = Vector3.New(1, 1, 1)

				arg_202_1:CheckSpriteTmpPos("10108", 4)

				for iter_205_7 = 0, var_205_8.childCount - 1 do
					local var_205_9 = var_205_8:GetChild(iter_205_7)

					if var_205_9.name == "split_1" or not string.find(var_205_9.name, "split") then
						var_205_9.gameObject:SetActive(true)
					else
						var_205_9.gameObject:SetActive(false)
					end
				end
			end

			local var_205_10 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_10 then
				var_205_8.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_202_1.time_ - 0) / var_205_10)
			end

			if arg_202_1.time_ >= 0 + var_205_10 and arg_202_1.time_ < 0 + var_205_10 + arg_205_0 then
				var_205_8.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_205_11 = arg_202_1.actors_["1028"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.actorSpriteComps1028 == nil then
				arg_202_1.var_.actorSpriteComps1028 = var_205_11:GetComponentsInChildren(typeof(Image), true)
			end

			local var_205_12 = 0.125

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_12 and not isNil(var_205_11) then
				if arg_202_1.var_.actorSpriteComps1028 then
					for iter_205_8, iter_205_9 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_205_9 then
							if arg_202_1.isInRecall_ then
								iter_205_9.color = Color.New(Mathf.Lerp(iter_205_9.color.r, arg_202_1.hightColor2.r, (arg_202_1.time_ - 0) / var_205_12), Mathf.Lerp(iter_205_9.color.g, arg_202_1.hightColor2.g, (arg_202_1.time_ - 0) / var_205_12), (Mathf.Lerp(iter_205_9.color.b, arg_202_1.hightColor2.b, (arg_202_1.time_ - 0) / var_205_12)))
							else
								local var_205_13 = Mathf.Lerp(iter_205_9.color.r, 0.5, (arg_202_1.time_ - 0) / var_205_12)

								iter_205_9.color = Color.New(var_205_13, var_205_13, var_205_13)
							end
						end
					end
				end
			end

			if arg_202_1.time_ >= 0 + var_205_12 and arg_202_1.time_ < 0 + var_205_12 + arg_205_0 and not isNil(var_205_11) and arg_202_1.var_.actorSpriteComps1028 then
				for iter_205_10, iter_205_11 in pairs(arg_202_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_205_11 then
						iter_205_11.color = arg_202_1.isInRecall_ and (arg_202_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_202_1.var_.actorSpriteComps1028 = nil
			end

			local var_205_14 = 0
			local var_205_15 = 0.375

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_14 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_16 = arg_202_1:GetWordFromCfg(416051047)
				local var_205_17 = arg_202_1:FormatText(var_205_16.content)

				arg_202_1.text_.text = var_205_17

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_19 = 15 <= 0 and var_205_15 or var_205_15 * (utf8.len(var_205_17) / 15)

				if (15 <= 0 and var_205_15 or var_205_15 * (utf8.len(var_205_17) / 15)) > 0 and var_205_15 < var_205_19 then
					arg_202_1.talkMaxDuration = var_205_19

					if var_205_19 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_19 + var_205_14
					end
				end

				arg_202_1.text_.text = var_205_17
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051047", "story_v_out_416051.awb") ~= 0 then
					local var_205_20 = manager.audio:GetVoiceLength("story_v_out_416051", "416051047", "story_v_out_416051.awb") / 1000

					if var_205_20 + var_205_14 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_20 + var_205_14
					end

					if var_205_16.prefab_name ~= "" and arg_202_1.actors_[var_205_16.prefab_name] ~= nil then
						local var_205_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_16.prefab_name].transform, "story_v_out_416051", "416051047", "story_v_out_416051.awb")

						arg_202_1:RecordAudio("416051047", var_205_21)
						arg_202_1:RecordAudio("416051047", var_205_21)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_416051", "416051047", "story_v_out_416051.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_416051", "416051047", "story_v_out_416051.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_22 = math.max(var_205_15, arg_202_1.talkMaxDuration)

			if var_205_14 <= arg_202_1.time_ and arg_202_1.time_ < var_205_14 + var_205_22 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_14) / var_205_22

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_14 + var_205_22 and arg_202_1.time_ < var_205_14 + var_205_22 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play416051048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 416051048
		arg_206_1.duration_ = 4.63

		local var_206_0 = {
			zh = 4.333,
			ja = 4.633
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play416051049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(arg_206_1.actors_["1028"]) and arg_206_1.var_.actorSpriteComps1028 == nil then
				arg_206_1.var_.actorSpriteComps1028 = arg_206_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_0 = 0.125

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 and not isNil(arg_206_1.actors_["1028"]) then
				if arg_206_1.var_.actorSpriteComps1028 then
					for iter_209_0, iter_209_1 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_209_1 then
							if arg_206_1.isInRecall_ then
								iter_209_1.color = Color.New(Mathf.Lerp(iter_209_1.color.r, arg_206_1.hightColor1.r, (arg_206_1.time_ - 0) / var_209_0), Mathf.Lerp(iter_209_1.color.g, arg_206_1.hightColor1.g, (arg_206_1.time_ - 0) / var_209_0), (Mathf.Lerp(iter_209_1.color.b, arg_206_1.hightColor1.b, (arg_206_1.time_ - 0) / var_209_0)))
							else
								local var_209_1 = Mathf.Lerp(iter_209_1.color.r, 1, (arg_206_1.time_ - 0) / var_209_0)

								iter_209_1.color = Color.New(var_209_1, var_209_1, var_209_1)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 and not isNil(arg_206_1.actors_["1028"]) and arg_206_1.var_.actorSpriteComps1028 then
				for iter_209_2, iter_209_3 in pairs(arg_206_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_209_3 then
						iter_209_3.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_206_1.var_.actorSpriteComps1028 = nil
			end

			local var_209_2 = arg_206_1.actors_["10108"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps10108 == nil then
				arg_206_1.var_.actorSpriteComps10108 = var_209_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_209_3 = 0.125

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_3 and not isNil(var_209_2) then
				if arg_206_1.var_.actorSpriteComps10108 then
					for iter_209_4, iter_209_5 in pairs(arg_206_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_209_5 then
							if arg_206_1.isInRecall_ then
								iter_209_5.color = Color.New(Mathf.Lerp(iter_209_5.color.r, arg_206_1.hightColor2.r, (arg_206_1.time_ - 0) / var_209_3), Mathf.Lerp(iter_209_5.color.g, arg_206_1.hightColor2.g, (arg_206_1.time_ - 0) / var_209_3), (Mathf.Lerp(iter_209_5.color.b, arg_206_1.hightColor2.b, (arg_206_1.time_ - 0) / var_209_3)))
							else
								local var_209_4 = Mathf.Lerp(iter_209_5.color.r, 0.5, (arg_206_1.time_ - 0) / var_209_3)

								iter_209_5.color = Color.New(var_209_4, var_209_4, var_209_4)
							end
						end
					end
				end
			end

			if arg_206_1.time_ >= 0 + var_209_3 and arg_206_1.time_ < 0 + var_209_3 + arg_209_0 and not isNil(var_209_2) and arg_206_1.var_.actorSpriteComps10108 then
				for iter_209_6, iter_209_7 in pairs(arg_206_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_209_7 then
						iter_209_7.color = arg_206_1.isInRecall_ and (arg_206_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_206_1.var_.actorSpriteComps10108 = nil
			end

			local var_209_5 = arg_206_1.actors_["1028"].transform

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1028 = var_209_5.localPosition
				var_209_5.localScale = Vector3.New(1, 1, 1)

				arg_206_1:CheckSpriteTmpPos("1028", 2)

				for iter_209_8 = 0, var_209_5.childCount - 1 do
					local var_209_6 = var_209_5:GetChild(iter_209_8)

					if var_209_6.name == "split_7" or not string.find(var_209_6.name, "split") then
						var_209_6.gameObject:SetActive(true)
					else
						var_209_6.gameObject:SetActive(false)
					end
				end
			end

			local var_209_7 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_7 then
				var_209_5.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_206_1.time_ - 0) / var_209_7)
			end

			if arg_206_1.time_ >= 0 + var_209_7 and arg_206_1.time_ < 0 + var_209_7 + arg_209_0 then
				var_209_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_209_8 = 0
			local var_209_9 = 0.55

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_8 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_10 = arg_206_1:GetWordFromCfg(416051048)
				local var_209_11 = arg_206_1:FormatText(var_209_10.content)

				arg_206_1.text_.text = var_209_11

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_13 = 22 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 22)

				if (22 <= 0 and var_209_9 or var_209_9 * (utf8.len(var_209_11) / 22)) > 0 and var_209_9 < var_209_13 then
					arg_206_1.talkMaxDuration = var_209_13

					if var_209_13 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_13 + var_209_8
					end
				end

				arg_206_1.text_.text = var_209_11
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051048", "story_v_out_416051.awb") ~= 0 then
					local var_209_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051048", "story_v_out_416051.awb") / 1000

					if var_209_14 + var_209_8 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_8
					end

					if var_209_10.prefab_name ~= "" and arg_206_1.actors_[var_209_10.prefab_name] ~= nil then
						local var_209_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_10.prefab_name].transform, "story_v_out_416051", "416051048", "story_v_out_416051.awb")

						arg_206_1:RecordAudio("416051048", var_209_15)
						arg_206_1:RecordAudio("416051048", var_209_15)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_416051", "416051048", "story_v_out_416051.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_416051", "416051048", "story_v_out_416051.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_16 = math.max(var_209_9, arg_206_1.talkMaxDuration)

			if var_209_8 <= arg_206_1.time_ and arg_206_1.time_ < var_209_8 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_8) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_8 + var_209_16 and arg_206_1.time_ < var_209_8 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play416051049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 416051049
		arg_210_1.duration_ = 15.87

		local var_210_0 = {
			zh = 6.166,
			ja = 15.866
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play416051050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1028"]) and arg_210_1.var_.actorSpriteComps1028 == nil then
				arg_210_1.var_.actorSpriteComps1028 = arg_210_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_0 = 0.125

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1028"]) then
				if arg_210_1.var_.actorSpriteComps1028 then
					for iter_213_0, iter_213_1 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_213_1 then
							if arg_210_1.isInRecall_ then
								iter_213_1.color = Color.New(Mathf.Lerp(iter_213_1.color.r, arg_210_1.hightColor2.r, (arg_210_1.time_ - 0) / var_213_0), Mathf.Lerp(iter_213_1.color.g, arg_210_1.hightColor2.g, (arg_210_1.time_ - 0) / var_213_0), (Mathf.Lerp(iter_213_1.color.b, arg_210_1.hightColor2.b, (arg_210_1.time_ - 0) / var_213_0)))
							else
								local var_213_1 = Mathf.Lerp(iter_213_1.color.r, 0.5, (arg_210_1.time_ - 0) / var_213_0)

								iter_213_1.color = Color.New(var_213_1, var_213_1, var_213_1)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1028"]) and arg_210_1.var_.actorSpriteComps1028 then
				for iter_213_2, iter_213_3 in pairs(arg_210_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_213_3 then
						iter_213_3.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_210_1.var_.actorSpriteComps1028 = nil
			end

			local var_213_2 = arg_210_1.actors_["10108"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps10108 == nil then
				arg_210_1.var_.actorSpriteComps10108 = var_213_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_213_3 = 0.125

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.actorSpriteComps10108 then
					for iter_213_4, iter_213_5 in pairs(arg_210_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_213_5 then
							if arg_210_1.isInRecall_ then
								iter_213_5.color = Color.New(Mathf.Lerp(iter_213_5.color.r, arg_210_1.hightColor1.r, (arg_210_1.time_ - 0) / var_213_3), Mathf.Lerp(iter_213_5.color.g, arg_210_1.hightColor1.g, (arg_210_1.time_ - 0) / var_213_3), (Mathf.Lerp(iter_213_5.color.b, arg_210_1.hightColor1.b, (arg_210_1.time_ - 0) / var_213_3)))
							else
								local var_213_4 = Mathf.Lerp(iter_213_5.color.r, 1, (arg_210_1.time_ - 0) / var_213_3)

								iter_213_5.color = Color.New(var_213_4, var_213_4, var_213_4)
							end
						end
					end
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.actorSpriteComps10108 then
				for iter_213_6, iter_213_7 in pairs(arg_210_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_213_7 then
						iter_213_7.color = arg_210_1.isInRecall_ and (arg_210_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_210_1.var_.actorSpriteComps10108 = nil
			end

			local var_213_5 = 0
			local var_213_6 = 0.525

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_5 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_7 = arg_210_1:GetWordFromCfg(416051049)
				local var_213_8 = arg_210_1:FormatText(var_213_7.content)

				arg_210_1.text_.text = var_213_8

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_10 = 21 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 21)

				if (21 <= 0 and var_213_6 or var_213_6 * (utf8.len(var_213_8) / 21)) > 0 and var_213_6 < var_213_10 then
					arg_210_1.talkMaxDuration = var_213_10

					if var_213_10 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_5
					end
				end

				arg_210_1.text_.text = var_213_8
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051049", "story_v_out_416051.awb") ~= 0 then
					local var_213_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051049", "story_v_out_416051.awb") / 1000

					if var_213_11 + var_213_5 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_11 + var_213_5
					end

					if var_213_7.prefab_name ~= "" and arg_210_1.actors_[var_213_7.prefab_name] ~= nil then
						local var_213_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_7.prefab_name].transform, "story_v_out_416051", "416051049", "story_v_out_416051.awb")

						arg_210_1:RecordAudio("416051049", var_213_12)
						arg_210_1:RecordAudio("416051049", var_213_12)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_416051", "416051049", "story_v_out_416051.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_416051", "416051049", "story_v_out_416051.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_6, arg_210_1.talkMaxDuration)

			if var_213_5 <= arg_210_1.time_ and arg_210_1.time_ < var_213_5 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_5) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_5 + var_213_13 and arg_210_1.time_ < var_213_5 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play416051050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 416051050
		arg_214_1.duration_ = 6.73

		local var_214_0 = {
			zh = 4.633,
			ja = 6.733
		}
		local var_214_1 = manager.audio:GetLocalizationFlag()

		if var_214_0[var_214_1] ~= nil then
			arg_214_1.duration_ = var_214_0[var_214_1]
		end

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play416051051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1028"]) and arg_214_1.var_.actorSpriteComps1028 == nil then
				arg_214_1.var_.actorSpriteComps1028 = arg_214_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_0 = 0.125

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1028"]) then
				if arg_214_1.var_.actorSpriteComps1028 then
					for iter_217_0, iter_217_1 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_217_1 then
							if arg_214_1.isInRecall_ then
								iter_217_1.color = Color.New(Mathf.Lerp(iter_217_1.color.r, arg_214_1.hightColor1.r, (arg_214_1.time_ - 0) / var_217_0), Mathf.Lerp(iter_217_1.color.g, arg_214_1.hightColor1.g, (arg_214_1.time_ - 0) / var_217_0), (Mathf.Lerp(iter_217_1.color.b, arg_214_1.hightColor1.b, (arg_214_1.time_ - 0) / var_217_0)))
							else
								local var_217_1 = Mathf.Lerp(iter_217_1.color.r, 1, (arg_214_1.time_ - 0) / var_217_0)

								iter_217_1.color = Color.New(var_217_1, var_217_1, var_217_1)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1028"]) and arg_214_1.var_.actorSpriteComps1028 then
				for iter_217_2, iter_217_3 in pairs(arg_214_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_217_3 then
						iter_217_3.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_214_1.var_.actorSpriteComps1028 = nil
			end

			local var_217_2 = arg_214_1.actors_["10108"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps10108 == nil then
				arg_214_1.var_.actorSpriteComps10108 = var_217_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_217_3 = 0.125

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.actorSpriteComps10108 then
					for iter_217_4, iter_217_5 in pairs(arg_214_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_217_5 then
							if arg_214_1.isInRecall_ then
								iter_217_5.color = Color.New(Mathf.Lerp(iter_217_5.color.r, arg_214_1.hightColor2.r, (arg_214_1.time_ - 0) / var_217_3), Mathf.Lerp(iter_217_5.color.g, arg_214_1.hightColor2.g, (arg_214_1.time_ - 0) / var_217_3), (Mathf.Lerp(iter_217_5.color.b, arg_214_1.hightColor2.b, (arg_214_1.time_ - 0) / var_217_3)))
							else
								local var_217_4 = Mathf.Lerp(iter_217_5.color.r, 0.5, (arg_214_1.time_ - 0) / var_217_3)

								iter_217_5.color = Color.New(var_217_4, var_217_4, var_217_4)
							end
						end
					end
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.actorSpriteComps10108 then
				for iter_217_6, iter_217_7 in pairs(arg_214_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_217_7 then
						iter_217_7.color = arg_214_1.isInRecall_ and (arg_214_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_214_1.var_.actorSpriteComps10108 = nil
			end

			local var_217_5 = arg_214_1.actors_["1028"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1028 = var_217_5.localPosition
				var_217_5.localScale = Vector3.New(1, 1, 1)

				arg_214_1:CheckSpriteTmpPos("1028", 2)

				for iter_217_8 = 0, var_217_5.childCount - 1 do
					local var_217_6 = var_217_5:GetChild(iter_217_8)

					if var_217_6.name == "split_4" or not string.find(var_217_6.name, "split") then
						var_217_6.gameObject:SetActive(true)
					else
						var_217_6.gameObject:SetActive(false)
					end
				end
			end

			local var_217_7 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_7 then
				var_217_5.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_214_1.time_ - 0) / var_217_7)
			end

			if arg_214_1.time_ >= 0 + var_217_7 and arg_214_1.time_ < 0 + var_217_7 + arg_217_0 then
				var_217_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_217_8 = 0
			local var_217_9 = 0.4

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_8 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_10 = arg_214_1:GetWordFromCfg(416051050)
				local var_217_11 = arg_214_1:FormatText(var_217_10.content)

				arg_214_1.text_.text = var_217_11

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_13 = 16 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 16)

				if (16 <= 0 and var_217_9 or var_217_9 * (utf8.len(var_217_11) / 16)) > 0 and var_217_9 < var_217_13 then
					arg_214_1.talkMaxDuration = var_217_13

					if var_217_13 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_13 + var_217_8
					end
				end

				arg_214_1.text_.text = var_217_11
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051050", "story_v_out_416051.awb") ~= 0 then
					local var_217_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051050", "story_v_out_416051.awb") / 1000

					if var_217_14 + var_217_8 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_14 + var_217_8
					end

					if var_217_10.prefab_name ~= "" and arg_214_1.actors_[var_217_10.prefab_name] ~= nil then
						local var_217_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_10.prefab_name].transform, "story_v_out_416051", "416051050", "story_v_out_416051.awb")

						arg_214_1:RecordAudio("416051050", var_217_15)
						arg_214_1:RecordAudio("416051050", var_217_15)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_416051", "416051050", "story_v_out_416051.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_416051", "416051050", "story_v_out_416051.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_16 = math.max(var_217_9, arg_214_1.talkMaxDuration)

			if var_217_8 <= arg_214_1.time_ and arg_214_1.time_ < var_217_8 + var_217_16 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_8) / var_217_16

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_8 + var_217_16 and arg_214_1.time_ < var_217_8 + var_217_16 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play416051051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 416051051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play416051052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(arg_218_1.actors_["1028"]) and arg_218_1.var_.actorSpriteComps1028 == nil then
				arg_218_1.var_.actorSpriteComps1028 = arg_218_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_0 = 0.125

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 and not isNil(arg_218_1.actors_["1028"]) then
				if arg_218_1.var_.actorSpriteComps1028 then
					for iter_221_0, iter_221_1 in pairs(arg_218_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_221_1 then
							if arg_218_1.isInRecall_ then
								iter_221_1.color = Color.New(Mathf.Lerp(iter_221_1.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_0), Mathf.Lerp(iter_221_1.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_0), (Mathf.Lerp(iter_221_1.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_0)))
							else
								local var_221_1 = Mathf.Lerp(iter_221_1.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_0)

								iter_221_1.color = Color.New(var_221_1, var_221_1, var_221_1)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 and not isNil(arg_218_1.actors_["1028"]) and arg_218_1.var_.actorSpriteComps1028 then
				for iter_221_2, iter_221_3 in pairs(arg_218_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_221_3 then
						iter_221_3.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps1028 = nil
			end

			local var_221_2 = arg_218_1.actors_["10108"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps10108 == nil then
				arg_218_1.var_.actorSpriteComps10108 = var_221_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_221_3 = 0.125

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 and not isNil(var_221_2) then
				if arg_218_1.var_.actorSpriteComps10108 then
					for iter_221_4, iter_221_5 in pairs(arg_218_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_221_5 then
							if arg_218_1.isInRecall_ then
								iter_221_5.color = Color.New(Mathf.Lerp(iter_221_5.color.r, arg_218_1.hightColor2.r, (arg_218_1.time_ - 0) / var_221_3), Mathf.Lerp(iter_221_5.color.g, arg_218_1.hightColor2.g, (arg_218_1.time_ - 0) / var_221_3), (Mathf.Lerp(iter_221_5.color.b, arg_218_1.hightColor2.b, (arg_218_1.time_ - 0) / var_221_3)))
							else
								local var_221_4 = Mathf.Lerp(iter_221_5.color.r, 0.5, (arg_218_1.time_ - 0) / var_221_3)

								iter_221_5.color = Color.New(var_221_4, var_221_4, var_221_4)
							end
						end
					end
				end
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 and not isNil(var_221_2) and arg_218_1.var_.actorSpriteComps10108 then
				for iter_221_6, iter_221_7 in pairs(arg_218_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_221_7 then
						iter_221_7.color = arg_218_1.isInRecall_ and (arg_218_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_218_1.var_.actorSpriteComps10108 = nil
			end

			local var_221_5 = 0
			local var_221_6 = 1.575

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_5 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_7 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(416051051).content)

				arg_218_1.text_.text = var_221_7

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_9 = 63 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 63)

				if (63 <= 0 and var_221_6 or var_221_6 * (utf8.len(var_221_7) / 63)) > 0 and var_221_6 < var_221_9 then
					arg_218_1.talkMaxDuration = var_221_9

					if var_221_9 + var_221_5 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_9 + var_221_5
					end
				end

				arg_218_1.text_.text = var_221_7
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_10 = math.max(var_221_6, arg_218_1.talkMaxDuration)

			if var_221_5 <= arg_218_1.time_ and arg_218_1.time_ < var_221_5 + var_221_10 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_5) / var_221_10

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_5 + var_221_10 and arg_218_1.time_ < var_221_5 + var_221_10 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play416051052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 416051052
		arg_222_1.duration_ = 9.63

		local var_222_0 = {
			zh = 4.166,
			ja = 9.633
		}
		local var_222_1 = manager.audio:GetLocalizationFlag()

		if var_222_0[var_222_1] ~= nil then
			arg_222_1.duration_ = var_222_0[var_222_1]
		end

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play416051053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(arg_222_1.actors_["1028"]) and arg_222_1.var_.actorSpriteComps1028 == nil then
				arg_222_1.var_.actorSpriteComps1028 = arg_222_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_0 = 0.2

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_0 and not isNil(arg_222_1.actors_["1028"]) then
				if arg_222_1.var_.actorSpriteComps1028 then
					for iter_225_0, iter_225_1 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_225_1 then
							if arg_222_1.isInRecall_ then
								iter_225_1.color = Color.New(Mathf.Lerp(iter_225_1.color.r, arg_222_1.hightColor2.r, (arg_222_1.time_ - 0) / var_225_0), Mathf.Lerp(iter_225_1.color.g, arg_222_1.hightColor2.g, (arg_222_1.time_ - 0) / var_225_0), (Mathf.Lerp(iter_225_1.color.b, arg_222_1.hightColor2.b, (arg_222_1.time_ - 0) / var_225_0)))
							else
								local var_225_1 = Mathf.Lerp(iter_225_1.color.r, 0.5, (arg_222_1.time_ - 0) / var_225_0)

								iter_225_1.color = Color.New(var_225_1, var_225_1, var_225_1)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_0 and arg_222_1.time_ < 0 + var_225_0 + arg_225_0 and not isNil(arg_222_1.actors_["1028"]) and arg_222_1.var_.actorSpriteComps1028 then
				for iter_225_2, iter_225_3 in pairs(arg_222_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_225_3 then
						iter_225_3.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_222_1.var_.actorSpriteComps1028 = nil
			end

			local var_225_2 = arg_222_1.actors_["10108"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10108 == nil then
				arg_222_1.var_.actorSpriteComps10108 = var_225_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_225_3 = 0.125

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_3 and not isNil(var_225_2) then
				if arg_222_1.var_.actorSpriteComps10108 then
					for iter_225_4, iter_225_5 in pairs(arg_222_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_225_5 then
							if arg_222_1.isInRecall_ then
								iter_225_5.color = Color.New(Mathf.Lerp(iter_225_5.color.r, arg_222_1.hightColor1.r, (arg_222_1.time_ - 0) / var_225_3), Mathf.Lerp(iter_225_5.color.g, arg_222_1.hightColor1.g, (arg_222_1.time_ - 0) / var_225_3), (Mathf.Lerp(iter_225_5.color.b, arg_222_1.hightColor1.b, (arg_222_1.time_ - 0) / var_225_3)))
							else
								local var_225_4 = Mathf.Lerp(iter_225_5.color.r, 1, (arg_222_1.time_ - 0) / var_225_3)

								iter_225_5.color = Color.New(var_225_4, var_225_4, var_225_4)
							end
						end
					end
				end
			end

			if arg_222_1.time_ >= 0 + var_225_3 and arg_222_1.time_ < 0 + var_225_3 + arg_225_0 and not isNil(var_225_2) and arg_222_1.var_.actorSpriteComps10108 then
				for iter_225_6, iter_225_7 in pairs(arg_222_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_225_7 then
						iter_225_7.color = arg_222_1.isInRecall_ and (arg_222_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_222_1.var_.actorSpriteComps10108 = nil
			end

			local var_225_5 = arg_222_1.actors_["10108"].transform

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos10108 = var_225_5.localPosition
				var_225_5.localScale = Vector3.New(1, 1, 1)

				arg_222_1:CheckSpriteTmpPos("10108", 4)

				for iter_225_8 = 0, var_225_5.childCount - 1 do
					local var_225_6 = var_225_5:GetChild(iter_225_8)

					if var_225_6.name == "split_2" or not string.find(var_225_6.name, "split") then
						var_225_6.gameObject:SetActive(true)
					else
						var_225_6.gameObject:SetActive(false)
					end
				end
			end

			local var_225_7 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_7 then
				var_225_5.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos10108, Vector3.New(390, -399.6, -130), (arg_222_1.time_ - 0) / var_225_7)
			end

			if arg_222_1.time_ >= 0 + var_225_7 and arg_222_1.time_ < 0 + var_225_7 + arg_225_0 then
				var_225_5.localPosition = Vector3.New(390, -399.6, -130)
			end

			local var_225_8 = 0
			local var_225_9 = 0.35

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_8 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_10 = arg_222_1:GetWordFromCfg(416051052)
				local var_225_11 = arg_222_1:FormatText(var_225_10.content)

				arg_222_1.text_.text = var_225_11

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_13 = 14 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 14)

				if (14 <= 0 and var_225_9 or var_225_9 * (utf8.len(var_225_11) / 14)) > 0 and var_225_9 < var_225_13 then
					arg_222_1.talkMaxDuration = var_225_13

					if var_225_13 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_13 + var_225_8
					end
				end

				arg_222_1.text_.text = var_225_11
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051052", "story_v_out_416051.awb") ~= 0 then
					local var_225_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051052", "story_v_out_416051.awb") / 1000

					if var_225_14 + var_225_8 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_14 + var_225_8
					end

					if var_225_10.prefab_name ~= "" and arg_222_1.actors_[var_225_10.prefab_name] ~= nil then
						local var_225_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_222_1.actors_[var_225_10.prefab_name].transform, "story_v_out_416051", "416051052", "story_v_out_416051.awb")

						arg_222_1:RecordAudio("416051052", var_225_15)
						arg_222_1:RecordAudio("416051052", var_225_15)
					else
						arg_222_1:AudioAction("play", "voice", "story_v_out_416051", "416051052", "story_v_out_416051.awb")
					end

					arg_222_1:RecordHistoryTalkVoice("story_v_out_416051", "416051052", "story_v_out_416051.awb")
				end

				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_16 = math.max(var_225_9, arg_222_1.talkMaxDuration)

			if var_225_8 <= arg_222_1.time_ and arg_222_1.time_ < var_225_8 + var_225_16 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_8) / var_225_16

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_8 + var_225_16 and arg_222_1.time_ < var_225_8 + var_225_16 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_222_1:InitPlayNodeList()
	end,
	Play416051053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 416051053
		arg_226_1.duration_ = 10.87

		local var_226_0 = {
			zh = 3.166,
			ja = 10.866
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play416051054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.325

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_1 = arg_226_1:GetWordFromCfg(416051053)
				local var_229_2 = arg_226_1:FormatText(var_229_1.content)

				arg_226_1.text_.text = var_229_2

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_4 = 13 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 13)

				if (13 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_2) / 13)) > 0 and var_229_0 < var_229_4 then
					arg_226_1.talkMaxDuration = var_229_4

					if var_229_4 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_4 + 0
					end
				end

				arg_226_1.text_.text = var_229_2
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051053", "story_v_out_416051.awb") ~= 0 then
					local var_229_5 = manager.audio:GetVoiceLength("story_v_out_416051", "416051053", "story_v_out_416051.awb") / 1000

					if var_229_5 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + 0
					end

					if var_229_1.prefab_name ~= "" and arg_226_1.actors_[var_229_1.prefab_name] ~= nil then
						local var_229_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_1.prefab_name].transform, "story_v_out_416051", "416051053", "story_v_out_416051.awb")

						arg_226_1:RecordAudio("416051053", var_229_6)
						arg_226_1:RecordAudio("416051053", var_229_6)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_416051", "416051053", "story_v_out_416051.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_416051", "416051053", "story_v_out_416051.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_7 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_7 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_7

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_7 and arg_226_1.time_ < 0 + var_229_7 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play416051054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 416051054
		arg_230_1.duration_ = 5.63

		local var_230_0 = {
			zh = 2.833,
			ja = 5.633
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play416051055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["1028"]) and arg_230_1.var_.actorSpriteComps1028 == nil then
				arg_230_1.var_.actorSpriteComps1028 = arg_230_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_0 = 0.125

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["1028"]) then
				if arg_230_1.var_.actorSpriteComps1028 then
					for iter_233_0, iter_233_1 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_233_1 then
							if arg_230_1.isInRecall_ then
								iter_233_1.color = Color.New(Mathf.Lerp(iter_233_1.color.r, arg_230_1.hightColor1.r, (arg_230_1.time_ - 0) / var_233_0), Mathf.Lerp(iter_233_1.color.g, arg_230_1.hightColor1.g, (arg_230_1.time_ - 0) / var_233_0), (Mathf.Lerp(iter_233_1.color.b, arg_230_1.hightColor1.b, (arg_230_1.time_ - 0) / var_233_0)))
							else
								local var_233_1 = Mathf.Lerp(iter_233_1.color.r, 1, (arg_230_1.time_ - 0) / var_233_0)

								iter_233_1.color = Color.New(var_233_1, var_233_1, var_233_1)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["1028"]) and arg_230_1.var_.actorSpriteComps1028 then
				for iter_233_2, iter_233_3 in pairs(arg_230_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_233_3 then
						iter_233_3.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_230_1.var_.actorSpriteComps1028 = nil
			end

			local var_233_2 = arg_230_1.actors_["10108"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10108 == nil then
				arg_230_1.var_.actorSpriteComps10108 = var_233_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_233_3 = 0.125

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_3 and not isNil(var_233_2) then
				if arg_230_1.var_.actorSpriteComps10108 then
					for iter_233_4, iter_233_5 in pairs(arg_230_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_233_5 then
							if arg_230_1.isInRecall_ then
								iter_233_5.color = Color.New(Mathf.Lerp(iter_233_5.color.r, arg_230_1.hightColor2.r, (arg_230_1.time_ - 0) / var_233_3), Mathf.Lerp(iter_233_5.color.g, arg_230_1.hightColor2.g, (arg_230_1.time_ - 0) / var_233_3), (Mathf.Lerp(iter_233_5.color.b, arg_230_1.hightColor2.b, (arg_230_1.time_ - 0) / var_233_3)))
							else
								local var_233_4 = Mathf.Lerp(iter_233_5.color.r, 0.5, (arg_230_1.time_ - 0) / var_233_3)

								iter_233_5.color = Color.New(var_233_4, var_233_4, var_233_4)
							end
						end
					end
				end
			end

			if arg_230_1.time_ >= 0 + var_233_3 and arg_230_1.time_ < 0 + var_233_3 + arg_233_0 and not isNil(var_233_2) and arg_230_1.var_.actorSpriteComps10108 then
				for iter_233_6, iter_233_7 in pairs(arg_230_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_233_7 then
						iter_233_7.color = arg_230_1.isInRecall_ and (arg_230_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_230_1.var_.actorSpriteComps10108 = nil
			end

			local var_233_5 = arg_230_1.actors_["1028"].transform

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1028 = var_233_5.localPosition
				var_233_5.localScale = Vector3.New(1, 1, 1)

				arg_230_1:CheckSpriteTmpPos("1028", 2)

				for iter_233_8 = 0, var_233_5.childCount - 1 do
					local var_233_6 = var_233_5:GetChild(iter_233_8)

					if var_233_6.name == "split_4" or not string.find(var_233_6.name, "split") then
						var_233_6.gameObject:SetActive(true)
					else
						var_233_6.gameObject:SetActive(false)
					end
				end
			end

			local var_233_7 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				var_233_5.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_230_1.time_ - 0) / var_233_7)
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				var_233_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_233_8 = 0
			local var_233_9 = 0.2

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_8 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_10 = arg_230_1:GetWordFromCfg(416051054)
				local var_233_11 = arg_230_1:FormatText(var_233_10.content)

				arg_230_1.text_.text = var_233_11

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_13 = 8 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 8)

				if (8 <= 0 and var_233_9 or var_233_9 * (utf8.len(var_233_11) / 8)) > 0 and var_233_9 < var_233_13 then
					arg_230_1.talkMaxDuration = var_233_13

					if var_233_13 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_13 + var_233_8
					end
				end

				arg_230_1.text_.text = var_233_11
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051054", "story_v_out_416051.awb") ~= 0 then
					local var_233_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051054", "story_v_out_416051.awb") / 1000

					if var_233_14 + var_233_8 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_14 + var_233_8
					end

					if var_233_10.prefab_name ~= "" and arg_230_1.actors_[var_233_10.prefab_name] ~= nil then
						local var_233_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_10.prefab_name].transform, "story_v_out_416051", "416051054", "story_v_out_416051.awb")

						arg_230_1:RecordAudio("416051054", var_233_15)
						arg_230_1:RecordAudio("416051054", var_233_15)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_416051", "416051054", "story_v_out_416051.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_416051", "416051054", "story_v_out_416051.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_16 = math.max(var_233_9, arg_230_1.talkMaxDuration)

			if var_233_8 <= arg_230_1.time_ and arg_230_1.time_ < var_233_8 + var_233_16 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_8) / var_233_16

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_8 + var_233_16 and arg_230_1.time_ < var_233_8 + var_233_16 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play416051055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 416051055
		arg_234_1.duration_ = 5.77

		local var_234_0 = {
			zh = 3.2,
			ja = 5.766
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play416051056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["1028"]) and arg_234_1.var_.actorSpriteComps1028 == nil then
				arg_234_1.var_.actorSpriteComps1028 = arg_234_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_0 = 0.125

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["1028"]) then
				if arg_234_1.var_.actorSpriteComps1028 then
					for iter_237_0, iter_237_1 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_237_1 then
							if arg_234_1.isInRecall_ then
								iter_237_1.color = Color.New(Mathf.Lerp(iter_237_1.color.r, arg_234_1.hightColor2.r, (arg_234_1.time_ - 0) / var_237_0), Mathf.Lerp(iter_237_1.color.g, arg_234_1.hightColor2.g, (arg_234_1.time_ - 0) / var_237_0), (Mathf.Lerp(iter_237_1.color.b, arg_234_1.hightColor2.b, (arg_234_1.time_ - 0) / var_237_0)))
							else
								local var_237_1 = Mathf.Lerp(iter_237_1.color.r, 0.5, (arg_234_1.time_ - 0) / var_237_0)

								iter_237_1.color = Color.New(var_237_1, var_237_1, var_237_1)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["1028"]) and arg_234_1.var_.actorSpriteComps1028 then
				for iter_237_2, iter_237_3 in pairs(arg_234_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_237_3 then
						iter_237_3.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_234_1.var_.actorSpriteComps1028 = nil
			end

			local var_237_2 = arg_234_1.actors_["10108"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps10108 == nil then
				arg_234_1.var_.actorSpriteComps10108 = var_237_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_237_3 = 0.125

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_3 and not isNil(var_237_2) then
				if arg_234_1.var_.actorSpriteComps10108 then
					for iter_237_4, iter_237_5 in pairs(arg_234_1.var_.actorSpriteComps10108:ToTable()) do
						if iter_237_5 then
							if arg_234_1.isInRecall_ then
								iter_237_5.color = Color.New(Mathf.Lerp(iter_237_5.color.r, arg_234_1.hightColor1.r, (arg_234_1.time_ - 0) / var_237_3), Mathf.Lerp(iter_237_5.color.g, arg_234_1.hightColor1.g, (arg_234_1.time_ - 0) / var_237_3), (Mathf.Lerp(iter_237_5.color.b, arg_234_1.hightColor1.b, (arg_234_1.time_ - 0) / var_237_3)))
							else
								local var_237_4 = Mathf.Lerp(iter_237_5.color.r, 1, (arg_234_1.time_ - 0) / var_237_3)

								iter_237_5.color = Color.New(var_237_4, var_237_4, var_237_4)
							end
						end
					end
				end
			end

			if arg_234_1.time_ >= 0 + var_237_3 and arg_234_1.time_ < 0 + var_237_3 + arg_237_0 and not isNil(var_237_2) and arg_234_1.var_.actorSpriteComps10108 then
				for iter_237_6, iter_237_7 in pairs(arg_234_1.var_.actorSpriteComps10108:ToTable()) do
					if iter_237_7 then
						iter_237_7.color = arg_234_1.isInRecall_ and (arg_234_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_234_1.var_.actorSpriteComps10108 = nil
			end

			local var_237_5 = 0
			local var_237_6 = 0.325

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_5 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1083].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_7 = arg_234_1:GetWordFromCfg(416051055)
				local var_237_8 = arg_234_1:FormatText(var_237_7.content)

				arg_234_1.text_.text = var_237_8

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_10 = 13 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_8) / 13)

				if (13 <= 0 and var_237_6 or var_237_6 * (utf8.len(var_237_8) / 13)) > 0 and var_237_6 < var_237_10 then
					arg_234_1.talkMaxDuration = var_237_10

					if var_237_10 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_5
					end
				end

				arg_234_1.text_.text = var_237_8
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051055", "story_v_out_416051.awb") ~= 0 then
					local var_237_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051055", "story_v_out_416051.awb") / 1000

					if var_237_11 + var_237_5 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_11 + var_237_5
					end

					if var_237_7.prefab_name ~= "" and arg_234_1.actors_[var_237_7.prefab_name] ~= nil then
						local var_237_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_7.prefab_name].transform, "story_v_out_416051", "416051055", "story_v_out_416051.awb")

						arg_234_1:RecordAudio("416051055", var_237_12)
						arg_234_1:RecordAudio("416051055", var_237_12)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_416051", "416051055", "story_v_out_416051.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_416051", "416051055", "story_v_out_416051.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_13 = math.max(var_237_6, arg_234_1.talkMaxDuration)

			if var_237_5 <= arg_234_1.time_ and arg_234_1.time_ < var_237_5 + var_237_13 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_5) / var_237_13

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_5 + var_237_13 and arg_234_1.time_ < var_237_5 + var_237_13 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play416051056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 416051056
		arg_238_1.duration_ = 8.37

		local var_238_0 = {
			zh = 5.733,
			ja = 8.366
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play416051057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10108 = arg_238_1.actors_["10108"].transform.localPosition
				arg_238_1.actors_["10108"].transform.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("10108", 7)

				for iter_241_0 = 0, arg_238_1.actors_["10108"].transform.childCount - 1 do
					local var_241_0 = arg_238_1.actors_["10108"].transform:GetChild(iter_241_0)

					if var_241_0.name == "" or not string.find(var_241_0.name, "split") then
						var_241_0.gameObject:SetActive(true)
					else
						var_241_0.gameObject:SetActive(false)
					end
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["10108"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10108, Vector3.New(0, -2000, 0), (arg_238_1.time_ - 0) / var_241_1)
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["10108"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_241_2 = arg_238_1.actors_["1028"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1028 == nil then
				arg_238_1.var_.actorSpriteComps1028 = var_241_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_3 = 0.125

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 and not isNil(var_241_2) then
				if arg_238_1.var_.actorSpriteComps1028 then
					for iter_241_1, iter_241_2 in pairs(arg_238_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_241_2 then
							if arg_238_1.isInRecall_ then
								iter_241_2.color = Color.New(Mathf.Lerp(iter_241_2.color.r, arg_238_1.hightColor2.r, (arg_238_1.time_ - 0) / var_241_3), Mathf.Lerp(iter_241_2.color.g, arg_238_1.hightColor2.g, (arg_238_1.time_ - 0) / var_241_3), (Mathf.Lerp(iter_241_2.color.b, arg_238_1.hightColor2.b, (arg_238_1.time_ - 0) / var_241_3)))
							else
								local var_241_4 = Mathf.Lerp(iter_241_2.color.r, 0.5, (arg_238_1.time_ - 0) / var_241_3)

								iter_241_2.color = Color.New(var_241_4, var_241_4, var_241_4)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 and not isNil(var_241_2) and arg_238_1.var_.actorSpriteComps1028 then
				for iter_241_3, iter_241_4 in pairs(arg_238_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_241_4 then
						iter_241_4.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_238_1.var_.actorSpriteComps1028 = nil
			end

			local var_241_5 = arg_238_1.actors_["1086"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.actorSpriteComps1086 == nil then
				arg_238_1.var_.actorSpriteComps1086 = var_241_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_241_6 = 0.125

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_6 and not isNil(var_241_5) then
				if arg_238_1.var_.actorSpriteComps1086 then
					for iter_241_5, iter_241_6 in pairs(arg_238_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_241_6 then
							if arg_238_1.isInRecall_ then
								iter_241_6.color = Color.New(Mathf.Lerp(iter_241_6.color.r, arg_238_1.hightColor1.r, (arg_238_1.time_ - 0) / var_241_6), Mathf.Lerp(iter_241_6.color.g, arg_238_1.hightColor1.g, (arg_238_1.time_ - 0) / var_241_6), (Mathf.Lerp(iter_241_6.color.b, arg_238_1.hightColor1.b, (arg_238_1.time_ - 0) / var_241_6)))
							else
								local var_241_7 = Mathf.Lerp(iter_241_6.color.r, 1, (arg_238_1.time_ - 0) / var_241_6)

								iter_241_6.color = Color.New(var_241_7, var_241_7, var_241_7)
							end
						end
					end
				end
			end

			if arg_238_1.time_ >= 0 + var_241_6 and arg_238_1.time_ < 0 + var_241_6 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.actorSpriteComps1086 then
				for iter_241_7, iter_241_8 in pairs(arg_238_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_241_8 then
						iter_241_8.color = arg_238_1.isInRecall_ and (arg_238_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_238_1.var_.actorSpriteComps1086 = nil
			end

			local var_241_8 = arg_238_1.actors_["1086"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1086 = var_241_8.localPosition
				var_241_8.localScale = Vector3.New(1, 1, 1)

				arg_238_1:CheckSpriteTmpPos("1086", 4)

				for iter_241_9 = 0, var_241_8.childCount - 1 do
					local var_241_9 = var_241_8:GetChild(iter_241_9)

					if var_241_9.name == "split_2" or not string.find(var_241_9.name, "split") then
						var_241_9.gameObject:SetActive(true)
					else
						var_241_9.gameObject:SetActive(false)
					end
				end
			end

			local var_241_10 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_10 then
				var_241_8.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_238_1.time_ - 0) / var_241_10)
			end

			if arg_238_1.time_ >= 0 + var_241_10 and arg_238_1.time_ < 0 + var_241_10 + arg_241_0 then
				var_241_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_241_11 = 0
			local var_241_12 = 0.675

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_11 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_13 = arg_238_1:GetWordFromCfg(416051056)
				local var_241_14 = arg_238_1:FormatText(var_241_13.content)

				arg_238_1.text_.text = var_241_14

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_16 = 27 <= 0 and var_241_12 or var_241_12 * (utf8.len(var_241_14) / 27)

				if (27 <= 0 and var_241_12 or var_241_12 * (utf8.len(var_241_14) / 27)) > 0 and var_241_12 < var_241_16 then
					arg_238_1.talkMaxDuration = var_241_16

					if var_241_16 + var_241_11 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_16 + var_241_11
					end
				end

				arg_238_1.text_.text = var_241_14
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051056", "story_v_out_416051.awb") ~= 0 then
					local var_241_17 = manager.audio:GetVoiceLength("story_v_out_416051", "416051056", "story_v_out_416051.awb") / 1000

					if var_241_17 + var_241_11 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_17 + var_241_11
					end

					if var_241_13.prefab_name ~= "" and arg_238_1.actors_[var_241_13.prefab_name] ~= nil then
						local var_241_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_13.prefab_name].transform, "story_v_out_416051", "416051056", "story_v_out_416051.awb")

						arg_238_1:RecordAudio("416051056", var_241_18)
						arg_238_1:RecordAudio("416051056", var_241_18)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_416051", "416051056", "story_v_out_416051.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_416051", "416051056", "story_v_out_416051.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_19 = math.max(var_241_12, arg_238_1.talkMaxDuration)

			if var_241_11 <= arg_238_1.time_ and arg_238_1.time_ < var_241_11 + var_241_19 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_11) / var_241_19

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_11 + var_241_19 and arg_238_1.time_ < var_241_11 + var_241_19 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10108",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play416051057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 416051057
		arg_242_1.duration_ = 9.73

		local var_242_0 = {
			zh = 7.4,
			ja = 9.733
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play416051058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(arg_242_1.actors_["1086"]) and arg_242_1.var_.actorSpriteComps1086 == nil then
				arg_242_1.var_.actorSpriteComps1086 = arg_242_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_0 = 0.125

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 and not isNil(arg_242_1.actors_["1086"]) then
				if arg_242_1.var_.actorSpriteComps1086 then
					for iter_245_0, iter_245_1 in pairs(arg_242_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_245_1 then
							if arg_242_1.isInRecall_ then
								iter_245_1.color = Color.New(Mathf.Lerp(iter_245_1.color.r, arg_242_1.hightColor2.r, (arg_242_1.time_ - 0) / var_245_0), Mathf.Lerp(iter_245_1.color.g, arg_242_1.hightColor2.g, (arg_242_1.time_ - 0) / var_245_0), (Mathf.Lerp(iter_245_1.color.b, arg_242_1.hightColor2.b, (arg_242_1.time_ - 0) / var_245_0)))
							else
								local var_245_1 = Mathf.Lerp(iter_245_1.color.r, 0.5, (arg_242_1.time_ - 0) / var_245_0)

								iter_245_1.color = Color.New(var_245_1, var_245_1, var_245_1)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 and not isNil(arg_242_1.actors_["1086"]) and arg_242_1.var_.actorSpriteComps1086 then
				for iter_245_2, iter_245_3 in pairs(arg_242_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_245_3 then
						iter_245_3.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_242_1.var_.actorSpriteComps1086 = nil
			end

			local var_245_2 = arg_242_1.actors_["1028"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps1028 == nil then
				arg_242_1.var_.actorSpriteComps1028 = var_245_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_245_3 = 0.125

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_3 and not isNil(var_245_2) then
				if arg_242_1.var_.actorSpriteComps1028 then
					for iter_245_4, iter_245_5 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_245_5 then
							if arg_242_1.isInRecall_ then
								iter_245_5.color = Color.New(Mathf.Lerp(iter_245_5.color.r, arg_242_1.hightColor1.r, (arg_242_1.time_ - 0) / var_245_3), Mathf.Lerp(iter_245_5.color.g, arg_242_1.hightColor1.g, (arg_242_1.time_ - 0) / var_245_3), (Mathf.Lerp(iter_245_5.color.b, arg_242_1.hightColor1.b, (arg_242_1.time_ - 0) / var_245_3)))
							else
								local var_245_4 = Mathf.Lerp(iter_245_5.color.r, 1, (arg_242_1.time_ - 0) / var_245_3)

								iter_245_5.color = Color.New(var_245_4, var_245_4, var_245_4)
							end
						end
					end
				end
			end

			if arg_242_1.time_ >= 0 + var_245_3 and arg_242_1.time_ < 0 + var_245_3 + arg_245_0 and not isNil(var_245_2) and arg_242_1.var_.actorSpriteComps1028 then
				for iter_245_6, iter_245_7 in pairs(arg_242_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_245_7 then
						iter_245_7.color = arg_242_1.isInRecall_ and (arg_242_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_242_1.var_.actorSpriteComps1028 = nil
			end

			local var_245_5 = arg_242_1.actors_["1028"].transform

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1028 = var_245_5.localPosition
				var_245_5.localScale = Vector3.New(1, 1, 1)

				arg_242_1:CheckSpriteTmpPos("1028", 2)

				for iter_245_8 = 0, var_245_5.childCount - 1 do
					local var_245_6 = var_245_5:GetChild(iter_245_8)

					if var_245_6.name == "" or not string.find(var_245_6.name, "split") then
						var_245_6.gameObject:SetActive(true)
					else
						var_245_6.gameObject:SetActive(false)
					end
				end
			end

			local var_245_7 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				var_245_5.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_242_1.time_ - 0) / var_245_7)
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				var_245_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_245_8 = 0
			local var_245_9 = 0.8

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_8 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_10 = arg_242_1:GetWordFromCfg(416051057)
				local var_245_11 = arg_242_1:FormatText(var_245_10.content)

				arg_242_1.text_.text = var_245_11

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_13 = 32 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 32)

				if (32 <= 0 and var_245_9 or var_245_9 * (utf8.len(var_245_11) / 32)) > 0 and var_245_9 < var_245_13 then
					arg_242_1.talkMaxDuration = var_245_13

					if var_245_13 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_13 + var_245_8
					end
				end

				arg_242_1.text_.text = var_245_11
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051057", "story_v_out_416051.awb") ~= 0 then
					local var_245_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051057", "story_v_out_416051.awb") / 1000

					if var_245_14 + var_245_8 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_14 + var_245_8
					end

					if var_245_10.prefab_name ~= "" and arg_242_1.actors_[var_245_10.prefab_name] ~= nil then
						local var_245_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_10.prefab_name].transform, "story_v_out_416051", "416051057", "story_v_out_416051.awb")

						arg_242_1:RecordAudio("416051057", var_245_15)
						arg_242_1:RecordAudio("416051057", var_245_15)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_416051", "416051057", "story_v_out_416051.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_416051", "416051057", "story_v_out_416051.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_16 = math.max(var_245_9, arg_242_1.talkMaxDuration)

			if var_245_8 <= arg_242_1.time_ and arg_242_1.time_ < var_245_8 + var_245_16 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_8) / var_245_16

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_8 + var_245_16 and arg_242_1.time_ < var_245_8 + var_245_16 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_242_1:InitPlayNodeList()
	end,
	Play416051058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 416051058
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play416051059(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1086"]) and arg_246_1.var_.actorSpriteComps1086 == nil then
				arg_246_1.var_.actorSpriteComps1086 = arg_246_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_0 = 0.125

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1086"]) then
				if arg_246_1.var_.actorSpriteComps1086 then
					for iter_249_0, iter_249_1 in pairs(arg_246_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_249_1 then
							if arg_246_1.isInRecall_ then
								iter_249_1.color = Color.New(Mathf.Lerp(iter_249_1.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_0), Mathf.Lerp(iter_249_1.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_0), (Mathf.Lerp(iter_249_1.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_0)))
							else
								local var_249_1 = Mathf.Lerp(iter_249_1.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_0)

								iter_249_1.color = Color.New(var_249_1, var_249_1, var_249_1)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1086"]) and arg_246_1.var_.actorSpriteComps1086 then
				for iter_249_2, iter_249_3 in pairs(arg_246_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_249_3 then
						iter_249_3.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps1086 = nil
			end

			local var_249_2 = arg_246_1.actors_["1028"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps1028 == nil then
				arg_246_1.var_.actorSpriteComps1028 = var_249_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_249_3 = 0.125

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_3 and not isNil(var_249_2) then
				if arg_246_1.var_.actorSpriteComps1028 then
					for iter_249_4, iter_249_5 in pairs(arg_246_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_249_5 then
							if arg_246_1.isInRecall_ then
								iter_249_5.color = Color.New(Mathf.Lerp(iter_249_5.color.r, arg_246_1.hightColor2.r, (arg_246_1.time_ - 0) / var_249_3), Mathf.Lerp(iter_249_5.color.g, arg_246_1.hightColor2.g, (arg_246_1.time_ - 0) / var_249_3), (Mathf.Lerp(iter_249_5.color.b, arg_246_1.hightColor2.b, (arg_246_1.time_ - 0) / var_249_3)))
							else
								local var_249_4 = Mathf.Lerp(iter_249_5.color.r, 0.5, (arg_246_1.time_ - 0) / var_249_3)

								iter_249_5.color = Color.New(var_249_4, var_249_4, var_249_4)
							end
						end
					end
				end
			end

			if arg_246_1.time_ >= 0 + var_249_3 and arg_246_1.time_ < 0 + var_249_3 + arg_249_0 and not isNil(var_249_2) and arg_246_1.var_.actorSpriteComps1028 then
				for iter_249_6, iter_249_7 in pairs(arg_246_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_249_7 then
						iter_249_7.color = arg_246_1.isInRecall_ and (arg_246_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_246_1.var_.actorSpriteComps1028 = nil
			end

			local var_249_5 = arg_246_1.actors_["1028"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1028 = var_249_5.localPosition
				var_249_5.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1028", 7)

				for iter_249_8 = 0, var_249_5.childCount - 1 do
					local var_249_6 = var_249_5:GetChild(iter_249_8)

					if var_249_6.name == "split_2" or not string.find(var_249_6.name, "split") then
						var_249_6.gameObject:SetActive(true)
					else
						var_249_6.gameObject:SetActive(false)
					end
				end
			end

			local var_249_7 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_7 then
				var_249_5.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_246_1.time_ - 0) / var_249_7)
			end

			if arg_246_1.time_ >= 0 + var_249_7 and arg_246_1.time_ < 0 + var_249_7 + arg_249_0 then
				var_249_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_249_8 = arg_246_1.actors_["1086"].transform

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1086 = var_249_8.localPosition
				var_249_8.localScale = Vector3.New(1, 1, 1)

				arg_246_1:CheckSpriteTmpPos("1086", 7)

				for iter_249_9 = 0, var_249_8.childCount - 1 do
					local var_249_9 = var_249_8:GetChild(iter_249_9)

					if var_249_9.name == "split_2" or not string.find(var_249_9.name, "split") then
						var_249_9.gameObject:SetActive(true)
					else
						var_249_9.gameObject:SetActive(false)
					end
				end
			end

			local var_249_10 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_10 then
				var_249_8.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_246_1.time_ - 0) / var_249_10)
			end

			if arg_246_1.time_ >= 0 + var_249_10 and arg_246_1.time_ < 0 + var_249_10 + arg_249_0 then
				var_249_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_249_11 = 0
			local var_249_12 = 1.675

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_11 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_13 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(416051058).content)

				arg_246_1.text_.text = var_249_13

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_15 = 67 <= 0 and var_249_12 or var_249_12 * (utf8.len(var_249_13) / 67)

				if (67 <= 0 and var_249_12 or var_249_12 * (utf8.len(var_249_13) / 67)) > 0 and var_249_12 < var_249_15 then
					arg_246_1.talkMaxDuration = var_249_15

					if var_249_15 + var_249_11 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_15 + var_249_11
					end
				end

				arg_246_1.text_.text = var_249_13
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_16 = math.max(var_249_12, arg_246_1.talkMaxDuration)

			if var_249_11 <= arg_246_1.time_ and arg_246_1.time_ < var_249_11 + var_249_16 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_11) / var_249_16

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_11 + var_249_16 and arg_246_1.time_ < var_249_11 + var_249_16 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	Play416051059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 416051059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play416051060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1:AudioAction("play", "effect", "se_story_17", "se_story_17_door_close02", "")
			end

			local var_253_1 = 0
			local var_253_2 = 0.9

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_1 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_3 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(416051059).content)

				arg_250_1.text_.text = var_253_3

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_5 = 36 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 36)

				if (36 <= 0 and var_253_2 or var_253_2 * (utf8.len(var_253_3) / 36)) > 0 and var_253_2 < var_253_5 then
					arg_250_1.talkMaxDuration = var_253_5

					if var_253_5 + var_253_1 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_5 + var_253_1
					end
				end

				arg_250_1.text_.text = var_253_3
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_6 = math.max(var_253_2, arg_250_1.talkMaxDuration)

			if var_253_1 <= arg_250_1.time_ and arg_250_1.time_ < var_253_1 + var_253_6 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_1) / var_253_6

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_1 + var_253_6 and arg_250_1.time_ < var_253_1 + var_253_6 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play416051060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 416051060
		arg_254_1.duration_ = 2.3

		local var_254_0 = {
			zh = 1.733,
			ja = 2.3
		}
		local var_254_1 = manager.audio:GetLocalizationFlag()

		if var_254_0[var_254_1] ~= nil then
			arg_254_1.duration_ = var_254_0[var_254_1]
		end

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play416051061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["1086"]) and arg_254_1.var_.actorSpriteComps1086 == nil then
				arg_254_1.var_.actorSpriteComps1086 = arg_254_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_0 = 0.125

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["1086"]) then
				if arg_254_1.var_.actorSpriteComps1086 then
					for iter_257_0, iter_257_1 in pairs(arg_254_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_257_1 then
							if arg_254_1.isInRecall_ then
								iter_257_1.color = Color.New(Mathf.Lerp(iter_257_1.color.r, arg_254_1.hightColor1.r, (arg_254_1.time_ - 0) / var_257_0), Mathf.Lerp(iter_257_1.color.g, arg_254_1.hightColor1.g, (arg_254_1.time_ - 0) / var_257_0), (Mathf.Lerp(iter_257_1.color.b, arg_254_1.hightColor1.b, (arg_254_1.time_ - 0) / var_257_0)))
							else
								local var_257_1 = Mathf.Lerp(iter_257_1.color.r, 1, (arg_254_1.time_ - 0) / var_257_0)

								iter_257_1.color = Color.New(var_257_1, var_257_1, var_257_1)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["1086"]) and arg_254_1.var_.actorSpriteComps1086 then
				for iter_257_2, iter_257_3 in pairs(arg_254_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_257_3 then
						iter_257_3.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_254_1.var_.actorSpriteComps1086 = nil
			end

			local var_257_2 = arg_254_1.actors_["1028"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps1028 == nil then
				arg_254_1.var_.actorSpriteComps1028 = var_257_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_257_3 = 0.125

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_3 and not isNil(var_257_2) then
				if arg_254_1.var_.actorSpriteComps1028 then
					for iter_257_4, iter_257_5 in pairs(arg_254_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_257_5 then
							if arg_254_1.isInRecall_ then
								iter_257_5.color = Color.New(Mathf.Lerp(iter_257_5.color.r, arg_254_1.hightColor2.r, (arg_254_1.time_ - 0) / var_257_3), Mathf.Lerp(iter_257_5.color.g, arg_254_1.hightColor2.g, (arg_254_1.time_ - 0) / var_257_3), (Mathf.Lerp(iter_257_5.color.b, arg_254_1.hightColor2.b, (arg_254_1.time_ - 0) / var_257_3)))
							else
								local var_257_4 = Mathf.Lerp(iter_257_5.color.r, 0.5, (arg_254_1.time_ - 0) / var_257_3)

								iter_257_5.color = Color.New(var_257_4, var_257_4, var_257_4)
							end
						end
					end
				end
			end

			if arg_254_1.time_ >= 0 + var_257_3 and arg_254_1.time_ < 0 + var_257_3 + arg_257_0 and not isNil(var_257_2) and arg_254_1.var_.actorSpriteComps1028 then
				for iter_257_6, iter_257_7 in pairs(arg_254_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_257_7 then
						iter_257_7.color = arg_254_1.isInRecall_ and (arg_254_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_254_1.var_.actorSpriteComps1028 = nil
			end

			local var_257_5 = arg_254_1.actors_["1028"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1028 = var_257_5.localPosition
				var_257_5.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1028", 2)

				for iter_257_8 = 0, var_257_5.childCount - 1 do
					local var_257_6 = var_257_5:GetChild(iter_257_8)

					if var_257_6.name == "split_2" or not string.find(var_257_6.name, "split") then
						var_257_6.gameObject:SetActive(true)
					else
						var_257_6.gameObject:SetActive(false)
					end
				end
			end

			local var_257_7 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_7 then
				var_257_5.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_254_1.time_ - 0) / var_257_7)
			end

			if arg_254_1.time_ >= 0 + var_257_7 and arg_254_1.time_ < 0 + var_257_7 + arg_257_0 then
				var_257_5.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_257_8 = arg_254_1.actors_["1086"].transform

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1086 = var_257_8.localPosition
				var_257_8.localScale = Vector3.New(1, 1, 1)

				arg_254_1:CheckSpriteTmpPos("1086", 4)

				for iter_257_9 = 0, var_257_8.childCount - 1 do
					local var_257_9 = var_257_8:GetChild(iter_257_9)

					if var_257_9.name == "split_1" or not string.find(var_257_9.name, "split") then
						var_257_9.gameObject:SetActive(true)
					else
						var_257_9.gameObject:SetActive(false)
					end
				end
			end

			local var_257_10 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_10 then
				var_257_8.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_254_1.time_ - 0) / var_257_10)
			end

			if arg_254_1.time_ >= 0 + var_257_10 and arg_254_1.time_ < 0 + var_257_10 + arg_257_0 then
				var_257_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_257_11 = 0
			local var_257_12 = 0.175

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_11 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_13 = arg_254_1:GetWordFromCfg(416051060)
				local var_257_14 = arg_254_1:FormatText(var_257_13.content)

				arg_254_1.text_.text = var_257_14

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_16 = 7 <= 0 and var_257_12 or var_257_12 * (utf8.len(var_257_14) / 7)

				if (7 <= 0 and var_257_12 or var_257_12 * (utf8.len(var_257_14) / 7)) > 0 and var_257_12 < var_257_16 then
					arg_254_1.talkMaxDuration = var_257_16

					if var_257_16 + var_257_11 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_16 + var_257_11
					end
				end

				arg_254_1.text_.text = var_257_14
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051060", "story_v_out_416051.awb") ~= 0 then
					local var_257_17 = manager.audio:GetVoiceLength("story_v_out_416051", "416051060", "story_v_out_416051.awb") / 1000

					if var_257_17 + var_257_11 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_17 + var_257_11
					end

					if var_257_13.prefab_name ~= "" and arg_254_1.actors_[var_257_13.prefab_name] ~= nil then
						local var_257_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_13.prefab_name].transform, "story_v_out_416051", "416051060", "story_v_out_416051.awb")

						arg_254_1:RecordAudio("416051060", var_257_18)
						arg_254_1:RecordAudio("416051060", var_257_18)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_416051", "416051060", "story_v_out_416051.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_416051", "416051060", "story_v_out_416051.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_19 = math.max(var_257_12, arg_254_1.talkMaxDuration)

			if var_257_11 <= arg_254_1.time_ and arg_254_1.time_ < var_257_11 + var_257_19 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_11) / var_257_19

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_11 + var_257_19 and arg_254_1.time_ < var_257_11 + var_257_19 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play416051061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 416051061
		arg_258_1.duration_ = 11

		local var_258_0 = {
			zh = 10.466,
			ja = 11
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play416051062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 4 < arg_258_1.time_ and arg_258_1.time_ <= 4 + arg_261_0 then
				arg_258_1.allBtn_.enabled = false
			end

			if arg_258_1.time_ >= 4 + 0.3 and arg_258_1.time_ < 4 + 0.3 + arg_261_0 then
				arg_258_1.allBtn_.enabled = true
			end

			local var_261_0 = "I13f"

			if arg_258_1.bgs_.I13f == nil then
				local var_261_1 = Object.Instantiate(arg_258_1.paintGo_)

				var_261_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_261_0)
				var_261_1.name = var_261_0
				var_261_1.transform.parent = arg_258_1.stage_.transform
				var_261_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_258_1.bgs_[var_261_0] = var_261_1
			end

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= 2 + arg_261_0 then
				local var_261_2 = arg_258_1.bgs_.I13f

				arg_258_1.bgs_.I13f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_261_2.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_261_3 = var_261_2:GetComponent("SpriteRenderer")

				if var_261_3 and var_261_3.sprite then
					local var_261_4 = 2 * (var_261_2.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_261_2.transform.localScale = Vector3.New(var_261_4 / var_261_3.sprite.bounds.size.y < var_261_4 * manager.ui.mainCameraCom_.aspect / var_261_3.sprite.bounds.size.x and var_261_4 * manager.ui.mainCameraCom_.aspect / var_261_3.sprite.bounds.size.x or var_261_4 / var_261_3.sprite.bounds.size.y, var_261_4 / var_261_3.sprite.bounds.size.y < var_261_4 * manager.ui.mainCameraCom_.aspect / var_261_3.sprite.bounds.size.x and var_261_4 * manager.ui.mainCameraCom_.aspect / var_261_3.sprite.bounds.size.x or var_261_4 / var_261_3.sprite.bounds.size.y, 0)
				end

				for iter_261_0, iter_261_1 in pairs(arg_258_1.bgs_) do
					if iter_261_0 ~= "I13f" then
						iter_261_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_261_5 = 0

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_5 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_6 = 2

			if var_261_5 <= arg_258_1.time_ and arg_258_1.time_ < var_261_5 + var_261_6 then
				local var_261_7 = Color.New(0, 0, 0)

				var_261_7.a = Mathf.Lerp(0, 1, (arg_258_1.time_ - var_261_5) / var_261_6)
				arg_258_1.mask_.color = var_261_7
			end

			if arg_258_1.time_ >= var_261_5 + var_261_6 and arg_258_1.time_ < var_261_5 + var_261_6 + arg_261_0 then
				local var_261_8 = Color.New(0, 0, 0)

				var_261_8.a = 1
				arg_258_1.mask_.color = var_261_8
			end

			local var_261_9 = 2

			if 2 < arg_258_1.time_ and arg_258_1.time_ <= var_261_9 + arg_261_0 then
				arg_258_1.mask_.enabled = true
				arg_258_1.mask_.raycastTarget = true

				arg_258_1:SetGaussion(false)
			end

			local var_261_10 = 2

			if var_261_9 <= arg_258_1.time_ and arg_258_1.time_ < var_261_9 + var_261_10 then
				local var_261_11 = Color.New(0, 0, 0)

				var_261_11.a = Mathf.Lerp(1, 0, (arg_258_1.time_ - var_261_9) / var_261_10)
				arg_258_1.mask_.color = var_261_11
			end

			if arg_258_1.time_ >= var_261_9 + var_261_10 and arg_258_1.time_ < var_261_9 + var_261_10 + arg_261_0 then
				local var_261_12 = Color.New(0, 0, 0)

				arg_258_1.mask_.enabled = false
				var_261_12.a = 0
				arg_258_1.mask_.color = var_261_12
			end

			local var_261_13 = arg_258_1.actors_["1028"].transform

			if 1.966 < arg_258_1.time_ and arg_258_1.time_ <= 1.966 + arg_261_0 then
				arg_258_1.var_.moveOldPos1028 = var_261_13.localPosition
				var_261_13.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1028", 7)

				for iter_261_2 = 0, var_261_13.childCount - 1 do
					local var_261_14 = var_261_13:GetChild(iter_261_2)

					if var_261_14.name == "" or not string.find(var_261_14.name, "split") then
						var_261_14.gameObject:SetActive(true)
					else
						var_261_14.gameObject:SetActive(false)
					end
				end
			end

			local var_261_15 = 0.001

			if 1.966 <= arg_258_1.time_ and arg_258_1.time_ < 1.966 + var_261_15 then
				var_261_13.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_258_1.time_ - 1.966) / var_261_15)
			end

			if arg_258_1.time_ >= 1.966 + var_261_15 and arg_258_1.time_ < 1.966 + var_261_15 + arg_261_0 then
				var_261_13.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_16 = arg_258_1.actors_["1086"].transform

			if 1.966 < arg_258_1.time_ and arg_258_1.time_ <= 1.966 + arg_261_0 then
				arg_258_1.var_.moveOldPos1086 = var_261_16.localPosition
				var_261_16.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1086", 7)

				for iter_261_3 = 0, var_261_16.childCount - 1 do
					local var_261_17 = var_261_16:GetChild(iter_261_3)

					if var_261_17.name == "" or not string.find(var_261_17.name, "split") then
						var_261_17.gameObject:SetActive(true)
					else
						var_261_17.gameObject:SetActive(false)
					end
				end
			end

			local var_261_18 = 0.001

			if 1.966 <= arg_258_1.time_ and arg_258_1.time_ < 1.966 + var_261_18 then
				var_261_16.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_258_1.time_ - 1.966) / var_261_18)
			end

			if arg_258_1.time_ >= 1.966 + var_261_18 and arg_258_1.time_ < 1.966 + var_261_18 + arg_261_0 then
				var_261_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_261_19 = arg_258_1.actors_["1086"].transform

			if 3.46733333333333 < arg_258_1.time_ and arg_258_1.time_ <= 3.46733333333333 + arg_261_0 then
				arg_258_1.var_.moveOldPos1086 = var_261_19.localPosition
				var_261_19.localScale = Vector3.New(1, 1, 1)

				arg_258_1:CheckSpriteTmpPos("1086", 3)

				for iter_261_4 = 0, var_261_19.childCount - 1 do
					local var_261_20 = var_261_19:GetChild(iter_261_4)

					if var_261_20.name == "" or not string.find(var_261_20.name, "split") then
						var_261_20.gameObject:SetActive(true)
					else
						var_261_20.gameObject:SetActive(false)
					end
				end
			end

			local var_261_21 = 0.001

			if 3.46733333333333 <= arg_258_1.time_ and arg_258_1.time_ < 3.46733333333333 + var_261_21 then
				var_261_19.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_258_1.time_ - 3.46733333333333) / var_261_21)
			end

			if arg_258_1.time_ >= 3.46733333333333 + var_261_21 and arg_258_1.time_ < 3.46733333333333 + var_261_21 + arg_261_0 then
				var_261_19.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_261_22 = arg_258_1.actors_["1086"]

			if 3.468 < arg_258_1.time_ and arg_258_1.time_ <= 3.468 + arg_261_0 and not isNil(var_261_22) and arg_258_1.var_.actorSpriteComps1086 == nil then
				arg_258_1.var_.actorSpriteComps1086 = var_261_22:GetComponentsInChildren(typeof(Image), true)
			end

			local var_261_23 = 0.125

			if 3.468 <= arg_258_1.time_ and arg_258_1.time_ < 3.468 + var_261_23 and not isNil(var_261_22) then
				if arg_258_1.var_.actorSpriteComps1086 then
					for iter_261_5, iter_261_6 in pairs(arg_258_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_261_6 then
							if arg_258_1.isInRecall_ then
								iter_261_6.color = Color.New(Mathf.Lerp(iter_261_6.color.r, arg_258_1.hightColor1.r, (arg_258_1.time_ - 3.468) / var_261_23), Mathf.Lerp(iter_261_6.color.g, arg_258_1.hightColor1.g, (arg_258_1.time_ - 3.468) / var_261_23), (Mathf.Lerp(iter_261_6.color.b, arg_258_1.hightColor1.b, (arg_258_1.time_ - 3.468) / var_261_23)))
							else
								local var_261_24 = Mathf.Lerp(iter_261_6.color.r, 1, (arg_258_1.time_ - 3.468) / var_261_23)

								iter_261_6.color = Color.New(var_261_24, var_261_24, var_261_24)
							end
						end
					end
				end
			end

			if arg_258_1.time_ >= 3.468 + var_261_23 and arg_258_1.time_ < 3.468 + var_261_23 + arg_261_0 and not isNil(var_261_22) and arg_258_1.var_.actorSpriteComps1086 then
				for iter_261_7, iter_261_8 in pairs(arg_258_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_261_8 then
						iter_261_8.color = arg_258_1.isInRecall_ and (arg_258_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_258_1.var_.actorSpriteComps1086 = nil
			end

			if 3.46733333333333 < arg_258_1.time_ and arg_258_1.time_ <= 3.46733333333333 + arg_261_0 then
				local var_261_25 = arg_258_1.actors_["1086"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_261_25 then
					arg_258_1.var_.alphaOldValue1086 = var_261_25.alpha
					arg_258_1.var_.characterEffect1086 = var_261_25
				end

				arg_258_1.var_.alphaOldValue1086 = 0
			end

			local var_261_26 = 0.857666666666667

			if 3.46733333333333 <= arg_258_1.time_ and arg_258_1.time_ < 3.46733333333333 + var_261_26 then
				if arg_258_1.var_.characterEffect1086 then
					arg_258_1.var_.characterEffect1086.alpha = Mathf.Lerp(arg_258_1.var_.alphaOldValue1086, 1, (arg_258_1.time_ - 3.46733333333333) / var_261_26)
				end
			end

			if arg_258_1.time_ >= 3.46733333333333 + var_261_26 and arg_258_1.time_ < 3.46733333333333 + var_261_26 + arg_261_0 and arg_258_1.var_.characterEffect1086 then
				arg_258_1.var_.characterEffect1086.alpha = 1
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_261_29 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_258_1.bgmTxt_.text ~= var_261_29 and arg_258_1.bgmTxt_.text ~= "" then
						if arg_258_1.bgmTxt2_.text ~= "" then
							arg_258_1.bgmTxt_.text = arg_258_1.bgmTxt2_.text
						end

						arg_258_1.bgmTxt2_.text = var_261_29

						arg_258_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_258_1.bgmTxt_.text = var_261_29
						arg_258_1.bgmTxt2_.text = var_261_29
					end

					if arg_258_1.bgmTimer then
						arg_258_1.bgmTimer:Stop()

						arg_258_1.bgmTimer = nil
					end

					if arg_258_1.settingData.show_music_name == 1 then
						arg_258_1.musicController:SetSelectedState("show")
						arg_258_1.musicAnimator_:Play("open", 0, 0)

						if arg_258_1.settingData.music_time ~= 0 then
							arg_258_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_258_1.settingData.music_time), function()
								if arg_258_1 == nil or isNil(arg_258_1.bgmTxt_) then
									return
								end

								arg_258_1.musicController:SetSelectedState("hide")
								arg_258_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1.46666666666667 < arg_258_1.time_ and arg_258_1.time_ <= 1.46666666666667 + arg_261_0 then
				arg_258_1:AudioAction("play", "music", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1.awb")

				local var_261_32 = manager.audio:GetAudioName("bgm_activity_3_8_story_northwake_1", "bgm_activity_3_8_story_northwake_1")

				if "" ~= "" then
					if arg_258_1.bgmTxt_.text ~= var_261_32 and arg_258_1.bgmTxt_.text ~= "" then
						if arg_258_1.bgmTxt2_.text ~= "" then
							arg_258_1.bgmTxt_.text = arg_258_1.bgmTxt2_.text
						end

						arg_258_1.bgmTxt2_.text = var_261_32

						arg_258_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_258_1.bgmTxt_.text = var_261_32
						arg_258_1.bgmTxt2_.text = var_261_32
					end

					if arg_258_1.bgmTimer then
						arg_258_1.bgmTimer:Stop()

						arg_258_1.bgmTimer = nil
					end

					if arg_258_1.settingData.show_music_name == 1 then
						arg_258_1.musicController:SetSelectedState("show")
						arg_258_1.musicAnimator_:Play("open", 0, 0)

						if arg_258_1.settingData.music_time ~= 0 then
							arg_258_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_258_1.settingData.music_time), function()
								if arg_258_1 == nil or isNil(arg_258_1.bgmTxt_) then
									return
								end

								arg_258_1.musicController:SetSelectedState("hide")
								arg_258_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_258_1.frameCnt_ <= 1 then
				arg_258_1.dialog_:SetActive(false)
			end

			local var_261_33 = 4
			local var_261_34 = 0.625

			if 4 < arg_258_1.time_ and arg_258_1.time_ <= var_261_33 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0

				arg_258_1.dialog_:SetActive(true)

				arg_258_1.dialogCg_.alpha = 0

				local var_261_35 = LeanTween.value(arg_258_1.dialog_, 0, 1, 0.3)

				var_261_35:setOnUpdate(LuaHelper.FloatAction(function(arg_264_0)
					arg_258_1.dialogCg_.alpha = arg_264_0
				end))
				var_261_35:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_258_1.dialog_)
					var_261_35:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_258_1.duration_ = arg_258_1.duration_ + 0.3

				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_36 = arg_258_1:GetWordFromCfg(416051061)
				local var_261_37 = arg_258_1:FormatText(var_261_36.content)

				arg_258_1.text_.text = var_261_37

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_39 = 25 <= 0 and var_261_34 or var_261_34 * (utf8.len(var_261_37) / 25)

				if (25 <= 0 and var_261_34 or var_261_34 * (utf8.len(var_261_37) / 25)) > 0 and var_261_34 < var_261_39 then
					arg_258_1.talkMaxDuration = var_261_39
					var_261_33 = var_261_33 + 0.3

					if var_261_39 + var_261_33 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_39 + var_261_33
					end
				end

				arg_258_1.text_.text = var_261_37
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051061", "story_v_out_416051.awb") ~= 0 then
					local var_261_40 = manager.audio:GetVoiceLength("story_v_out_416051", "416051061", "story_v_out_416051.awb") / 1000

					if var_261_40 + var_261_33 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_40 + var_261_33
					end

					if var_261_36.prefab_name ~= "" and arg_258_1.actors_[var_261_36.prefab_name] ~= nil then
						local var_261_41 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_36.prefab_name].transform, "story_v_out_416051", "416051061", "story_v_out_416051.awb")

						arg_258_1:RecordAudio("416051061", var_261_41)
						arg_258_1:RecordAudio("416051061", var_261_41)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_416051", "416051061", "story_v_out_416051.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_416051", "416051061", "story_v_out_416051.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_42 = var_261_33 + 0.3
			local var_261_43 = math.max(var_261_34, arg_258_1.talkMaxDuration)

			if var_261_33 + 0.3 <= arg_258_1.time_ and arg_258_1.time_ < var_261_42 + var_261_43 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_42) / var_261_43

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_42 + var_261_43 and arg_258_1.time_ < var_261_42 + var_261_43 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.46733333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_258_1:InitPlayNodeList()
	end,
	Play416051062 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 416051062
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play416051063(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1086 = arg_266_1.actors_["1086"].transform.localPosition
				arg_266_1.actors_["1086"].transform.localScale = Vector3.New(1, 1, 1)

				arg_266_1:CheckSpriteTmpPos("1086", 7)

				for iter_269_0 = 0, arg_266_1.actors_["1086"].transform.childCount - 1 do
					local var_269_0 = arg_266_1.actors_["1086"].transform:GetChild(iter_269_0)

					if var_269_0.name == "" or not string.find(var_269_0.name, "split") then
						var_269_0.gameObject:SetActive(true)
					else
						var_269_0.gameObject:SetActive(false)
					end
				end
			end

			local var_269_1 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["1086"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1086, Vector3.New(0, -2000, 0), (arg_266_1.time_ - 0) / var_269_1)
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["1086"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_269_2 = 0
			local var_269_3 = 1.225

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_2 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, false)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_4 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(416051062).content)

				arg_266_1.text_.text = var_269_4

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_6 = 49 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 49)

				if (49 <= 0 and var_269_3 or var_269_3 * (utf8.len(var_269_4) / 49)) > 0 and var_269_3 < var_269_6 then
					arg_266_1.talkMaxDuration = var_269_6

					if var_269_6 + var_269_2 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_6 + var_269_2
					end
				end

				arg_266_1.text_.text = var_269_4
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_7 = math.max(var_269_3, arg_266_1.talkMaxDuration)

			if var_269_2 <= arg_266_1.time_ and arg_266_1.time_ < var_269_2 + var_269_7 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_2) / var_269_7

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_2 + var_269_7 and arg_266_1.time_ < var_269_2 + var_269_7 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_266_1:InitPlayNodeList()
	end,
	Play416051063 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 416051063
		arg_270_1.duration_ = 4.5

		local var_270_0 = {
			zh = 2.633,
			ja = 4.5
		}
		local var_270_1 = manager.audio:GetLocalizationFlag()

		if var_270_0[var_270_1] ~= nil then
			arg_270_1.duration_ = var_270_0[var_270_1]
		end

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play416051064(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1028 = arg_270_1.actors_["1028"].transform.localPosition
				arg_270_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_270_1:CheckSpriteTmpPos("1028", 3)

				for iter_273_0 = 0, arg_270_1.actors_["1028"].transform.childCount - 1 do
					local var_273_0 = arg_270_1.actors_["1028"].transform:GetChild(iter_273_0)

					if var_273_0.name == "" or not string.find(var_273_0.name, "split") then
						var_273_0.gameObject:SetActive(true)
					else
						var_273_0.gameObject:SetActive(false)
					end
				end
			end

			local var_273_1 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_1 then
				arg_270_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1028, Vector3.New(0, -402.7, -156.1), (arg_270_1.time_ - 0) / var_273_1)
			end

			if arg_270_1.time_ >= 0 + var_273_1 and arg_270_1.time_ < 0 + var_273_1 + arg_273_0 then
				arg_270_1.actors_["1028"].transform.localPosition = Vector3.New(0, -402.7, -156.1)
			end

			local var_273_2 = arg_270_1.actors_["1028"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1028 == nil then
				arg_270_1.var_.actorSpriteComps1028 = var_273_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_273_3 = 0.125

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_3 and not isNil(var_273_2) then
				if arg_270_1.var_.actorSpriteComps1028 then
					for iter_273_1, iter_273_2 in pairs(arg_270_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_273_2 then
							if arg_270_1.isInRecall_ then
								iter_273_2.color = Color.New(Mathf.Lerp(iter_273_2.color.r, arg_270_1.hightColor1.r, (arg_270_1.time_ - 0) / var_273_3), Mathf.Lerp(iter_273_2.color.g, arg_270_1.hightColor1.g, (arg_270_1.time_ - 0) / var_273_3), (Mathf.Lerp(iter_273_2.color.b, arg_270_1.hightColor1.b, (arg_270_1.time_ - 0) / var_273_3)))
							else
								local var_273_4 = Mathf.Lerp(iter_273_2.color.r, 1, (arg_270_1.time_ - 0) / var_273_3)

								iter_273_2.color = Color.New(var_273_4, var_273_4, var_273_4)
							end
						end
					end
				end
			end

			if arg_270_1.time_ >= 0 + var_273_3 and arg_270_1.time_ < 0 + var_273_3 + arg_273_0 and not isNil(var_273_2) and arg_270_1.var_.actorSpriteComps1028 then
				for iter_273_3, iter_273_4 in pairs(arg_270_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_273_4 then
						iter_273_4.color = arg_270_1.isInRecall_ and (arg_270_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_270_1.var_.actorSpriteComps1028 = nil
			end

			local var_273_5 = 0
			local var_273_6 = 0.325

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_5 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_7 = arg_270_1:GetWordFromCfg(416051063)
				local var_273_8 = arg_270_1:FormatText(var_273_7.content)

				arg_270_1.text_.text = var_273_8

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_10 = 13 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 13)

				if (13 <= 0 and var_273_6 or var_273_6 * (utf8.len(var_273_8) / 13)) > 0 and var_273_6 < var_273_10 then
					arg_270_1.talkMaxDuration = var_273_10

					if var_273_10 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_10 + var_273_5
					end
				end

				arg_270_1.text_.text = var_273_8
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051063", "story_v_out_416051.awb") ~= 0 then
					local var_273_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051063", "story_v_out_416051.awb") / 1000

					if var_273_11 + var_273_5 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_11 + var_273_5
					end

					if var_273_7.prefab_name ~= "" and arg_270_1.actors_[var_273_7.prefab_name] ~= nil then
						local var_273_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_270_1.actors_[var_273_7.prefab_name].transform, "story_v_out_416051", "416051063", "story_v_out_416051.awb")

						arg_270_1:RecordAudio("416051063", var_273_12)
						arg_270_1:RecordAudio("416051063", var_273_12)
					else
						arg_270_1:AudioAction("play", "voice", "story_v_out_416051", "416051063", "story_v_out_416051.awb")
					end

					arg_270_1:RecordHistoryTalkVoice("story_v_out_416051", "416051063", "story_v_out_416051.awb")
				end

				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_13 = math.max(var_273_6, arg_270_1.talkMaxDuration)

			if var_273_5 <= arg_270_1.time_ and arg_270_1.time_ < var_273_5 + var_273_13 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_5) / var_273_13

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_5 + var_273_13 and arg_270_1.time_ < var_273_5 + var_273_13 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play416051064 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 416051064
		arg_274_1.duration_ = 6.2

		local var_274_0 = {
			zh = 4.366,
			ja = 6.2
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play416051065(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1028 = arg_274_1.actors_["1028"].transform.localPosition
				arg_274_1.actors_["1028"].transform.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1028", 2)

				for iter_277_0 = 0, arg_274_1.actors_["1028"].transform.childCount - 1 do
					local var_277_0 = arg_274_1.actors_["1028"].transform:GetChild(iter_277_0)

					if var_277_0.name == "" or not string.find(var_277_0.name, "split") then
						var_277_0.gameObject:SetActive(true)
					else
						var_277_0.gameObject:SetActive(false)
					end
				end
			end

			local var_277_1 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_1 then
				arg_274_1.actors_["1028"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1028, Vector3.New(-390, -402.7, -156.1), (arg_274_1.time_ - 0) / var_277_1)
			end

			if arg_274_1.time_ >= 0 + var_277_1 and arg_274_1.time_ < 0 + var_277_1 + arg_277_0 then
				arg_274_1.actors_["1028"].transform.localPosition = Vector3.New(-390, -402.7, -156.1)
			end

			local var_277_2 = arg_274_1.actors_["1028"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps1028 == nil then
				arg_274_1.var_.actorSpriteComps1028 = var_277_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_3 = 0.125

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_3 and not isNil(var_277_2) then
				if arg_274_1.var_.actorSpriteComps1028 then
					for iter_277_1, iter_277_2 in pairs(arg_274_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_277_2 then
							if arg_274_1.isInRecall_ then
								iter_277_2.color = Color.New(Mathf.Lerp(iter_277_2.color.r, arg_274_1.hightColor2.r, (arg_274_1.time_ - 0) / var_277_3), Mathf.Lerp(iter_277_2.color.g, arg_274_1.hightColor2.g, (arg_274_1.time_ - 0) / var_277_3), (Mathf.Lerp(iter_277_2.color.b, arg_274_1.hightColor2.b, (arg_274_1.time_ - 0) / var_277_3)))
							else
								local var_277_4 = Mathf.Lerp(iter_277_2.color.r, 0.5, (arg_274_1.time_ - 0) / var_277_3)

								iter_277_2.color = Color.New(var_277_4, var_277_4, var_277_4)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_3 and arg_274_1.time_ < 0 + var_277_3 + arg_277_0 and not isNil(var_277_2) and arg_274_1.var_.actorSpriteComps1028 then
				for iter_277_3, iter_277_4 in pairs(arg_274_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_277_4 then
						iter_277_4.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_274_1.var_.actorSpriteComps1028 = nil
			end

			local var_277_5 = arg_274_1.actors_["1086"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.actorSpriteComps1086 == nil then
				arg_274_1.var_.actorSpriteComps1086 = var_277_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_277_6 = 0.125

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_6 and not isNil(var_277_5) then
				if arg_274_1.var_.actorSpriteComps1086 then
					for iter_277_5, iter_277_6 in pairs(arg_274_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_277_6 then
							if arg_274_1.isInRecall_ then
								iter_277_6.color = Color.New(Mathf.Lerp(iter_277_6.color.r, arg_274_1.hightColor1.r, (arg_274_1.time_ - 0) / var_277_6), Mathf.Lerp(iter_277_6.color.g, arg_274_1.hightColor1.g, (arg_274_1.time_ - 0) / var_277_6), (Mathf.Lerp(iter_277_6.color.b, arg_274_1.hightColor1.b, (arg_274_1.time_ - 0) / var_277_6)))
							else
								local var_277_7 = Mathf.Lerp(iter_277_6.color.r, 1, (arg_274_1.time_ - 0) / var_277_6)

								iter_277_6.color = Color.New(var_277_7, var_277_7, var_277_7)
							end
						end
					end
				end
			end

			if arg_274_1.time_ >= 0 + var_277_6 and arg_274_1.time_ < 0 + var_277_6 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.actorSpriteComps1086 then
				for iter_277_7, iter_277_8 in pairs(arg_274_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_277_8 then
						iter_277_8.color = arg_274_1.isInRecall_ and (arg_274_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_274_1.var_.actorSpriteComps1086 = nil
			end

			local var_277_8 = arg_274_1.actors_["1086"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1086 = var_277_8.localPosition
				var_277_8.localScale = Vector3.New(1, 1, 1)

				arg_274_1:CheckSpriteTmpPos("1086", 4)

				for iter_277_9 = 0, var_277_8.childCount - 1 do
					local var_277_9 = var_277_8:GetChild(iter_277_9)

					if var_277_9.name == "" or not string.find(var_277_9.name, "split") then
						var_277_9.gameObject:SetActive(true)
					else
						var_277_9.gameObject:SetActive(false)
					end
				end
			end

			local var_277_10 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_10 then
				var_277_8.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_274_1.time_ - 0) / var_277_10)
			end

			if arg_274_1.time_ >= 0 + var_277_10 and arg_274_1.time_ < 0 + var_277_10 + arg_277_0 then
				var_277_8.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_277_11 = 0
			local var_277_12 = 0.375

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_11 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_13 = arg_274_1:GetWordFromCfg(416051064)
				local var_277_14 = arg_274_1:FormatText(var_277_13.content)

				arg_274_1.text_.text = var_277_14

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_16 = 15 <= 0 and var_277_12 or var_277_12 * (utf8.len(var_277_14) / 15)

				if (15 <= 0 and var_277_12 or var_277_12 * (utf8.len(var_277_14) / 15)) > 0 and var_277_12 < var_277_16 then
					arg_274_1.talkMaxDuration = var_277_16

					if var_277_16 + var_277_11 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_16 + var_277_11
					end
				end

				arg_274_1.text_.text = var_277_14
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051064", "story_v_out_416051.awb") ~= 0 then
					local var_277_17 = manager.audio:GetVoiceLength("story_v_out_416051", "416051064", "story_v_out_416051.awb") / 1000

					if var_277_17 + var_277_11 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_17 + var_277_11
					end

					if var_277_13.prefab_name ~= "" and arg_274_1.actors_[var_277_13.prefab_name] ~= nil then
						local var_277_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_13.prefab_name].transform, "story_v_out_416051", "416051064", "story_v_out_416051.awb")

						arg_274_1:RecordAudio("416051064", var_277_18)
						arg_274_1:RecordAudio("416051064", var_277_18)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_416051", "416051064", "story_v_out_416051.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_416051", "416051064", "story_v_out_416051.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_19 = math.max(var_277_12, arg_274_1.talkMaxDuration)

			if var_277_11 <= arg_274_1.time_ and arg_274_1.time_ < var_277_11 + var_277_19 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_11) / var_277_19

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_11 + var_277_19 and arg_274_1.time_ < var_277_11 + var_277_19 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_274_1:InitPlayNodeList()
	end,
	Play416051065 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 416051065
		arg_278_1.duration_ = 7.1

		local var_278_0 = {
			zh = 5.7,
			ja = 7.1
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play416051066(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(arg_278_1.actors_["1028"]) and arg_278_1.var_.actorSpriteComps1028 == nil then
				arg_278_1.var_.actorSpriteComps1028 = arg_278_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_0 = 0.125

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_0 and not isNil(arg_278_1.actors_["1028"]) then
				if arg_278_1.var_.actorSpriteComps1028 then
					for iter_281_0, iter_281_1 in pairs(arg_278_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_281_1 then
							if arg_278_1.isInRecall_ then
								iter_281_1.color = Color.New(Mathf.Lerp(iter_281_1.color.r, arg_278_1.hightColor1.r, (arg_278_1.time_ - 0) / var_281_0), Mathf.Lerp(iter_281_1.color.g, arg_278_1.hightColor1.g, (arg_278_1.time_ - 0) / var_281_0), (Mathf.Lerp(iter_281_1.color.b, arg_278_1.hightColor1.b, (arg_278_1.time_ - 0) / var_281_0)))
							else
								local var_281_1 = Mathf.Lerp(iter_281_1.color.r, 1, (arg_278_1.time_ - 0) / var_281_0)

								iter_281_1.color = Color.New(var_281_1, var_281_1, var_281_1)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_0 and arg_278_1.time_ < 0 + var_281_0 + arg_281_0 and not isNil(arg_278_1.actors_["1028"]) and arg_278_1.var_.actorSpriteComps1028 then
				for iter_281_2, iter_281_3 in pairs(arg_278_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_281_3 then
						iter_281_3.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_278_1.var_.actorSpriteComps1028 = nil
			end

			local var_281_2 = arg_278_1.actors_["1086"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps1086 == nil then
				arg_278_1.var_.actorSpriteComps1086 = var_281_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_281_3 = 0.125

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_3 and not isNil(var_281_2) then
				if arg_278_1.var_.actorSpriteComps1086 then
					for iter_281_4, iter_281_5 in pairs(arg_278_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_281_5 then
							if arg_278_1.isInRecall_ then
								iter_281_5.color = Color.New(Mathf.Lerp(iter_281_5.color.r, arg_278_1.hightColor2.r, (arg_278_1.time_ - 0) / var_281_3), Mathf.Lerp(iter_281_5.color.g, arg_278_1.hightColor2.g, (arg_278_1.time_ - 0) / var_281_3), (Mathf.Lerp(iter_281_5.color.b, arg_278_1.hightColor2.b, (arg_278_1.time_ - 0) / var_281_3)))
							else
								local var_281_4 = Mathf.Lerp(iter_281_5.color.r, 0.5, (arg_278_1.time_ - 0) / var_281_3)

								iter_281_5.color = Color.New(var_281_4, var_281_4, var_281_4)
							end
						end
					end
				end
			end

			if arg_278_1.time_ >= 0 + var_281_3 and arg_278_1.time_ < 0 + var_281_3 + arg_281_0 and not isNil(var_281_2) and arg_278_1.var_.actorSpriteComps1086 then
				for iter_281_6, iter_281_7 in pairs(arg_278_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_281_7 then
						iter_281_7.color = arg_278_1.isInRecall_ and (arg_278_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_278_1.var_.actorSpriteComps1086 = nil
			end

			local var_281_5 = 0
			local var_281_6 = 0.675

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_5 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_7 = arg_278_1:GetWordFromCfg(416051065)
				local var_281_8 = arg_278_1:FormatText(var_281_7.content)

				arg_278_1.text_.text = var_281_8

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_10 = 27 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_8) / 27)

				if (27 <= 0 and var_281_6 or var_281_6 * (utf8.len(var_281_8) / 27)) > 0 and var_281_6 < var_281_10 then
					arg_278_1.talkMaxDuration = var_281_10

					if var_281_10 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_5
					end
				end

				arg_278_1.text_.text = var_281_8
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051065", "story_v_out_416051.awb") ~= 0 then
					local var_281_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051065", "story_v_out_416051.awb") / 1000

					if var_281_11 + var_281_5 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_11 + var_281_5
					end

					if var_281_7.prefab_name ~= "" and arg_278_1.actors_[var_281_7.prefab_name] ~= nil then
						local var_281_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_7.prefab_name].transform, "story_v_out_416051", "416051065", "story_v_out_416051.awb")

						arg_278_1:RecordAudio("416051065", var_281_12)
						arg_278_1:RecordAudio("416051065", var_281_12)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_416051", "416051065", "story_v_out_416051.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_416051", "416051065", "story_v_out_416051.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_13 = math.max(var_281_6, arg_278_1.talkMaxDuration)

			if var_281_5 <= arg_278_1.time_ and arg_278_1.time_ < var_281_5 + var_281_13 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_5) / var_281_13

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_5 + var_281_13 and arg_278_1.time_ < var_281_5 + var_281_13 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play416051066 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 416051066
		arg_282_1.duration_ = 7.63

		local var_282_0 = {
			zh = 4.933,
			ja = 7.633
		}
		local var_282_1 = manager.audio:GetLocalizationFlag()

		if var_282_0[var_282_1] ~= nil then
			arg_282_1.duration_ = var_282_0[var_282_1]
		end

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play416051067(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["1028"]) and arg_282_1.var_.actorSpriteComps1028 == nil then
				arg_282_1.var_.actorSpriteComps1028 = arg_282_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_0 = 0.125

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["1028"]) then
				if arg_282_1.var_.actorSpriteComps1028 then
					for iter_285_0, iter_285_1 in pairs(arg_282_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_285_1 then
							if arg_282_1.isInRecall_ then
								iter_285_1.color = Color.New(Mathf.Lerp(iter_285_1.color.r, arg_282_1.hightColor2.r, (arg_282_1.time_ - 0) / var_285_0), Mathf.Lerp(iter_285_1.color.g, arg_282_1.hightColor2.g, (arg_282_1.time_ - 0) / var_285_0), (Mathf.Lerp(iter_285_1.color.b, arg_282_1.hightColor2.b, (arg_282_1.time_ - 0) / var_285_0)))
							else
								local var_285_1 = Mathf.Lerp(iter_285_1.color.r, 0.5, (arg_282_1.time_ - 0) / var_285_0)

								iter_285_1.color = Color.New(var_285_1, var_285_1, var_285_1)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["1028"]) and arg_282_1.var_.actorSpriteComps1028 then
				for iter_285_2, iter_285_3 in pairs(arg_282_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_285_3 then
						iter_285_3.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_282_1.var_.actorSpriteComps1028 = nil
			end

			local var_285_2 = arg_282_1.actors_["1086"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps1086 == nil then
				arg_282_1.var_.actorSpriteComps1086 = var_285_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_285_3 = 0.125

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.actorSpriteComps1086 then
					for iter_285_4, iter_285_5 in pairs(arg_282_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_285_5 then
							if arg_282_1.isInRecall_ then
								iter_285_5.color = Color.New(Mathf.Lerp(iter_285_5.color.r, arg_282_1.hightColor1.r, (arg_282_1.time_ - 0) / var_285_3), Mathf.Lerp(iter_285_5.color.g, arg_282_1.hightColor1.g, (arg_282_1.time_ - 0) / var_285_3), (Mathf.Lerp(iter_285_5.color.b, arg_282_1.hightColor1.b, (arg_282_1.time_ - 0) / var_285_3)))
							else
								local var_285_4 = Mathf.Lerp(iter_285_5.color.r, 1, (arg_282_1.time_ - 0) / var_285_3)

								iter_285_5.color = Color.New(var_285_4, var_285_4, var_285_4)
							end
						end
					end
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.actorSpriteComps1086 then
				for iter_285_6, iter_285_7 in pairs(arg_282_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_285_7 then
						iter_285_7.color = arg_282_1.isInRecall_ and (arg_282_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_282_1.var_.actorSpriteComps1086 = nil
			end

			local var_285_5 = 0
			local var_285_6 = 0.575

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_5 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_7 = arg_282_1:GetWordFromCfg(416051066)
				local var_285_8 = arg_282_1:FormatText(var_285_7.content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 23 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 23)

				if (23 <= 0 and var_285_6 or var_285_6 * (utf8.len(var_285_8) / 23)) > 0 and var_285_6 < var_285_10 then
					arg_282_1.talkMaxDuration = var_285_10

					if var_285_10 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_5
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051066", "story_v_out_416051.awb") ~= 0 then
					local var_285_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051066", "story_v_out_416051.awb") / 1000

					if var_285_11 + var_285_5 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_11 + var_285_5
					end

					if var_285_7.prefab_name ~= "" and arg_282_1.actors_[var_285_7.prefab_name] ~= nil then
						local var_285_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_7.prefab_name].transform, "story_v_out_416051", "416051066", "story_v_out_416051.awb")

						arg_282_1:RecordAudio("416051066", var_285_12)
						arg_282_1:RecordAudio("416051066", var_285_12)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_416051", "416051066", "story_v_out_416051.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_416051", "416051066", "story_v_out_416051.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_13 = math.max(var_285_6, arg_282_1.talkMaxDuration)

			if var_285_5 <= arg_282_1.time_ and arg_282_1.time_ < var_285_5 + var_285_13 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_5) / var_285_13

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_5 + var_285_13 and arg_282_1.time_ < var_285_5 + var_285_13 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play416051067 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 416051067
		arg_286_1.duration_ = 7.9

		local var_286_0 = {
			zh = 5.266,
			ja = 7.9
		}
		local var_286_1 = manager.audio:GetLocalizationFlag()

		if var_286_0[var_286_1] ~= nil then
			arg_286_1.duration_ = var_286_0[var_286_1]
		end

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play416051068(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["1028"]) and arg_286_1.var_.actorSpriteComps1028 == nil then
				arg_286_1.var_.actorSpriteComps1028 = arg_286_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_0 = 0.125

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["1028"]) then
				if arg_286_1.var_.actorSpriteComps1028 then
					for iter_289_0, iter_289_1 in pairs(arg_286_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_289_1 then
							if arg_286_1.isInRecall_ then
								iter_289_1.color = Color.New(Mathf.Lerp(iter_289_1.color.r, arg_286_1.hightColor1.r, (arg_286_1.time_ - 0) / var_289_0), Mathf.Lerp(iter_289_1.color.g, arg_286_1.hightColor1.g, (arg_286_1.time_ - 0) / var_289_0), (Mathf.Lerp(iter_289_1.color.b, arg_286_1.hightColor1.b, (arg_286_1.time_ - 0) / var_289_0)))
							else
								local var_289_1 = Mathf.Lerp(iter_289_1.color.r, 1, (arg_286_1.time_ - 0) / var_289_0)

								iter_289_1.color = Color.New(var_289_1, var_289_1, var_289_1)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["1028"]) and arg_286_1.var_.actorSpriteComps1028 then
				for iter_289_2, iter_289_3 in pairs(arg_286_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_289_3 then
						iter_289_3.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_286_1.var_.actorSpriteComps1028 = nil
			end

			local var_289_2 = arg_286_1.actors_["1086"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps1086 == nil then
				arg_286_1.var_.actorSpriteComps1086 = var_289_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_289_3 = 0.125

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_3 and not isNil(var_289_2) then
				if arg_286_1.var_.actorSpriteComps1086 then
					for iter_289_4, iter_289_5 in pairs(arg_286_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_289_5 then
							if arg_286_1.isInRecall_ then
								iter_289_5.color = Color.New(Mathf.Lerp(iter_289_5.color.r, arg_286_1.hightColor2.r, (arg_286_1.time_ - 0) / var_289_3), Mathf.Lerp(iter_289_5.color.g, arg_286_1.hightColor2.g, (arg_286_1.time_ - 0) / var_289_3), (Mathf.Lerp(iter_289_5.color.b, arg_286_1.hightColor2.b, (arg_286_1.time_ - 0) / var_289_3)))
							else
								local var_289_4 = Mathf.Lerp(iter_289_5.color.r, 0.5, (arg_286_1.time_ - 0) / var_289_3)

								iter_289_5.color = Color.New(var_289_4, var_289_4, var_289_4)
							end
						end
					end
				end
			end

			if arg_286_1.time_ >= 0 + var_289_3 and arg_286_1.time_ < 0 + var_289_3 + arg_289_0 and not isNil(var_289_2) and arg_286_1.var_.actorSpriteComps1086 then
				for iter_289_6, iter_289_7 in pairs(arg_286_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_289_7 then
						iter_289_7.color = arg_286_1.isInRecall_ and (arg_286_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_286_1.var_.actorSpriteComps1086 = nil
			end

			local var_289_5 = 0
			local var_289_6 = 0.55

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_5 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_7 = arg_286_1:GetWordFromCfg(416051067)
				local var_289_8 = arg_286_1:FormatText(var_289_7.content)

				arg_286_1.text_.text = var_289_8

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_10 = 22 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_8) / 22)

				if (22 <= 0 and var_289_6 or var_289_6 * (utf8.len(var_289_8) / 22)) > 0 and var_289_6 < var_289_10 then
					arg_286_1.talkMaxDuration = var_289_10

					if var_289_10 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_10 + var_289_5
					end
				end

				arg_286_1.text_.text = var_289_8
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051067", "story_v_out_416051.awb") ~= 0 then
					local var_289_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051067", "story_v_out_416051.awb") / 1000

					if var_289_11 + var_289_5 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_11 + var_289_5
					end

					if var_289_7.prefab_name ~= "" and arg_286_1.actors_[var_289_7.prefab_name] ~= nil then
						local var_289_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_286_1.actors_[var_289_7.prefab_name].transform, "story_v_out_416051", "416051067", "story_v_out_416051.awb")

						arg_286_1:RecordAudio("416051067", var_289_12)
						arg_286_1:RecordAudio("416051067", var_289_12)
					else
						arg_286_1:AudioAction("play", "voice", "story_v_out_416051", "416051067", "story_v_out_416051.awb")
					end

					arg_286_1:RecordHistoryTalkVoice("story_v_out_416051", "416051067", "story_v_out_416051.awb")
				end

				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_13 = math.max(var_289_6, arg_286_1.talkMaxDuration)

			if var_289_5 <= arg_286_1.time_ and arg_286_1.time_ < var_289_5 + var_289_13 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_5) / var_289_13

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_5 + var_289_13 and arg_286_1.time_ < var_289_5 + var_289_13 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play416051068 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 416051068
		arg_290_1.duration_ = 6.93

		local var_290_0 = {
			zh = 4,
			ja = 6.933
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play416051069(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1028"]) and arg_290_1.var_.actorSpriteComps1028 == nil then
				arg_290_1.var_.actorSpriteComps1028 = arg_290_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_0 = 0.125

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1028"]) then
				if arg_290_1.var_.actorSpriteComps1028 then
					for iter_293_0, iter_293_1 in pairs(arg_290_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_293_1 then
							if arg_290_1.isInRecall_ then
								iter_293_1.color = Color.New(Mathf.Lerp(iter_293_1.color.r, arg_290_1.hightColor2.r, (arg_290_1.time_ - 0) / var_293_0), Mathf.Lerp(iter_293_1.color.g, arg_290_1.hightColor2.g, (arg_290_1.time_ - 0) / var_293_0), (Mathf.Lerp(iter_293_1.color.b, arg_290_1.hightColor2.b, (arg_290_1.time_ - 0) / var_293_0)))
							else
								local var_293_1 = Mathf.Lerp(iter_293_1.color.r, 0.5, (arg_290_1.time_ - 0) / var_293_0)

								iter_293_1.color = Color.New(var_293_1, var_293_1, var_293_1)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1028"]) and arg_290_1.var_.actorSpriteComps1028 then
				for iter_293_2, iter_293_3 in pairs(arg_290_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_293_3 then
						iter_293_3.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_290_1.var_.actorSpriteComps1028 = nil
			end

			local var_293_2 = arg_290_1.actors_["1086"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps1086 == nil then
				arg_290_1.var_.actorSpriteComps1086 = var_293_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_293_3 = 0.125

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_3 and not isNil(var_293_2) then
				if arg_290_1.var_.actorSpriteComps1086 then
					for iter_293_4, iter_293_5 in pairs(arg_290_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_293_5 then
							if arg_290_1.isInRecall_ then
								iter_293_5.color = Color.New(Mathf.Lerp(iter_293_5.color.r, arg_290_1.hightColor1.r, (arg_290_1.time_ - 0) / var_293_3), Mathf.Lerp(iter_293_5.color.g, arg_290_1.hightColor1.g, (arg_290_1.time_ - 0) / var_293_3), (Mathf.Lerp(iter_293_5.color.b, arg_290_1.hightColor1.b, (arg_290_1.time_ - 0) / var_293_3)))
							else
								local var_293_4 = Mathf.Lerp(iter_293_5.color.r, 1, (arg_290_1.time_ - 0) / var_293_3)

								iter_293_5.color = Color.New(var_293_4, var_293_4, var_293_4)
							end
						end
					end
				end
			end

			if arg_290_1.time_ >= 0 + var_293_3 and arg_290_1.time_ < 0 + var_293_3 + arg_293_0 and not isNil(var_293_2) and arg_290_1.var_.actorSpriteComps1086 then
				for iter_293_6, iter_293_7 in pairs(arg_290_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_293_7 then
						iter_293_7.color = arg_290_1.isInRecall_ and (arg_290_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_290_1.var_.actorSpriteComps1086 = nil
			end

			local var_293_5 = 0
			local var_293_6 = 0.5

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_5 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_7 = arg_290_1:GetWordFromCfg(416051068)
				local var_293_8 = arg_290_1:FormatText(var_293_7.content)

				arg_290_1.text_.text = var_293_8

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_10 = 20 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 20)

				if (20 <= 0 and var_293_6 or var_293_6 * (utf8.len(var_293_8) / 20)) > 0 and var_293_6 < var_293_10 then
					arg_290_1.talkMaxDuration = var_293_10

					if var_293_10 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_10 + var_293_5
					end
				end

				arg_290_1.text_.text = var_293_8
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051068", "story_v_out_416051.awb") ~= 0 then
					local var_293_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051068", "story_v_out_416051.awb") / 1000

					if var_293_11 + var_293_5 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_11 + var_293_5
					end

					if var_293_7.prefab_name ~= "" and arg_290_1.actors_[var_293_7.prefab_name] ~= nil then
						local var_293_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_7.prefab_name].transform, "story_v_out_416051", "416051068", "story_v_out_416051.awb")

						arg_290_1:RecordAudio("416051068", var_293_12)
						arg_290_1:RecordAudio("416051068", var_293_12)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_416051", "416051068", "story_v_out_416051.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_416051", "416051068", "story_v_out_416051.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_6, arg_290_1.talkMaxDuration)

			if var_293_5 <= arg_290_1.time_ and arg_290_1.time_ < var_293_5 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_5) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_5 + var_293_13 and arg_290_1.time_ < var_293_5 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play416051069 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 416051069
		arg_294_1.duration_ = 6.53

		local var_294_0 = {
			zh = 4.6,
			ja = 6.533
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play416051070(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1028"]) and arg_294_1.var_.actorSpriteComps1028 == nil then
				arg_294_1.var_.actorSpriteComps1028 = arg_294_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_0 = 0.125

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1028"]) then
				if arg_294_1.var_.actorSpriteComps1028 then
					for iter_297_0, iter_297_1 in pairs(arg_294_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_297_1 then
							if arg_294_1.isInRecall_ then
								iter_297_1.color = Color.New(Mathf.Lerp(iter_297_1.color.r, arg_294_1.hightColor1.r, (arg_294_1.time_ - 0) / var_297_0), Mathf.Lerp(iter_297_1.color.g, arg_294_1.hightColor1.g, (arg_294_1.time_ - 0) / var_297_0), (Mathf.Lerp(iter_297_1.color.b, arg_294_1.hightColor1.b, (arg_294_1.time_ - 0) / var_297_0)))
							else
								local var_297_1 = Mathf.Lerp(iter_297_1.color.r, 1, (arg_294_1.time_ - 0) / var_297_0)

								iter_297_1.color = Color.New(var_297_1, var_297_1, var_297_1)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1028"]) and arg_294_1.var_.actorSpriteComps1028 then
				for iter_297_2, iter_297_3 in pairs(arg_294_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_297_3 then
						iter_297_3.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_294_1.var_.actorSpriteComps1028 = nil
			end

			local var_297_2 = arg_294_1.actors_["1086"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps1086 == nil then
				arg_294_1.var_.actorSpriteComps1086 = var_297_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_297_3 = 0.125

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_3 and not isNil(var_297_2) then
				if arg_294_1.var_.actorSpriteComps1086 then
					for iter_297_4, iter_297_5 in pairs(arg_294_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_297_5 then
							if arg_294_1.isInRecall_ then
								iter_297_5.color = Color.New(Mathf.Lerp(iter_297_5.color.r, arg_294_1.hightColor2.r, (arg_294_1.time_ - 0) / var_297_3), Mathf.Lerp(iter_297_5.color.g, arg_294_1.hightColor2.g, (arg_294_1.time_ - 0) / var_297_3), (Mathf.Lerp(iter_297_5.color.b, arg_294_1.hightColor2.b, (arg_294_1.time_ - 0) / var_297_3)))
							else
								local var_297_4 = Mathf.Lerp(iter_297_5.color.r, 0.5, (arg_294_1.time_ - 0) / var_297_3)

								iter_297_5.color = Color.New(var_297_4, var_297_4, var_297_4)
							end
						end
					end
				end
			end

			if arg_294_1.time_ >= 0 + var_297_3 and arg_294_1.time_ < 0 + var_297_3 + arg_297_0 and not isNil(var_297_2) and arg_294_1.var_.actorSpriteComps1086 then
				for iter_297_6, iter_297_7 in pairs(arg_294_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_297_7 then
						iter_297_7.color = arg_294_1.isInRecall_ and (arg_294_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_294_1.var_.actorSpriteComps1086 = nil
			end

			local var_297_5 = 0
			local var_297_6 = 0.425

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_5 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_7 = arg_294_1:GetWordFromCfg(416051069)
				local var_297_8 = arg_294_1:FormatText(var_297_7.content)

				arg_294_1.text_.text = var_297_8

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_10 = 17 <= 0 and var_297_6 or var_297_6 * (utf8.len(var_297_8) / 17)

				if (17 <= 0 and var_297_6 or var_297_6 * (utf8.len(var_297_8) / 17)) > 0 and var_297_6 < var_297_10 then
					arg_294_1.talkMaxDuration = var_297_10

					if var_297_10 + var_297_5 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_10 + var_297_5
					end
				end

				arg_294_1.text_.text = var_297_8
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051069", "story_v_out_416051.awb") ~= 0 then
					local var_297_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051069", "story_v_out_416051.awb") / 1000

					if var_297_11 + var_297_5 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_11 + var_297_5
					end

					if var_297_7.prefab_name ~= "" and arg_294_1.actors_[var_297_7.prefab_name] ~= nil then
						local var_297_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_7.prefab_name].transform, "story_v_out_416051", "416051069", "story_v_out_416051.awb")

						arg_294_1:RecordAudio("416051069", var_297_12)
						arg_294_1:RecordAudio("416051069", var_297_12)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_416051", "416051069", "story_v_out_416051.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_416051", "416051069", "story_v_out_416051.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_13 = math.max(var_297_6, arg_294_1.talkMaxDuration)

			if var_297_5 <= arg_294_1.time_ and arg_294_1.time_ < var_297_5 + var_297_13 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_5) / var_297_13

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_5 + var_297_13 and arg_294_1.time_ < var_297_5 + var_297_13 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play416051070 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 416051070
		arg_298_1.duration_ = 7.33

		local var_298_0 = {
			zh = 5.966,
			ja = 7.333
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play416051071(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(arg_298_1.actors_["1028"]) and arg_298_1.var_.actorSpriteComps1028 == nil then
				arg_298_1.var_.actorSpriteComps1028 = arg_298_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_0 = 0.125

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 and not isNil(arg_298_1.actors_["1028"]) then
				if arg_298_1.var_.actorSpriteComps1028 then
					for iter_301_0, iter_301_1 in pairs(arg_298_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_301_1 then
							if arg_298_1.isInRecall_ then
								iter_301_1.color = Color.New(Mathf.Lerp(iter_301_1.color.r, arg_298_1.hightColor2.r, (arg_298_1.time_ - 0) / var_301_0), Mathf.Lerp(iter_301_1.color.g, arg_298_1.hightColor2.g, (arg_298_1.time_ - 0) / var_301_0), (Mathf.Lerp(iter_301_1.color.b, arg_298_1.hightColor2.b, (arg_298_1.time_ - 0) / var_301_0)))
							else
								local var_301_1 = Mathf.Lerp(iter_301_1.color.r, 0.5, (arg_298_1.time_ - 0) / var_301_0)

								iter_301_1.color = Color.New(var_301_1, var_301_1, var_301_1)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 and not isNil(arg_298_1.actors_["1028"]) and arg_298_1.var_.actorSpriteComps1028 then
				for iter_301_2, iter_301_3 in pairs(arg_298_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_301_3 then
						iter_301_3.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_298_1.var_.actorSpriteComps1028 = nil
			end

			local var_301_2 = arg_298_1.actors_["1086"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.actorSpriteComps1086 == nil then
				arg_298_1.var_.actorSpriteComps1086 = var_301_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_301_3 = 0.125

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_3 and not isNil(var_301_2) then
				if arg_298_1.var_.actorSpriteComps1086 then
					for iter_301_4, iter_301_5 in pairs(arg_298_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_301_5 then
							if arg_298_1.isInRecall_ then
								iter_301_5.color = Color.New(Mathf.Lerp(iter_301_5.color.r, arg_298_1.hightColor1.r, (arg_298_1.time_ - 0) / var_301_3), Mathf.Lerp(iter_301_5.color.g, arg_298_1.hightColor1.g, (arg_298_1.time_ - 0) / var_301_3), (Mathf.Lerp(iter_301_5.color.b, arg_298_1.hightColor1.b, (arg_298_1.time_ - 0) / var_301_3)))
							else
								local var_301_4 = Mathf.Lerp(iter_301_5.color.r, 1, (arg_298_1.time_ - 0) / var_301_3)

								iter_301_5.color = Color.New(var_301_4, var_301_4, var_301_4)
							end
						end
					end
				end
			end

			if arg_298_1.time_ >= 0 + var_301_3 and arg_298_1.time_ < 0 + var_301_3 + arg_301_0 and not isNil(var_301_2) and arg_298_1.var_.actorSpriteComps1086 then
				for iter_301_6, iter_301_7 in pairs(arg_298_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_301_7 then
						iter_301_7.color = arg_298_1.isInRecall_ and (arg_298_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_298_1.var_.actorSpriteComps1086 = nil
			end

			local var_301_5 = arg_298_1.actors_["1086"].transform

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1086 = var_301_5.localPosition
				var_301_5.localScale = Vector3.New(1, 1, 1)

				arg_298_1:CheckSpriteTmpPos("1086", 4)

				for iter_301_8 = 0, var_301_5.childCount - 1 do
					local var_301_6 = var_301_5:GetChild(iter_301_8)

					if var_301_6.name == "split_4" or not string.find(var_301_6.name, "split") then
						var_301_6.gameObject:SetActive(true)
					else
						var_301_6.gameObject:SetActive(false)
					end
				end
			end

			local var_301_7 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				var_301_5.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_298_1.time_ - 0) / var_301_7)
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				var_301_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_301_8 = 0
			local var_301_9 = 0.55

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_8 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_10 = arg_298_1:GetWordFromCfg(416051070)
				local var_301_11 = arg_298_1:FormatText(var_301_10.content)

				arg_298_1.text_.text = var_301_11

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_13 = 22 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_11) / 22)

				if (22 <= 0 and var_301_9 or var_301_9 * (utf8.len(var_301_11) / 22)) > 0 and var_301_9 < var_301_13 then
					arg_298_1.talkMaxDuration = var_301_13

					if var_301_13 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_13 + var_301_8
					end
				end

				arg_298_1.text_.text = var_301_11
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051070", "story_v_out_416051.awb") ~= 0 then
					local var_301_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051070", "story_v_out_416051.awb") / 1000

					if var_301_14 + var_301_8 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_14 + var_301_8
					end

					if var_301_10.prefab_name ~= "" and arg_298_1.actors_[var_301_10.prefab_name] ~= nil then
						local var_301_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_10.prefab_name].transform, "story_v_out_416051", "416051070", "story_v_out_416051.awb")

						arg_298_1:RecordAudio("416051070", var_301_15)
						arg_298_1:RecordAudio("416051070", var_301_15)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_416051", "416051070", "story_v_out_416051.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_416051", "416051070", "story_v_out_416051.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_16 = math.max(var_301_9, arg_298_1.talkMaxDuration)

			if var_301_8 <= arg_298_1.time_ and arg_298_1.time_ < var_301_8 + var_301_16 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_8) / var_301_16

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_8 + var_301_16 and arg_298_1.time_ < var_301_8 + var_301_16 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_298_1:InitPlayNodeList()
	end,
	Play416051071 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 416051071
		arg_302_1.duration_ = 7.9

		local var_302_0 = {
			zh = 4.533,
			ja = 7.9
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play416051072(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(arg_302_1.actors_["1028"]) and arg_302_1.var_.actorSpriteComps1028 == nil then
				arg_302_1.var_.actorSpriteComps1028 = arg_302_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_0 = 0.125

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 and not isNil(arg_302_1.actors_["1028"]) then
				if arg_302_1.var_.actorSpriteComps1028 then
					for iter_305_0, iter_305_1 in pairs(arg_302_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_305_1 then
							if arg_302_1.isInRecall_ then
								iter_305_1.color = Color.New(Mathf.Lerp(iter_305_1.color.r, arg_302_1.hightColor1.r, (arg_302_1.time_ - 0) / var_305_0), Mathf.Lerp(iter_305_1.color.g, arg_302_1.hightColor1.g, (arg_302_1.time_ - 0) / var_305_0), (Mathf.Lerp(iter_305_1.color.b, arg_302_1.hightColor1.b, (arg_302_1.time_ - 0) / var_305_0)))
							else
								local var_305_1 = Mathf.Lerp(iter_305_1.color.r, 1, (arg_302_1.time_ - 0) / var_305_0)

								iter_305_1.color = Color.New(var_305_1, var_305_1, var_305_1)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 and not isNil(arg_302_1.actors_["1028"]) and arg_302_1.var_.actorSpriteComps1028 then
				for iter_305_2, iter_305_3 in pairs(arg_302_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_305_3 then
						iter_305_3.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_302_1.var_.actorSpriteComps1028 = nil
			end

			local var_305_2 = arg_302_1.actors_["1086"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps1086 == nil then
				arg_302_1.var_.actorSpriteComps1086 = var_305_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_305_3 = 0.125

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_3 and not isNil(var_305_2) then
				if arg_302_1.var_.actorSpriteComps1086 then
					for iter_305_4, iter_305_5 in pairs(arg_302_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_305_5 then
							if arg_302_1.isInRecall_ then
								iter_305_5.color = Color.New(Mathf.Lerp(iter_305_5.color.r, arg_302_1.hightColor2.r, (arg_302_1.time_ - 0) / var_305_3), Mathf.Lerp(iter_305_5.color.g, arg_302_1.hightColor2.g, (arg_302_1.time_ - 0) / var_305_3), (Mathf.Lerp(iter_305_5.color.b, arg_302_1.hightColor2.b, (arg_302_1.time_ - 0) / var_305_3)))
							else
								local var_305_4 = Mathf.Lerp(iter_305_5.color.r, 0.5, (arg_302_1.time_ - 0) / var_305_3)

								iter_305_5.color = Color.New(var_305_4, var_305_4, var_305_4)
							end
						end
					end
				end
			end

			if arg_302_1.time_ >= 0 + var_305_3 and arg_302_1.time_ < 0 + var_305_3 + arg_305_0 and not isNil(var_305_2) and arg_302_1.var_.actorSpriteComps1086 then
				for iter_305_6, iter_305_7 in pairs(arg_302_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_305_7 then
						iter_305_7.color = arg_302_1.isInRecall_ and (arg_302_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_302_1.var_.actorSpriteComps1086 = nil
			end

			local var_305_5 = 0
			local var_305_6 = 0.575

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_5 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_7 = arg_302_1:GetWordFromCfg(416051071)
				local var_305_8 = arg_302_1:FormatText(var_305_7.content)

				arg_302_1.text_.text = var_305_8

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_10 = 23 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 23)

				if (23 <= 0 and var_305_6 or var_305_6 * (utf8.len(var_305_8) / 23)) > 0 and var_305_6 < var_305_10 then
					arg_302_1.talkMaxDuration = var_305_10

					if var_305_10 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_10 + var_305_5
					end
				end

				arg_302_1.text_.text = var_305_8
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051071", "story_v_out_416051.awb") ~= 0 then
					local var_305_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051071", "story_v_out_416051.awb") / 1000

					if var_305_11 + var_305_5 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_5
					end

					if var_305_7.prefab_name ~= "" and arg_302_1.actors_[var_305_7.prefab_name] ~= nil then
						local var_305_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_7.prefab_name].transform, "story_v_out_416051", "416051071", "story_v_out_416051.awb")

						arg_302_1:RecordAudio("416051071", var_305_12)
						arg_302_1:RecordAudio("416051071", var_305_12)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_416051", "416051071", "story_v_out_416051.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_416051", "416051071", "story_v_out_416051.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_13 = math.max(var_305_6, arg_302_1.talkMaxDuration)

			if var_305_5 <= arg_302_1.time_ and arg_302_1.time_ < var_305_5 + var_305_13 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_5) / var_305_13

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_5 + var_305_13 and arg_302_1.time_ < var_305_5 + var_305_13 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play416051072 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 416051072
		arg_306_1.duration_ = 6.9

		local var_306_0 = {
			zh = 5.133,
			ja = 6.9
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play416051073(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1028"]) and arg_306_1.var_.actorSpriteComps1028 == nil then
				arg_306_1.var_.actorSpriteComps1028 = arg_306_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_0 = 0.125

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1028"]) then
				if arg_306_1.var_.actorSpriteComps1028 then
					for iter_309_0, iter_309_1 in pairs(arg_306_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_309_1 then
							if arg_306_1.isInRecall_ then
								iter_309_1.color = Color.New(Mathf.Lerp(iter_309_1.color.r, arg_306_1.hightColor2.r, (arg_306_1.time_ - 0) / var_309_0), Mathf.Lerp(iter_309_1.color.g, arg_306_1.hightColor2.g, (arg_306_1.time_ - 0) / var_309_0), (Mathf.Lerp(iter_309_1.color.b, arg_306_1.hightColor2.b, (arg_306_1.time_ - 0) / var_309_0)))
							else
								local var_309_1 = Mathf.Lerp(iter_309_1.color.r, 0.5, (arg_306_1.time_ - 0) / var_309_0)

								iter_309_1.color = Color.New(var_309_1, var_309_1, var_309_1)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1028"]) and arg_306_1.var_.actorSpriteComps1028 then
				for iter_309_2, iter_309_3 in pairs(arg_306_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_309_3 then
						iter_309_3.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_306_1.var_.actorSpriteComps1028 = nil
			end

			local var_309_2 = arg_306_1.actors_["1086"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps1086 == nil then
				arg_306_1.var_.actorSpriteComps1086 = var_309_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_309_3 = 0.125

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.actorSpriteComps1086 then
					for iter_309_4, iter_309_5 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_309_5 then
							if arg_306_1.isInRecall_ then
								iter_309_5.color = Color.New(Mathf.Lerp(iter_309_5.color.r, arg_306_1.hightColor1.r, (arg_306_1.time_ - 0) / var_309_3), Mathf.Lerp(iter_309_5.color.g, arg_306_1.hightColor1.g, (arg_306_1.time_ - 0) / var_309_3), (Mathf.Lerp(iter_309_5.color.b, arg_306_1.hightColor1.b, (arg_306_1.time_ - 0) / var_309_3)))
							else
								local var_309_4 = Mathf.Lerp(iter_309_5.color.r, 1, (arg_306_1.time_ - 0) / var_309_3)

								iter_309_5.color = Color.New(var_309_4, var_309_4, var_309_4)
							end
						end
					end
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.actorSpriteComps1086 then
				for iter_309_6, iter_309_7 in pairs(arg_306_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_309_7 then
						iter_309_7.color = arg_306_1.isInRecall_ and (arg_306_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_306_1.var_.actorSpriteComps1086 = nil
			end

			local var_309_5 = 0
			local var_309_6 = 0.7

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_5 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_7 = arg_306_1:GetWordFromCfg(416051072)
				local var_309_8 = arg_306_1:FormatText(var_309_7.content)

				arg_306_1.text_.text = var_309_8

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_10 = 28 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 28)

				if (28 <= 0 and var_309_6 or var_309_6 * (utf8.len(var_309_8) / 28)) > 0 and var_309_6 < var_309_10 then
					arg_306_1.talkMaxDuration = var_309_10

					if var_309_10 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_5
					end
				end

				arg_306_1.text_.text = var_309_8
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051072", "story_v_out_416051.awb") ~= 0 then
					local var_309_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051072", "story_v_out_416051.awb") / 1000

					if var_309_11 + var_309_5 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_11 + var_309_5
					end

					if var_309_7.prefab_name ~= "" and arg_306_1.actors_[var_309_7.prefab_name] ~= nil then
						local var_309_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_7.prefab_name].transform, "story_v_out_416051", "416051072", "story_v_out_416051.awb")

						arg_306_1:RecordAudio("416051072", var_309_12)
						arg_306_1:RecordAudio("416051072", var_309_12)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_416051", "416051072", "story_v_out_416051.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_416051", "416051072", "story_v_out_416051.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_13 = math.max(var_309_6, arg_306_1.talkMaxDuration)

			if var_309_5 <= arg_306_1.time_ and arg_306_1.time_ < var_309_5 + var_309_13 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_5) / var_309_13

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_5 + var_309_13 and arg_306_1.time_ < var_309_5 + var_309_13 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play416051073 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 416051073
		arg_310_1.duration_ = 5.77

		local var_310_0 = {
			zh = 4.2,
			ja = 5.766
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play416051074(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["1028"]) and arg_310_1.var_.actorSpriteComps1028 == nil then
				arg_310_1.var_.actorSpriteComps1028 = arg_310_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_0 = 0.125

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["1028"]) then
				if arg_310_1.var_.actorSpriteComps1028 then
					for iter_313_0, iter_313_1 in pairs(arg_310_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_313_1 then
							if arg_310_1.isInRecall_ then
								iter_313_1.color = Color.New(Mathf.Lerp(iter_313_1.color.r, arg_310_1.hightColor1.r, (arg_310_1.time_ - 0) / var_313_0), Mathf.Lerp(iter_313_1.color.g, arg_310_1.hightColor1.g, (arg_310_1.time_ - 0) / var_313_0), (Mathf.Lerp(iter_313_1.color.b, arg_310_1.hightColor1.b, (arg_310_1.time_ - 0) / var_313_0)))
							else
								local var_313_1 = Mathf.Lerp(iter_313_1.color.r, 1, (arg_310_1.time_ - 0) / var_313_0)

								iter_313_1.color = Color.New(var_313_1, var_313_1, var_313_1)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["1028"]) and arg_310_1.var_.actorSpriteComps1028 then
				for iter_313_2, iter_313_3 in pairs(arg_310_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_313_3 then
						iter_313_3.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_310_1.var_.actorSpriteComps1028 = nil
			end

			local var_313_2 = arg_310_1.actors_["1086"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps1086 == nil then
				arg_310_1.var_.actorSpriteComps1086 = var_313_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_313_3 = 0.125

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_3 and not isNil(var_313_2) then
				if arg_310_1.var_.actorSpriteComps1086 then
					for iter_313_4, iter_313_5 in pairs(arg_310_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_313_5 then
							if arg_310_1.isInRecall_ then
								iter_313_5.color = Color.New(Mathf.Lerp(iter_313_5.color.r, arg_310_1.hightColor2.r, (arg_310_1.time_ - 0) / var_313_3), Mathf.Lerp(iter_313_5.color.g, arg_310_1.hightColor2.g, (arg_310_1.time_ - 0) / var_313_3), (Mathf.Lerp(iter_313_5.color.b, arg_310_1.hightColor2.b, (arg_310_1.time_ - 0) / var_313_3)))
							else
								local var_313_4 = Mathf.Lerp(iter_313_5.color.r, 0.5, (arg_310_1.time_ - 0) / var_313_3)

								iter_313_5.color = Color.New(var_313_4, var_313_4, var_313_4)
							end
						end
					end
				end
			end

			if arg_310_1.time_ >= 0 + var_313_3 and arg_310_1.time_ < 0 + var_313_3 + arg_313_0 and not isNil(var_313_2) and arg_310_1.var_.actorSpriteComps1086 then
				for iter_313_6, iter_313_7 in pairs(arg_310_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_313_7 then
						iter_313_7.color = arg_310_1.isInRecall_ and (arg_310_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_310_1.var_.actorSpriteComps1086 = nil
			end

			local var_313_5 = 0
			local var_313_6 = 0.425

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_7 = arg_310_1:GetWordFromCfg(416051073)
				local var_313_8 = arg_310_1:FormatText(var_313_7.content)

				arg_310_1.text_.text = var_313_8

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_10 = 17 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 17)

				if (17 <= 0 and var_313_6 or var_313_6 * (utf8.len(var_313_8) / 17)) > 0 and var_313_6 < var_313_10 then
					arg_310_1.talkMaxDuration = var_313_10

					if var_313_10 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_5
					end
				end

				arg_310_1.text_.text = var_313_8
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051073", "story_v_out_416051.awb") ~= 0 then
					local var_313_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051073", "story_v_out_416051.awb") / 1000

					if var_313_11 + var_313_5 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_11 + var_313_5
					end

					if var_313_7.prefab_name ~= "" and arg_310_1.actors_[var_313_7.prefab_name] ~= nil then
						local var_313_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_7.prefab_name].transform, "story_v_out_416051", "416051073", "story_v_out_416051.awb")

						arg_310_1:RecordAudio("416051073", var_313_12)
						arg_310_1:RecordAudio("416051073", var_313_12)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_416051", "416051073", "story_v_out_416051.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_416051", "416051073", "story_v_out_416051.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_13 = math.max(var_313_6, arg_310_1.talkMaxDuration)

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_13 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_5) / var_313_13

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_5 + var_313_13 and arg_310_1.time_ < var_313_5 + var_313_13 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play416051074 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 416051074
		arg_314_1.duration_ = 5.97

		local var_314_0 = {
			zh = 5.9,
			ja = 5.966
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play416051075(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["1028"]) and arg_314_1.var_.actorSpriteComps1028 == nil then
				arg_314_1.var_.actorSpriteComps1028 = arg_314_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_0 = 0.125

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["1028"]) then
				if arg_314_1.var_.actorSpriteComps1028 then
					for iter_317_0, iter_317_1 in pairs(arg_314_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_317_1 then
							if arg_314_1.isInRecall_ then
								iter_317_1.color = Color.New(Mathf.Lerp(iter_317_1.color.r, arg_314_1.hightColor2.r, (arg_314_1.time_ - 0) / var_317_0), Mathf.Lerp(iter_317_1.color.g, arg_314_1.hightColor2.g, (arg_314_1.time_ - 0) / var_317_0), (Mathf.Lerp(iter_317_1.color.b, arg_314_1.hightColor2.b, (arg_314_1.time_ - 0) / var_317_0)))
							else
								local var_317_1 = Mathf.Lerp(iter_317_1.color.r, 0.5, (arg_314_1.time_ - 0) / var_317_0)

								iter_317_1.color = Color.New(var_317_1, var_317_1, var_317_1)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["1028"]) and arg_314_1.var_.actorSpriteComps1028 then
				for iter_317_2, iter_317_3 in pairs(arg_314_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_317_3 then
						iter_317_3.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_314_1.var_.actorSpriteComps1028 = nil
			end

			local var_317_2 = arg_314_1.actors_["1086"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps1086 == nil then
				arg_314_1.var_.actorSpriteComps1086 = var_317_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_317_3 = 0.125

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.actorSpriteComps1086 then
					for iter_317_4, iter_317_5 in pairs(arg_314_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_317_5 then
							if arg_314_1.isInRecall_ then
								iter_317_5.color = Color.New(Mathf.Lerp(iter_317_5.color.r, arg_314_1.hightColor1.r, (arg_314_1.time_ - 0) / var_317_3), Mathf.Lerp(iter_317_5.color.g, arg_314_1.hightColor1.g, (arg_314_1.time_ - 0) / var_317_3), (Mathf.Lerp(iter_317_5.color.b, arg_314_1.hightColor1.b, (arg_314_1.time_ - 0) / var_317_3)))
							else
								local var_317_4 = Mathf.Lerp(iter_317_5.color.r, 1, (arg_314_1.time_ - 0) / var_317_3)

								iter_317_5.color = Color.New(var_317_4, var_317_4, var_317_4)
							end
						end
					end
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.actorSpriteComps1086 then
				for iter_317_6, iter_317_7 in pairs(arg_314_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_317_7 then
						iter_317_7.color = arg_314_1.isInRecall_ and (arg_314_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_314_1.var_.actorSpriteComps1086 = nil
			end

			local var_317_5 = arg_314_1.actors_["1086"].transform

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.var_.moveOldPos1086 = var_317_5.localPosition
				var_317_5.localScale = Vector3.New(1, 1, 1)

				arg_314_1:CheckSpriteTmpPos("1086", 4)

				for iter_317_8 = 0, var_317_5.childCount - 1 do
					local var_317_6 = var_317_5:GetChild(iter_317_8)

					if var_317_6.name == "split_1" or not string.find(var_317_6.name, "split") then
						var_317_6.gameObject:SetActive(true)
					else
						var_317_6.gameObject:SetActive(false)
					end
				end
			end

			local var_317_7 = 0.001

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				var_317_5.localPosition = Vector3.Lerp(arg_314_1.var_.moveOldPos1086, Vector3.New(390, -404.2, -237.9), (arg_314_1.time_ - 0) / var_317_7)
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				var_317_5.localPosition = Vector3.New(390, -404.2, -237.9)
			end

			local var_317_8 = 0
			local var_317_9 = 0.675

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_8 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_10 = arg_314_1:GetWordFromCfg(416051074)
				local var_317_11 = arg_314_1:FormatText(var_317_10.content)

				arg_314_1.text_.text = var_317_11

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_13 = 27 <= 0 and var_317_9 or var_317_9 * (utf8.len(var_317_11) / 27)

				if (27 <= 0 and var_317_9 or var_317_9 * (utf8.len(var_317_11) / 27)) > 0 and var_317_9 < var_317_13 then
					arg_314_1.talkMaxDuration = var_317_13

					if var_317_13 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_13 + var_317_8
					end
				end

				arg_314_1.text_.text = var_317_11
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051074", "story_v_out_416051.awb") ~= 0 then
					local var_317_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051074", "story_v_out_416051.awb") / 1000

					if var_317_14 + var_317_8 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_14 + var_317_8
					end

					if var_317_10.prefab_name ~= "" and arg_314_1.actors_[var_317_10.prefab_name] ~= nil then
						local var_317_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_10.prefab_name].transform, "story_v_out_416051", "416051074", "story_v_out_416051.awb")

						arg_314_1:RecordAudio("416051074", var_317_15)
						arg_314_1:RecordAudio("416051074", var_317_15)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_416051", "416051074", "story_v_out_416051.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_416051", "416051074", "story_v_out_416051.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_16 = math.max(var_317_9, arg_314_1.talkMaxDuration)

			if var_317_8 <= arg_314_1.time_ and arg_314_1.time_ < var_317_8 + var_317_16 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_8) / var_317_16

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_8 + var_317_16 and arg_314_1.time_ < var_317_8 + var_317_16 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_314_1:InitPlayNodeList()
	end,
	Play416051075 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 416051075
		arg_318_1.duration_ = 5.77

		local var_318_0 = {
			zh = 4.733,
			ja = 5.766
		}
		local var_318_1 = manager.audio:GetLocalizationFlag()

		if var_318_0[var_318_1] ~= nil then
			arg_318_1.duration_ = var_318_0[var_318_1]
		end

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play416051076(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["1028"]) and arg_318_1.var_.actorSpriteComps1028 == nil then
				arg_318_1.var_.actorSpriteComps1028 = arg_318_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_0 = 0.125

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["1028"]) then
				if arg_318_1.var_.actorSpriteComps1028 then
					for iter_321_0, iter_321_1 in pairs(arg_318_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_321_1 then
							if arg_318_1.isInRecall_ then
								iter_321_1.color = Color.New(Mathf.Lerp(iter_321_1.color.r, arg_318_1.hightColor1.r, (arg_318_1.time_ - 0) / var_321_0), Mathf.Lerp(iter_321_1.color.g, arg_318_1.hightColor1.g, (arg_318_1.time_ - 0) / var_321_0), (Mathf.Lerp(iter_321_1.color.b, arg_318_1.hightColor1.b, (arg_318_1.time_ - 0) / var_321_0)))
							else
								local var_321_1 = Mathf.Lerp(iter_321_1.color.r, 1, (arg_318_1.time_ - 0) / var_321_0)

								iter_321_1.color = Color.New(var_321_1, var_321_1, var_321_1)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["1028"]) and arg_318_1.var_.actorSpriteComps1028 then
				for iter_321_2, iter_321_3 in pairs(arg_318_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_321_3 then
						iter_321_3.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_318_1.var_.actorSpriteComps1028 = nil
			end

			local var_321_2 = arg_318_1.actors_["1086"]

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps1086 == nil then
				arg_318_1.var_.actorSpriteComps1086 = var_321_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_321_3 = 0.125

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_3 and not isNil(var_321_2) then
				if arg_318_1.var_.actorSpriteComps1086 then
					for iter_321_4, iter_321_5 in pairs(arg_318_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_321_5 then
							if arg_318_1.isInRecall_ then
								iter_321_5.color = Color.New(Mathf.Lerp(iter_321_5.color.r, arg_318_1.hightColor2.r, (arg_318_1.time_ - 0) / var_321_3), Mathf.Lerp(iter_321_5.color.g, arg_318_1.hightColor2.g, (arg_318_1.time_ - 0) / var_321_3), (Mathf.Lerp(iter_321_5.color.b, arg_318_1.hightColor2.b, (arg_318_1.time_ - 0) / var_321_3)))
							else
								local var_321_4 = Mathf.Lerp(iter_321_5.color.r, 0.5, (arg_318_1.time_ - 0) / var_321_3)

								iter_321_5.color = Color.New(var_321_4, var_321_4, var_321_4)
							end
						end
					end
				end
			end

			if arg_318_1.time_ >= 0 + var_321_3 and arg_318_1.time_ < 0 + var_321_3 + arg_321_0 and not isNil(var_321_2) and arg_318_1.var_.actorSpriteComps1086 then
				for iter_321_6, iter_321_7 in pairs(arg_318_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_321_7 then
						iter_321_7.color = arg_318_1.isInRecall_ and (arg_318_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_318_1.var_.actorSpriteComps1086 = nil
			end

			local var_321_5 = 0
			local var_321_6 = 0.525

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_5 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, true)

				arg_318_1.leftNameTxt_.text = arg_318_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_318_1.leftNameTxt_.transform)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1.leftNameTxt_.text)
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_7 = arg_318_1:GetWordFromCfg(416051075)
				local var_321_8 = arg_318_1:FormatText(var_321_7.content)

				arg_318_1.text_.text = var_321_8

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_10 = 21 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 21)

				if (21 <= 0 and var_321_6 or var_321_6 * (utf8.len(var_321_8) / 21)) > 0 and var_321_6 < var_321_10 then
					arg_318_1.talkMaxDuration = var_321_10

					if var_321_10 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_10 + var_321_5
					end
				end

				arg_318_1.text_.text = var_321_8
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051075", "story_v_out_416051.awb") ~= 0 then
					local var_321_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051075", "story_v_out_416051.awb") / 1000

					if var_321_11 + var_321_5 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_11 + var_321_5
					end

					if var_321_7.prefab_name ~= "" and arg_318_1.actors_[var_321_7.prefab_name] ~= nil then
						local var_321_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_318_1.actors_[var_321_7.prefab_name].transform, "story_v_out_416051", "416051075", "story_v_out_416051.awb")

						arg_318_1:RecordAudio("416051075", var_321_12)
						arg_318_1:RecordAudio("416051075", var_321_12)
					else
						arg_318_1:AudioAction("play", "voice", "story_v_out_416051", "416051075", "story_v_out_416051.awb")
					end

					arg_318_1:RecordHistoryTalkVoice("story_v_out_416051", "416051075", "story_v_out_416051.awb")
				end

				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_13 = math.max(var_321_6, arg_318_1.talkMaxDuration)

			if var_321_5 <= arg_318_1.time_ and arg_318_1.time_ < var_321_5 + var_321_13 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_5) / var_321_13

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_5 + var_321_13 and arg_318_1.time_ < var_321_5 + var_321_13 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play416051076 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 416051076
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play416051077(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(arg_322_1.actors_["1028"]) and arg_322_1.var_.actorSpriteComps1028 == nil then
				arg_322_1.var_.actorSpriteComps1028 = arg_322_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_0 = 0.125

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_0 and not isNil(arg_322_1.actors_["1028"]) then
				if arg_322_1.var_.actorSpriteComps1028 then
					for iter_325_0, iter_325_1 in pairs(arg_322_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_325_1 then
							if arg_322_1.isInRecall_ then
								iter_325_1.color = Color.New(Mathf.Lerp(iter_325_1.color.r, arg_322_1.hightColor2.r, (arg_322_1.time_ - 0) / var_325_0), Mathf.Lerp(iter_325_1.color.g, arg_322_1.hightColor2.g, (arg_322_1.time_ - 0) / var_325_0), (Mathf.Lerp(iter_325_1.color.b, arg_322_1.hightColor2.b, (arg_322_1.time_ - 0) / var_325_0)))
							else
								local var_325_1 = Mathf.Lerp(iter_325_1.color.r, 0.5, (arg_322_1.time_ - 0) / var_325_0)

								iter_325_1.color = Color.New(var_325_1, var_325_1, var_325_1)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_0 and arg_322_1.time_ < 0 + var_325_0 + arg_325_0 and not isNil(arg_322_1.actors_["1028"]) and arg_322_1.var_.actorSpriteComps1028 then
				for iter_325_2, iter_325_3 in pairs(arg_322_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_325_3 then
						iter_325_3.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_322_1.var_.actorSpriteComps1028 = nil
			end

			local var_325_2 = arg_322_1.actors_["1086"]

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.actorSpriteComps1086 == nil then
				arg_322_1.var_.actorSpriteComps1086 = var_325_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_325_3 = 0.125

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_3 and not isNil(var_325_2) then
				if arg_322_1.var_.actorSpriteComps1086 then
					for iter_325_4, iter_325_5 in pairs(arg_322_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_325_5 then
							if arg_322_1.isInRecall_ then
								iter_325_5.color = Color.New(Mathf.Lerp(iter_325_5.color.r, arg_322_1.hightColor2.r, (arg_322_1.time_ - 0) / var_325_3), Mathf.Lerp(iter_325_5.color.g, arg_322_1.hightColor2.g, (arg_322_1.time_ - 0) / var_325_3), (Mathf.Lerp(iter_325_5.color.b, arg_322_1.hightColor2.b, (arg_322_1.time_ - 0) / var_325_3)))
							else
								local var_325_4 = Mathf.Lerp(iter_325_5.color.r, 0.5, (arg_322_1.time_ - 0) / var_325_3)

								iter_325_5.color = Color.New(var_325_4, var_325_4, var_325_4)
							end
						end
					end
				end
			end

			if arg_322_1.time_ >= 0 + var_325_3 and arg_322_1.time_ < 0 + var_325_3 + arg_325_0 and not isNil(var_325_2) and arg_322_1.var_.actorSpriteComps1086 then
				for iter_325_6, iter_325_7 in pairs(arg_322_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_325_7 then
						iter_325_7.color = arg_322_1.isInRecall_ and (arg_322_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_322_1.var_.actorSpriteComps1086 = nil
			end

			local var_325_5 = 0
			local var_325_6 = 1.825

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= var_325_5 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_7 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(416051076).content)

				arg_322_1.text_.text = var_325_7

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_9 = 73 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 73)

				if (73 <= 0 and var_325_6 or var_325_6 * (utf8.len(var_325_7) / 73)) > 0 and var_325_6 < var_325_9 then
					arg_322_1.talkMaxDuration = var_325_9

					if var_325_9 + var_325_5 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_9 + var_325_5
					end
				end

				arg_322_1.text_.text = var_325_7
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_10 = math.max(var_325_6, arg_322_1.talkMaxDuration)

			if var_325_5 <= arg_322_1.time_ and arg_322_1.time_ < var_325_5 + var_325_10 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - var_325_5) / var_325_10

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= var_325_5 + var_325_10 and arg_322_1.time_ < var_325_5 + var_325_10 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play416051077 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 416051077
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play416051078(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 1.725

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(416051077).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 69 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 69)

				if (69 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 69)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play416051078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 416051078
		arg_330_1.duration_ = 2.03

		local var_330_0 = {
			zh = 2.033,
			ja = 1.433
		}
		local var_330_1 = manager.audio:GetLocalizationFlag()

		if var_330_0[var_330_1] ~= nil then
			arg_330_1.duration_ = var_330_0[var_330_1]
		end

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play416051079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(arg_330_1.actors_["1028"]) and arg_330_1.var_.actorSpriteComps1028 == nil then
				arg_330_1.var_.actorSpriteComps1028 = arg_330_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_0 = 0.125

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_0 and not isNil(arg_330_1.actors_["1028"]) then
				if arg_330_1.var_.actorSpriteComps1028 then
					for iter_333_0, iter_333_1 in pairs(arg_330_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_333_1 then
							if arg_330_1.isInRecall_ then
								iter_333_1.color = Color.New(Mathf.Lerp(iter_333_1.color.r, arg_330_1.hightColor1.r, (arg_330_1.time_ - 0) / var_333_0), Mathf.Lerp(iter_333_1.color.g, arg_330_1.hightColor1.g, (arg_330_1.time_ - 0) / var_333_0), (Mathf.Lerp(iter_333_1.color.b, arg_330_1.hightColor1.b, (arg_330_1.time_ - 0) / var_333_0)))
							else
								local var_333_1 = Mathf.Lerp(iter_333_1.color.r, 1, (arg_330_1.time_ - 0) / var_333_0)

								iter_333_1.color = Color.New(var_333_1, var_333_1, var_333_1)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_0 and arg_330_1.time_ < 0 + var_333_0 + arg_333_0 and not isNil(arg_330_1.actors_["1028"]) and arg_330_1.var_.actorSpriteComps1028 then
				for iter_333_2, iter_333_3 in pairs(arg_330_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_333_3 then
						iter_333_3.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_330_1.var_.actorSpriteComps1028 = nil
			end

			local var_333_2 = arg_330_1.actors_["1086"]

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 and not isNil(var_333_2) and arg_330_1.var_.actorSpriteComps1086 == nil then
				arg_330_1.var_.actorSpriteComps1086 = var_333_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_333_3 = 0.125

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_3 and not isNil(var_333_2) then
				if arg_330_1.var_.actorSpriteComps1086 then
					for iter_333_4, iter_333_5 in pairs(arg_330_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_333_5 then
							if arg_330_1.isInRecall_ then
								iter_333_5.color = Color.New(Mathf.Lerp(iter_333_5.color.r, arg_330_1.hightColor2.r, (arg_330_1.time_ - 0) / var_333_3), Mathf.Lerp(iter_333_5.color.g, arg_330_1.hightColor2.g, (arg_330_1.time_ - 0) / var_333_3), (Mathf.Lerp(iter_333_5.color.b, arg_330_1.hightColor2.b, (arg_330_1.time_ - 0) / var_333_3)))
							else
								local var_333_4 = Mathf.Lerp(iter_333_5.color.r, 0.5, (arg_330_1.time_ - 0) / var_333_3)

								iter_333_5.color = Color.New(var_333_4, var_333_4, var_333_4)
							end
						end
					end
				end
			end

			if arg_330_1.time_ >= 0 + var_333_3 and arg_330_1.time_ < 0 + var_333_3 + arg_333_0 and not isNil(var_333_2) and arg_330_1.var_.actorSpriteComps1086 then
				for iter_333_6, iter_333_7 in pairs(arg_330_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_333_7 then
						iter_333_7.color = arg_330_1.isInRecall_ and (arg_330_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_330_1.var_.actorSpriteComps1086 = nil
			end

			local var_333_5 = 0
			local var_333_6 = 0.1

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_5 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, true)

				arg_330_1.leftNameTxt_.text = arg_330_1:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_330_1.leftNameTxt_.transform)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1.leftNameTxt_.text)
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_7 = arg_330_1:GetWordFromCfg(416051078)
				local var_333_8 = arg_330_1:FormatText(var_333_7.content)

				arg_330_1.text_.text = var_333_8

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_10 = 4 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_8) / 4)

				if (4 <= 0 and var_333_6 or var_333_6 * (utf8.len(var_333_8) / 4)) > 0 and var_333_6 < var_333_10 then
					arg_330_1.talkMaxDuration = var_333_10

					if var_333_10 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_10 + var_333_5
					end
				end

				arg_330_1.text_.text = var_333_8
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051078", "story_v_out_416051.awb") ~= 0 then
					local var_333_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051078", "story_v_out_416051.awb") / 1000

					if var_333_11 + var_333_5 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_11 + var_333_5
					end

					if var_333_7.prefab_name ~= "" and arg_330_1.actors_[var_333_7.prefab_name] ~= nil then
						local var_333_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_330_1.actors_[var_333_7.prefab_name].transform, "story_v_out_416051", "416051078", "story_v_out_416051.awb")

						arg_330_1:RecordAudio("416051078", var_333_12)
						arg_330_1:RecordAudio("416051078", var_333_12)
					else
						arg_330_1:AudioAction("play", "voice", "story_v_out_416051", "416051078", "story_v_out_416051.awb")
					end

					arg_330_1:RecordHistoryTalkVoice("story_v_out_416051", "416051078", "story_v_out_416051.awb")
				end

				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_13 = math.max(var_333_6, arg_330_1.talkMaxDuration)

			if var_333_5 <= arg_330_1.time_ and arg_330_1.time_ < var_333_5 + var_333_13 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_5) / var_333_13

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_5 + var_333_13 and arg_330_1.time_ < var_333_5 + var_333_13 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play416051079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 416051079
		arg_334_1.duration_ = 7.17

		local var_334_0 = {
			zh = 6.7,
			ja = 7.166
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play416051080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(arg_334_1.actors_["1028"]) and arg_334_1.var_.actorSpriteComps1028 == nil then
				arg_334_1.var_.actorSpriteComps1028 = arg_334_1.actors_["1028"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_0 = 0.125

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 and not isNil(arg_334_1.actors_["1028"]) then
				if arg_334_1.var_.actorSpriteComps1028 then
					for iter_337_0, iter_337_1 in pairs(arg_334_1.var_.actorSpriteComps1028:ToTable()) do
						if iter_337_1 then
							if arg_334_1.isInRecall_ then
								iter_337_1.color = Color.New(Mathf.Lerp(iter_337_1.color.r, arg_334_1.hightColor2.r, (arg_334_1.time_ - 0) / var_337_0), Mathf.Lerp(iter_337_1.color.g, arg_334_1.hightColor2.g, (arg_334_1.time_ - 0) / var_337_0), (Mathf.Lerp(iter_337_1.color.b, arg_334_1.hightColor2.b, (arg_334_1.time_ - 0) / var_337_0)))
							else
								local var_337_1 = Mathf.Lerp(iter_337_1.color.r, 0.5, (arg_334_1.time_ - 0) / var_337_0)

								iter_337_1.color = Color.New(var_337_1, var_337_1, var_337_1)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 and not isNil(arg_334_1.actors_["1028"]) and arg_334_1.var_.actorSpriteComps1028 then
				for iter_337_2, iter_337_3 in pairs(arg_334_1.var_.actorSpriteComps1028:ToTable()) do
					if iter_337_3 then
						iter_337_3.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_334_1.var_.actorSpriteComps1028 = nil
			end

			local var_337_2 = arg_334_1.actors_["1086"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_2) and arg_334_1.var_.actorSpriteComps1086 == nil then
				arg_334_1.var_.actorSpriteComps1086 = var_337_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_337_3 = 0.125

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_3 and not isNil(var_337_2) then
				if arg_334_1.var_.actorSpriteComps1086 then
					for iter_337_4, iter_337_5 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_337_5 then
							if arg_334_1.isInRecall_ then
								iter_337_5.color = Color.New(Mathf.Lerp(iter_337_5.color.r, arg_334_1.hightColor1.r, (arg_334_1.time_ - 0) / var_337_3), Mathf.Lerp(iter_337_5.color.g, arg_334_1.hightColor1.g, (arg_334_1.time_ - 0) / var_337_3), (Mathf.Lerp(iter_337_5.color.b, arg_334_1.hightColor1.b, (arg_334_1.time_ - 0) / var_337_3)))
							else
								local var_337_4 = Mathf.Lerp(iter_337_5.color.r, 1, (arg_334_1.time_ - 0) / var_337_3)

								iter_337_5.color = Color.New(var_337_4, var_337_4, var_337_4)
							end
						end
					end
				end
			end

			if arg_334_1.time_ >= 0 + var_337_3 and arg_334_1.time_ < 0 + var_337_3 + arg_337_0 and not isNil(var_337_2) and arg_334_1.var_.actorSpriteComps1086 then
				for iter_337_6, iter_337_7 in pairs(arg_334_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_337_7 then
						iter_337_7.color = arg_334_1.isInRecall_ and (arg_334_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_334_1.var_.actorSpriteComps1086 = nil
			end

			local var_337_5 = 0
			local var_337_6 = 0.425

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_7 = arg_334_1:GetWordFromCfg(416051079)
				local var_337_8 = arg_334_1:FormatText(var_337_7.content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 17 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 17)

				if (17 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 17)) > 0 and var_337_6 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051079", "story_v_out_416051.awb") ~= 0 then
					local var_337_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051079", "story_v_out_416051.awb") / 1000

					if var_337_11 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_5
					end

					if var_337_7.prefab_name ~= "" and arg_334_1.actors_[var_337_7.prefab_name] ~= nil then
						local var_337_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_7.prefab_name].transform, "story_v_out_416051", "416051079", "story_v_out_416051.awb")

						arg_334_1:RecordAudio("416051079", var_337_12)
						arg_334_1:RecordAudio("416051079", var_337_12)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_416051", "416051079", "story_v_out_416051.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_416051", "416051079", "story_v_out_416051.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_13 and arg_334_1.time_ < var_337_5 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {}

		arg_334_1:InitPlayNodeList()
	end,
	Play416051080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 416051080
		arg_338_1.duration_ = 3.73

		local var_338_0 = {
			zh = 3.066,
			ja = 3.733
		}
		local var_338_1 = manager.audio:GetLocalizationFlag()

		if var_338_0[var_338_1] ~= nil then
			arg_338_1.duration_ = var_338_0[var_338_1]
		end

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play416051081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(arg_338_1.actors_["1086"]) and arg_338_1.var_.actorSpriteComps1086 == nil then
				arg_338_1.var_.actorSpriteComps1086 = arg_338_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_341_0 = 0.125

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 and not isNil(arg_338_1.actors_["1086"]) then
				if arg_338_1.var_.actorSpriteComps1086 then
					for iter_341_0, iter_341_1 in pairs(arg_338_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_341_1 then
							if arg_338_1.isInRecall_ then
								iter_341_1.color = Color.New(Mathf.Lerp(iter_341_1.color.r, arg_338_1.hightColor1.r, (arg_338_1.time_ - 0) / var_341_0), Mathf.Lerp(iter_341_1.color.g, arg_338_1.hightColor1.g, (arg_338_1.time_ - 0) / var_341_0), (Mathf.Lerp(iter_341_1.color.b, arg_338_1.hightColor1.b, (arg_338_1.time_ - 0) / var_341_0)))
							else
								local var_341_1 = Mathf.Lerp(iter_341_1.color.r, 1, (arg_338_1.time_ - 0) / var_341_0)

								iter_341_1.color = Color.New(var_341_1, var_341_1, var_341_1)
							end
						end
					end
				end
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 and not isNil(arg_338_1.actors_["1086"]) and arg_338_1.var_.actorSpriteComps1086 then
				for iter_341_2, iter_341_3 in pairs(arg_338_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_341_3 then
						iter_341_3.color = arg_338_1.isInRecall_ and (arg_338_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_338_1.var_.actorSpriteComps1086 = nil
			end

			local var_341_2 = arg_338_1.actors_["1028"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1028 = var_341_2.localPosition
				var_341_2.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1028", 7)

				for iter_341_4 = 0, var_341_2.childCount - 1 do
					local var_341_3 = var_341_2:GetChild(iter_341_4)

					if var_341_3.name == "" or not string.find(var_341_3.name, "split") then
						var_341_3.gameObject:SetActive(true)
					else
						var_341_3.gameObject:SetActive(false)
					end
				end
			end

			local var_341_4 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_4 then
				var_341_2.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1028, Vector3.New(0, -2000, 0), (arg_338_1.time_ - 0) / var_341_4)
			end

			if arg_338_1.time_ >= 0 + var_341_4 and arg_338_1.time_ < 0 + var_341_4 + arg_341_0 then
				var_341_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_341_5 = arg_338_1.actors_["1086"].transform

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos1086 = var_341_5.localPosition
				var_341_5.localScale = Vector3.New(1, 1, 1)

				arg_338_1:CheckSpriteTmpPos("1086", 3)

				for iter_341_5 = 0, var_341_5.childCount - 1 do
					local var_341_6 = var_341_5:GetChild(iter_341_5)

					if var_341_6.name == "split_3" or not string.find(var_341_6.name, "split") then
						var_341_6.gameObject:SetActive(true)
					else
						var_341_6.gameObject:SetActive(false)
					end
				end
			end

			local var_341_7 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_7 then
				var_341_5.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_338_1.time_ - 0) / var_341_7)
			end

			if arg_338_1.time_ >= 0 + var_341_7 and arg_338_1.time_ < 0 + var_341_7 + arg_341_0 then
				var_341_5.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_341_8 = 0
			local var_341_9 = 0.35

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_8 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, true)

				arg_338_1.leftNameTxt_.text = arg_338_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_338_1.leftNameTxt_.transform)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1.leftNameTxt_.text)
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_10 = arg_338_1:GetWordFromCfg(416051080)
				local var_341_11 = arg_338_1:FormatText(var_341_10.content)

				arg_338_1.text_.text = var_341_11

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_13 = 14 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 14)

				if (14 <= 0 and var_341_9 or var_341_9 * (utf8.len(var_341_11) / 14)) > 0 and var_341_9 < var_341_13 then
					arg_338_1.talkMaxDuration = var_341_13

					if var_341_13 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_13 + var_341_8
					end
				end

				arg_338_1.text_.text = var_341_11
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051080", "story_v_out_416051.awb") ~= 0 then
					local var_341_14 = manager.audio:GetVoiceLength("story_v_out_416051", "416051080", "story_v_out_416051.awb") / 1000

					if var_341_14 + var_341_8 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_14 + var_341_8
					end

					if var_341_10.prefab_name ~= "" and arg_338_1.actors_[var_341_10.prefab_name] ~= nil then
						local var_341_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_338_1.actors_[var_341_10.prefab_name].transform, "story_v_out_416051", "416051080", "story_v_out_416051.awb")

						arg_338_1:RecordAudio("416051080", var_341_15)
						arg_338_1:RecordAudio("416051080", var_341_15)
					else
						arg_338_1:AudioAction("play", "voice", "story_v_out_416051", "416051080", "story_v_out_416051.awb")
					end

					arg_338_1:RecordHistoryTalkVoice("story_v_out_416051", "416051080", "story_v_out_416051.awb")
				end

				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_16 = math.max(var_341_9, arg_338_1.talkMaxDuration)

			if var_341_8 <= arg_338_1.time_ and arg_338_1.time_ < var_341_8 + var_341_16 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_8) / var_341_16

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_8 + var_341_16 and arg_338_1.time_ < var_341_8 + var_341_16 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1028",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play416051081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 416051081
		arg_342_1.duration_ = 6.03

		local var_342_0 = {
			zh = 2.666,
			ja = 6.033
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play416051082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(arg_342_1.actors_["1086"]) and arg_342_1.var_.actorSpriteComps1086 == nil then
				arg_342_1.var_.actorSpriteComps1086 = arg_342_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_345_0 = 0.125

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_0 and not isNil(arg_342_1.actors_["1086"]) then
				if arg_342_1.var_.actorSpriteComps1086 then
					for iter_345_0, iter_345_1 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_345_1 then
							if arg_342_1.isInRecall_ then
								iter_345_1.color = Color.New(Mathf.Lerp(iter_345_1.color.r, arg_342_1.hightColor2.r, (arg_342_1.time_ - 0) / var_345_0), Mathf.Lerp(iter_345_1.color.g, arg_342_1.hightColor2.g, (arg_342_1.time_ - 0) / var_345_0), (Mathf.Lerp(iter_345_1.color.b, arg_342_1.hightColor2.b, (arg_342_1.time_ - 0) / var_345_0)))
							else
								local var_345_1 = Mathf.Lerp(iter_345_1.color.r, 0.5, (arg_342_1.time_ - 0) / var_345_0)

								iter_345_1.color = Color.New(var_345_1, var_345_1, var_345_1)
							end
						end
					end
				end
			end

			if arg_342_1.time_ >= 0 + var_345_0 and arg_342_1.time_ < 0 + var_345_0 + arg_345_0 and not isNil(arg_342_1.actors_["1086"]) and arg_342_1.var_.actorSpriteComps1086 then
				for iter_345_2, iter_345_3 in pairs(arg_342_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_345_3 then
						iter_345_3.color = arg_342_1.isInRecall_ and (arg_342_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_342_1.var_.actorSpriteComps1086 = nil
			end

			local var_345_2 = 0
			local var_345_3 = 0.35

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_2 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[546].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10010")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_4 = arg_342_1:GetWordFromCfg(416051081)
				local var_345_5 = arg_342_1:FormatText(var_345_4.content)

				arg_342_1.text_.text = var_345_5

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_7 = 14 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 14)

				if (14 <= 0 and var_345_3 or var_345_3 * (utf8.len(var_345_5) / 14)) > 0 and var_345_3 < var_345_7 then
					arg_342_1.talkMaxDuration = var_345_7

					if var_345_7 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_7 + var_345_2
					end
				end

				arg_342_1.text_.text = var_345_5
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051081", "story_v_out_416051.awb") ~= 0 then
					local var_345_8 = manager.audio:GetVoiceLength("story_v_out_416051", "416051081", "story_v_out_416051.awb") / 1000

					if var_345_8 + var_345_2 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_8 + var_345_2
					end

					if var_345_4.prefab_name ~= "" and arg_342_1.actors_[var_345_4.prefab_name] ~= nil then
						local var_345_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_4.prefab_name].transform, "story_v_out_416051", "416051081", "story_v_out_416051.awb")

						arg_342_1:RecordAudio("416051081", var_345_9)
						arg_342_1:RecordAudio("416051081", var_345_9)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_416051", "416051081", "story_v_out_416051.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_416051", "416051081", "story_v_out_416051.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_10 = math.max(var_345_3, arg_342_1.talkMaxDuration)

			if var_345_2 <= arg_342_1.time_ and arg_342_1.time_ < var_345_2 + var_345_10 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_2) / var_345_10

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_2 + var_345_10 and arg_342_1.time_ < var_345_2 + var_345_10 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play416051082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 416051082
		arg_346_1.duration_ = 8.73

		local var_346_0 = {
			zh = 8.033,
			ja = 8.733
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play416051083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(arg_346_1.actors_["1086"]) and arg_346_1.var_.actorSpriteComps1086 == nil then
				arg_346_1.var_.actorSpriteComps1086 = arg_346_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_349_0 = 0.125

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 and not isNil(arg_346_1.actors_["1086"]) then
				if arg_346_1.var_.actorSpriteComps1086 then
					for iter_349_0, iter_349_1 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_349_1 then
							if arg_346_1.isInRecall_ then
								iter_349_1.color = Color.New(Mathf.Lerp(iter_349_1.color.r, arg_346_1.hightColor1.r, (arg_346_1.time_ - 0) / var_349_0), Mathf.Lerp(iter_349_1.color.g, arg_346_1.hightColor1.g, (arg_346_1.time_ - 0) / var_349_0), (Mathf.Lerp(iter_349_1.color.b, arg_346_1.hightColor1.b, (arg_346_1.time_ - 0) / var_349_0)))
							else
								local var_349_1 = Mathf.Lerp(iter_349_1.color.r, 1, (arg_346_1.time_ - 0) / var_349_0)

								iter_349_1.color = Color.New(var_349_1, var_349_1, var_349_1)
							end
						end
					end
				end
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 and not isNil(arg_346_1.actors_["1086"]) and arg_346_1.var_.actorSpriteComps1086 then
				for iter_349_2, iter_349_3 in pairs(arg_346_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_349_3 then
						iter_349_3.color = arg_346_1.isInRecall_ and (arg_346_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_346_1.var_.actorSpriteComps1086 = nil
			end

			local var_349_2 = arg_346_1.actors_["1086"].transform

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1086 = var_349_2.localPosition
				var_349_2.localScale = Vector3.New(1, 1, 1)

				arg_346_1:CheckSpriteTmpPos("1086", 3)

				for iter_349_4 = 0, var_349_2.childCount - 1 do
					local var_349_3 = var_349_2:GetChild(iter_349_4)

					if var_349_3.name == "split_4" or not string.find(var_349_3.name, "split") then
						var_349_3.gameObject:SetActive(true)
					else
						var_349_3.gameObject:SetActive(false)
					end
				end
			end

			local var_349_4 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_4 then
				var_349_2.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_346_1.time_ - 0) / var_349_4)
			end

			if arg_346_1.time_ >= 0 + var_349_4 and arg_346_1.time_ < 0 + var_349_4 + arg_349_0 then
				var_349_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_349_5 = 0
			local var_349_6 = 0.525

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_7 = arg_346_1:GetWordFromCfg(416051082)
				local var_349_8 = arg_346_1:FormatText(var_349_7.content)

				arg_346_1.text_.text = var_349_8

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_10 = 21 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 21)

				if (21 <= 0 and var_349_6 or var_349_6 * (utf8.len(var_349_8) / 21)) > 0 and var_349_6 < var_349_10 then
					arg_346_1.talkMaxDuration = var_349_10

					if var_349_10 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_10 + var_349_5
					end
				end

				arg_346_1.text_.text = var_349_8
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051082", "story_v_out_416051.awb") ~= 0 then
					local var_349_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051082", "story_v_out_416051.awb") / 1000

					if var_349_11 + var_349_5 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_5
					end

					if var_349_7.prefab_name ~= "" and arg_346_1.actors_[var_349_7.prefab_name] ~= nil then
						local var_349_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_7.prefab_name].transform, "story_v_out_416051", "416051082", "story_v_out_416051.awb")

						arg_346_1:RecordAudio("416051082", var_349_12)
						arg_346_1:RecordAudio("416051082", var_349_12)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_416051", "416051082", "story_v_out_416051.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_416051", "416051082", "story_v_out_416051.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_13 = math.max(var_349_6, arg_346_1.talkMaxDuration)

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_13 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_5) / var_349_13

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_5 + var_349_13 and arg_346_1.time_ < var_349_5 + var_349_13 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play416051083 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 416051083
		arg_350_1.duration_ = 5

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play416051084(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["1086"]) and arg_350_1.var_.actorSpriteComps1086 == nil then
				arg_350_1.var_.actorSpriteComps1086 = arg_350_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_353_0 = 0.125

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["1086"]) then
				if arg_350_1.var_.actorSpriteComps1086 then
					for iter_353_0, iter_353_1 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_353_1 then
							if arg_350_1.isInRecall_ then
								iter_353_1.color = Color.New(Mathf.Lerp(iter_353_1.color.r, arg_350_1.hightColor2.r, (arg_350_1.time_ - 0) / var_353_0), Mathf.Lerp(iter_353_1.color.g, arg_350_1.hightColor2.g, (arg_350_1.time_ - 0) / var_353_0), (Mathf.Lerp(iter_353_1.color.b, arg_350_1.hightColor2.b, (arg_350_1.time_ - 0) / var_353_0)))
							else
								local var_353_1 = Mathf.Lerp(iter_353_1.color.r, 0.5, (arg_350_1.time_ - 0) / var_353_0)

								iter_353_1.color = Color.New(var_353_1, var_353_1, var_353_1)
							end
						end
					end
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["1086"]) and arg_350_1.var_.actorSpriteComps1086 then
				for iter_353_2, iter_353_3 in pairs(arg_350_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_353_3 then
						iter_353_3.color = arg_350_1.isInRecall_ and (arg_350_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_350_1.var_.actorSpriteComps1086 = nil
			end

			if 0.866666666666667 < arg_350_1.time_ and arg_350_1.time_ <= 0.866666666666667 + arg_353_0 then
				arg_350_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_swordlight", "")
			end

			local var_353_3 = 0

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_3 + arg_353_0 then
				arg_350_1.allBtn_.enabled = false
			end

			if arg_350_1.time_ >= var_353_3 + 0.866666666666667 and arg_350_1.time_ < var_353_3 + 0.866666666666667 + arg_353_0 then
				arg_350_1.allBtn_.enabled = true
			end

			local var_353_4 = 0
			local var_353_5 = 1.5

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, false)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:FormatText(arg_350_1:GetWordFromCfg(416051083).content)

				arg_350_1.text_.text = var_353_6

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_8 = 60 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_6) / 60)

				if (60 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_6) / 60)) > 0 and var_353_5 < var_353_8 then
					arg_350_1.talkMaxDuration = var_353_8

					if var_353_8 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_8 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_6
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)
				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_9 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_9 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_9

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_9 and arg_350_1.time_ < var_353_4 + var_353_9 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play416051084 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 416051084
		arg_354_1.duration_ = 3.53

		local var_354_0 = {
			zh = 3.533,
			ja = 3.266
		}
		local var_354_1 = manager.audio:GetLocalizationFlag()

		if var_354_0[var_354_1] ~= nil then
			arg_354_1.duration_ = var_354_0[var_354_1]
		end

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
			arg_354_1.auto_ = false
		end

		function arg_354_1.playNext_(arg_356_0)
			arg_354_1.onStoryFinished_()
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(arg_354_1.actors_["1086"]) and arg_354_1.var_.actorSpriteComps1086 == nil then
				arg_354_1.var_.actorSpriteComps1086 = arg_354_1.actors_["1086"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_357_0 = 0.125

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 and not isNil(arg_354_1.actors_["1086"]) then
				if arg_354_1.var_.actorSpriteComps1086 then
					for iter_357_0, iter_357_1 in pairs(arg_354_1.var_.actorSpriteComps1086:ToTable()) do
						if iter_357_1 then
							if arg_354_1.isInRecall_ then
								iter_357_1.color = Color.New(Mathf.Lerp(iter_357_1.color.r, arg_354_1.hightColor1.r, (arg_354_1.time_ - 0) / var_357_0), Mathf.Lerp(iter_357_1.color.g, arg_354_1.hightColor1.g, (arg_354_1.time_ - 0) / var_357_0), (Mathf.Lerp(iter_357_1.color.b, arg_354_1.hightColor1.b, (arg_354_1.time_ - 0) / var_357_0)))
							else
								local var_357_1 = Mathf.Lerp(iter_357_1.color.r, 1, (arg_354_1.time_ - 0) / var_357_0)

								iter_357_1.color = Color.New(var_357_1, var_357_1, var_357_1)
							end
						end
					end
				end
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 and not isNil(arg_354_1.actors_["1086"]) and arg_354_1.var_.actorSpriteComps1086 then
				for iter_357_2, iter_357_3 in pairs(arg_354_1.var_.actorSpriteComps1086:ToTable()) do
					if iter_357_3 then
						iter_357_3.color = arg_354_1.isInRecall_ and (arg_354_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_354_1.var_.actorSpriteComps1086 = nil
			end

			local var_357_2 = arg_354_1.actors_["1086"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1086 = var_357_2.localPosition
				var_357_2.localScale = Vector3.New(1, 1, 1)

				arg_354_1:CheckSpriteTmpPos("1086", 3)

				for iter_357_4 = 0, var_357_2.childCount - 1 do
					local var_357_3 = var_357_2:GetChild(iter_357_4)

					if var_357_3.name == "split_6" or not string.find(var_357_3.name, "split") then
						var_357_3.gameObject:SetActive(true)
					else
						var_357_3.gameObject:SetActive(false)
					end
				end
			end

			local var_357_4 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				var_357_2.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1086, Vector3.New(0, -404.2, -237.9), (arg_354_1.time_ - 0) / var_357_4)
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				var_357_2.localPosition = Vector3.New(0, -404.2, -237.9)
			end

			local var_357_5 = 0
			local var_357_6 = 0.2

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_5 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, true)

				arg_354_1.leftNameTxt_.text = arg_354_1:FormatText(StoryNameCfg[1080].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_354_1.leftNameTxt_.transform)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1.leftNameTxt_.text)
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_7 = arg_354_1:GetWordFromCfg(416051084)
				local var_357_8 = arg_354_1:FormatText(var_357_7.content)

				arg_354_1.text_.text = var_357_8

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_10 = 8 <= 0 and var_357_6 or var_357_6 * (utf8.len(var_357_8) / 8)

				if (8 <= 0 and var_357_6 or var_357_6 * (utf8.len(var_357_8) / 8)) > 0 and var_357_6 < var_357_10 then
					arg_354_1.talkMaxDuration = var_357_10

					if var_357_10 + var_357_5 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_10 + var_357_5
					end
				end

				arg_354_1.text_.text = var_357_8
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_416051", "416051084", "story_v_out_416051.awb") ~= 0 then
					local var_357_11 = manager.audio:GetVoiceLength("story_v_out_416051", "416051084", "story_v_out_416051.awb") / 1000

					if var_357_11 + var_357_5 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_11 + var_357_5
					end

					if var_357_7.prefab_name ~= "" and arg_354_1.actors_[var_357_7.prefab_name] ~= nil then
						local var_357_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_354_1.actors_[var_357_7.prefab_name].transform, "story_v_out_416051", "416051084", "story_v_out_416051.awb")

						arg_354_1:RecordAudio("416051084", var_357_12)
						arg_354_1:RecordAudio("416051084", var_357_12)
					else
						arg_354_1:AudioAction("play", "voice", "story_v_out_416051", "416051084", "story_v_out_416051.awb")
					end

					arg_354_1:RecordHistoryTalkVoice("story_v_out_416051", "416051084", "story_v_out_416051.awb")
				end

				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_13 = math.max(var_357_6, arg_354_1.talkMaxDuration)

			if var_357_5 <= arg_354_1.time_ and arg_354_1.time_ < var_357_5 + var_357_13 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_5) / var_357_13

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_5 + var_357_13 and arg_354_1.time_ < var_357_5 + var_357_13 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1086",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/SS1602",
		"TextureConfig/Background/I14f",
		"TextureConfig/Background/ST2101",
		"TextureConfig/Background/ST0106",
		"TextureConfig/Background/I13f"
	},
	voices = {
		"story_v_out_416051.awb"
	}
}
